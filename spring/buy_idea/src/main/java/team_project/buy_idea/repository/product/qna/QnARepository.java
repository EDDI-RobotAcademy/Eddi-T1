package team_project.buy_idea.repository.product.qna;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import team_project.buy_idea.entity.product.Product;
import team_project.buy_idea.entity.product.qna.QnA;

import java.util.List;

public interface QnARepository extends JpaRepository<QnA, Long> {

    @Query("select distinct q from QnA q join fetch q.product where q.writer = :writer")
    List<QnA> findQnaHistoryByWriter(String writer);

    @Query("select distinct q from QnA q join fetch q.product p where p.productNo = :productNo")
    List<QnA> findQnaHistoryByProductNo(Long productNo);
}
