package team_project.buy_idea.repository.member;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import team_project.buy_idea.entity.member.BuyDiaMember;

import java.util.Optional;


public interface BuyDiaMemberRepository extends JpaRepository<BuyDiaMember, Long> {

}
