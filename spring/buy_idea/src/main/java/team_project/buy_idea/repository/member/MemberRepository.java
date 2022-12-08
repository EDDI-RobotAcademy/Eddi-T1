package team_project.buy_idea.repository.member;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import team_project.buy_idea.entity.member.Member;

import java.util.Optional;


public interface MemberRepository extends JpaRepository<Member, Long> {

    @Query("select m from Member m where m.memberId = :memberId")
    Optional<Member> findByMemberId(@Param("memberId") String memberId);

    Optional<Member> findBuyDiaMemberByNickName(String nickName);

    @Query("select m from Member m where m.memberId = :memberId and m.memberType = :memberType")
    Optional<Member> findByMemberIdAndMemberType(@Param("memberId") String memberId,
                                                 @Param("memberType") String memberType);

}
