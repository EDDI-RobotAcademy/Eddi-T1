package team_project.buy_idea.controller.product.qna;


import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import team_project.buy_idea.controller.product.qna.request.QuestionRegisterRequest;
import team_project.buy_idea.service.product.qna.QnAService;

@Slf4j
@RestController
@RequestMapping("/qna")
@CrossOrigin(origins = "*", allowedHeaders = "*")
public class QnAController {

    @Autowired
    private QnAService qnAService;

    /**
     * 문의 등록 Controller
     *
     * @param request ProductNo, writer, questionCategory,
     *                questionTitle, questionContent, openStatus
     */
    @PostMapping("/register")
    public void questionRegister(@RequestBody QuestionRegisterRequest request) {
        log.info("questionRegister()");
        log.info("request : " + request.toString());

        qnAService.register(request);
    }
}
