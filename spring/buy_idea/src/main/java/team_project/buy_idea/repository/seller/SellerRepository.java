package team_project.buy_idea.repository.seller;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import team_project.buy_idea.entity.seller.SellerProfile;

import java.util.Optional;

@Repository
public interface SellerRepository extends JpaRepository<SellerProfile, Long> {

    @Query("select s from SellerProfile s where s.member.nickname = :nickname")
    Optional<SellerProfile> findByMemberNickname(@Param("nickname") String nickname);

    @Query("select s from SellerProfile s " +
            "join fetch s.member m join fetch m.authentications " +
            "join fetch s.companyInfo " +
            "where s.member.nickname = :nickname")
    Optional<SellerProfile> findBySellerInfoByNickname(@Param("nickname") String nickname);
}
