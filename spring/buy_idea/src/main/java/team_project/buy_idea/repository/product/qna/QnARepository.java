package team_project.buy_idea.repository.product.qna;

import io.lettuce.core.dynamic.annotation.Param;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import team_project.buy_idea.entity.product.Product;
import team_project.buy_idea.entity.product.qna.AnswerStatus;
import team_project.buy_idea.entity.product.qna.QnA;

import java.util.List;

public interface QnARepository extends JpaRepository<QnA, Long> {

    @Query("select distinct q from QnA q join fetch q.product where q.writer = :writer")
    List<QnA> findQnaHistoryByWriter(String writer);

    @Query("select distinct q from QnA q join fetch q.product p where p.productNo = :productNo")
    List<QnA> findQnaHistoryByProductNo(Long productNo);

    @Query("select q from QnA q join fetch q.product p " +
            "where p.nickname = :nickname and q.answerStatus = :answerStatus order by q.qnaNo desc")
    List<QnA> findQnaHistoryByNicknameAndAnswerStatus(@Param("nickname") String nickname,
                                                      @Param("answerStatus") AnswerStatus answerStatus);

    @Query("select count(q) from QnA q join q.product where q.product.nickname = :seller")
    Long countQnABySeller(@Param("seller") String seller);
}
