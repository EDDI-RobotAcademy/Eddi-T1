package team_project.buy_idea.service.member;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import team_project.buy_idea.entity.member.BuyDiaMember;
import team_project.buy_idea.repository.member.BuyDiaMemberRepository;
import team_project.buy_idea.service.member.request.BuyDiaMemberRegisterRequest;

@Slf4j
@Service
public class BuyDiaMemberServiceImpl implements BuyDiaMemberService {

    @Autowired
    private BuyDiaMemberRepository buyDiaMemberRepository;




    @Override
    public Boolean signUp(BuyDiaMemberRegisterRequest request) {
        final BuyDiaMember member = request.toMember();
        buyDiaMemberRepository.save(member);


        return true;
    }
}
