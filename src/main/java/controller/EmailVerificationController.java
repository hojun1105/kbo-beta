package controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import service.EmailService;
import service.VerificationService;

@Controller
public class EmailVerificationController {

    private final EmailService emailService;
    private final VerificationService verificationService;

    public EmailVerificationController(EmailService emailService,
                                       VerificationService verificationService) {
        this.emailService = emailService;
        this.verificationService = verificationService;
    }

    @PostMapping(value = "/sendVerification", produces = "text/plain;charset=UTF-8")
    @ResponseBody
    public String sendCode(@RequestParam("email") String email) {
        String code = verificationService.generateCode(email);
        emailService.sendVerificationEmail(email, code);
        return "인증 코드 전송 완료";
    }

    @PostMapping(value = "/verifyCode", produces = "text/plain; charset=UTF-8")
    @ResponseBody
    public String verifyCode(@RequestParam String email, @RequestParam String code) {
        boolean success = verificationService.verifyCode(email, code);
        return success ? "인증 성공!" : "인증 실패!";
    }
}
