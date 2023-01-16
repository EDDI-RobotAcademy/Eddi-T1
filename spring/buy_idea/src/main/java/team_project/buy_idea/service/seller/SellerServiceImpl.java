package team_project.buy_idea.service.seller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import team_project.buy_idea.controller.seller.request.SellerProfileRequest;
import team_project.buy_idea.entity.member.Member;
import team_project.buy_idea.entity.seller.CompanyInfo;
import team_project.buy_idea.entity.seller.SellerProfile;
import team_project.buy_idea.repository.member.MemberRepository;
import team_project.buy_idea.repository.seller.CompanyInfoRepository;
import team_project.buy_idea.repository.seller.SellerRepository;

import java.util.Optional;

@Service
public class SellerServiceImpl implements SellerService{

    @Autowired
    private SellerRepository sellerRepository;

    @Autowired
    private CompanyInfoRepository companyInfoRepository;

    @Autowired
    private MemberRepository memberRepository;

    @Override
    public void registerSellerProfile(SellerProfileRequest sellerProfileRequest) {
        SellerProfile sellerProfile = new SellerProfile();
        CompanyInfo companyInfo = new CompanyInfo();

        String realName = sellerProfileRequest.getRealName();
        String nickname = sellerProfileRequest.getNickname();

        Optional<SellerProfile> maybeNickname = sellerRepository.findByMemberNickname(nickname);

        if (maybeNickname.isEmpty()){
            companyInfo.setStreet(sellerProfileRequest.getCompanyInfoRequest().getStreet());
            companyInfo.setCity(sellerProfileRequest.getCompanyInfoRequest().getCity());
            companyInfo.setAddressDetail(sellerProfileRequest.getCompanyInfoRequest().getAddressDetail());
            companyInfo.setZipcode(sellerProfileRequest.getCompanyInfoRequest().getZipcode());

            Optional<Member> maybeMemberNickname = memberRepository.findBuyDiaMemberByNickname(sellerProfileRequest.getNickname());
            Member member = maybeMemberNickname.get();

            sellerProfile.setRealName(realName);
            sellerProfile.setPhone(sellerProfileRequest.getPhone());
            sellerProfile.setRegistrationNumber(sellerProfileRequest.getRegistrationNumber());
            sellerProfile.setCompanyInfo(companyInfo);
            sellerProfile.setMember(member);
            sellerRepository.save(sellerProfile);

            companyInfo.setSellerProfile(sellerProfile);
            companyInfoRepository.save(companyInfo);
        }
    }
}
