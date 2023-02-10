package team_project.buy_idea.service.member;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import team_project.buy_idea.entity.member.Authentication;
import team_project.buy_idea.entity.member.BasicAuthentication;
import team_project.buy_idea.entity.member.Member;
import team_project.buy_idea.entity.order.OrderInfo;
import team_project.buy_idea.entity.product.qna.QnA;
import team_project.buy_idea.entity.product.review.Review;
import team_project.buy_idea.repository.member.AuthenticationRepository;
import team_project.buy_idea.repository.member.MemberRepository;
import team_project.buy_idea.repository.order.OrderInfoRepository;
import team_project.buy_idea.repository.product.qna.QnARepository;
import team_project.buy_idea.repository.product.review.ReviewRepository;
import team_project.buy_idea.service.member.request.MemberNicknameModifyRequest;
import team_project.buy_idea.service.member.request.MemberSignUpRequest;
import team_project.buy_idea.service.member.request.MemberSignInRequest;
import team_project.buy_idea.service.security.RedisService;

import java.util.*;

@Slf4j
@Service
public class MemberServiceImpl implements MemberService {

    @Autowired
    private MemberRepository memberRepository;

    @Autowired
    private AuthenticationRepository authenticationRepository;

    @Autowired
    private RedisService redisService;

    @Autowired
    private OrderInfoRepository orderInfoRepository;

    @Autowired
    private ReviewRepository reviewRepository;

    @Autowired
    private QnARepository qnaRepository;


    @Override
    public Boolean signUp(MemberSignUpRequest request) {
        final Member member = request.toMember();
        memberRepository.save(member);

        final BasicAuthentication auth = new BasicAuthentication(member,
                Authentication.BASIC_AUTH, request.getPassword());

        authenticationRepository.save(auth);

        return true;
    }

    @Override
    public Boolean memberIdValidation(String memberId) {
        Optional<Member> maybeMemberId = memberRepository.findByMemberId(memberId);

        if (maybeMemberId.isPresent()) {
            return false;
        }

        return true;
    }

    @Override
    public Boolean memberNicknameValidation(String nickname) {
        Optional<Member> maybeMemberNickname = memberRepository.findBuyDiaMemberByNickname(nickname);

        if (maybeMemberNickname.isPresent()) {
            return false;
        }

        return true;
    }

    @Override
    public Map<String, String> signIn(MemberSignInRequest request) {
        String memberId = request.getMemberId();
        String memberType = request.getMemberType();
        Optional<Member> maybeMember = memberRepository.findByMemberIdAndMemberType(memberId, memberType);

        if (maybeMember.isPresent()) {
            Member member = maybeMember.get();

            log.info("멤버: " + maybeMember.get());

            log.info("member Id: " + member.getMemberId());
            log.info("request Id: " + request.getMemberId());
            log.info("request memberType: " + request.getMemberType());
            log.info("request password: " + request.getPassword());

            if (!member.isRightPassword(request.getPassword())) {
                throw new RuntimeException("패스워드가 잘못됐습니다.");
            }

            UUID userToken = UUID.randomUUID();

            redisService.deleteByKey(userToken.toString());
            redisService.setKeyAndValue(userToken.toString(), member.getId());

            Map<String, String> memberInfoMap = new HashMap<>();
            memberInfoMap.put("userToken", userToken.toString());
            memberInfoMap.put("memberId", member.getMemberId());
            memberInfoMap.put("nickname", member.getNickname());
            memberInfoMap.put("memberType", member.getMemberType());

            return memberInfoMap;
        }
        throw new RuntimeException("가입된 사용자가 아닙니다.");
    }

    @Override
    public Map<String, String> nicknameModify(MemberNicknameModifyRequest request) {
        Optional<Member> maybeNickname = memberRepository.findBuyDiaMemberByNickname(request.getCurrentNickname());
        List<OrderInfo> maybeOrderInfo = orderInfoRepository.findMyOrderInfoListByNickname(request.getCurrentNickname());
        List<Review> maybeReview = reviewRepository.findReviewsByWriter(request.getCurrentNickname());
        List<QnA> maybeQnA = qnaRepository.findQnaHistoryByWriter(request.getCurrentNickname());

        for (int i = 0; i < maybeOrderInfo.size(); i++) {
            OrderInfo orderInfo = maybeOrderInfo.get(i);
            orderInfo.setBuyer(request.getNickname());

            orderInfoRepository.save(orderInfo);
        }

        for (int i = 0; i < maybeReview.size(); i++) {
            Review review = maybeReview.get(i);
            review.setWriter(request.getNickname());

            reviewRepository.save(review);
        }

        for (int i = 0; i < maybeQnA.size(); i++) {
            QnA qna = maybeQnA.get(i);
            qna.setWriter(request.getNickname());

            qnaRepository.save(qna);
        }

        if (maybeNickname.isPresent()) {
            Member member = maybeNickname.get();

            maybeNickname.ifPresent(modifyMember ->{
                modifyMember.setMemberId(member.getMemberId());
                modifyMember.setNickname(request.getNickname());
                modifyMember.setMemberType(member.getMemberType());

                memberRepository.save(modifyMember);
            });

            Map<String, String> nicknameChanged = new HashMap<>();

            nicknameChanged.put("memberId", member.getMemberId());
            nicknameChanged.put("nickname", member.getNickname());
            nicknameChanged.put("memberType", member.getMemberType());

            return nicknameChanged;
        }

        throw new RuntimeException("닉네임 변경 실패");
    }

    @Override
    public void deleteMember(String currentUserToken) {
        Long memberId = redisService.getValueByKey(currentUserToken);
        log.info(String.valueOf(memberId));

        Optional<Member> maybeMemberInfo = memberRepository.findById(memberId);

        if (maybeMemberInfo.isPresent()) {
            Member memberInfo = maybeMemberInfo.get();

            memberRepository.delete(memberInfo);
        }
    }
}