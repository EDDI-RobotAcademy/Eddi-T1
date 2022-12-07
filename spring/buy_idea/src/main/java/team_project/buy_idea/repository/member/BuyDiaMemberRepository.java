package team_project.buy_idea.repository.member;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import team_project.buy_idea.entity.member.BuyDiaMember;

import java.util.Optional;


public interface BuyDiaMemberRepository extends JpaRepository<BuyDiaMember, Long> {

    @Query("select m from BuyDiaMember m where m.memberId = :memberId")
    Optional<BuyDiaMember> findByMemberId(@Param("memberId") String memberId);

    Optional<BuyDiaMember> findBuyDiaMemberByNickName(String nickName);

}
