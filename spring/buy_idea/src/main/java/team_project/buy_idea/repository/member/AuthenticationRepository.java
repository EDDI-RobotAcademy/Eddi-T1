package team_project.buy_idea.repository.member;

import org.springframework.data.jpa.repository.JpaRepository;
import team_project.buy_idea.entity.member.Authentication;

public interface AuthenticationRepository extends JpaRepository<Authentication, Long> {
}