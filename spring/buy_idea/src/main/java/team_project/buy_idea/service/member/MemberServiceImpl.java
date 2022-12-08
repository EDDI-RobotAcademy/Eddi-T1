package team_project.buy_idea.service.member;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import team_project.buy_idea.entity.member.Authentication;
import team_project.buy_idea.entity.member.BasicAuthentication;
import team_project.buy_idea.entity.member.Member;
import team_project.buy_idea.repository.member.AuthenticationRepository;
import team_project.buy_idea.repository.member.MemberRepository;
import team_project.buy_idea.service.member.request.MemberRegisterRequest;
import team_project.buy_idea.service.member.request.MemberSignInRequest;
import team_project.buy_idea.service.security.RedisService;

import java.util.Optional;
import java.util.UUID;

@Slf4j
@Service
public class MemberServiceImpl implements MemberService {

    @Autowired
    private MemberRepository memberRepository;

    @Autowired
    private AuthenticationRepository authenticationRepository;

    @Autowired
    private RedisService redisService;


    @Override
    public Boolean signUp(MemberRegisterRequest request) {
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

        if (maybeMemberId.isPresent()){
            return false;
        }

        return true;
    }

    @Override
    public Boolean memberNicknameValidation(String nickName) {
        Optional<Member> maybeMemberNickname = memberRepository.findBuyDiaMemberByNickName(nickName);

        if (maybeMemberNickname.isPresent()) {
            return false;
        }

        return true;
    }

    @Override
    public String signIn(MemberSignInRequest request) {
        String memberId = request.getMemberId();
        String memberType = request.getMemberType();
        Optional<Member> maybeMember = memberRepository.findByMemberIdAndMemberType(memberId, memberType);

        if (maybeMember.isPresent()) {
            Member member = maybeMember.get();

            log.info("멤버: " + maybeMember.get());

            log.info("member email: " + member.getMemberId());
            log.info("request email: " + request.getMemberId());
            log.info("request password: " + request.getPassword());

            if (!member.isRightPassword(request.getPassword())) {
                throw new RuntimeException("패스워드가 잘못됐습니다.");
            }

            UUID userToken = UUID.randomUUID();

            redisService.deleteByKey(userToken.toString());
            redisService.setKeyAndValue(userToken.toString(), member.getId());

            return userToken.toString();
        }

        throw new RuntimeException("가입된 사용자가 아닙니다.");
    }
}
