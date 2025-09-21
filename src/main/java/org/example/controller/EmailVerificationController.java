package org.example.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.example.service.EmailService;
import org.example.service.VerificationService;

import java.util.HashMap;
import java.util.Map;

@Controller
public class EmailVerificationController {

    private final EmailService emailService;
    private final VerificationService verificationService;
    private final Map<String, String> codeStore = new HashMap<>();


    public EmailVerificationController(EmailService emailService,
                                       VerificationService verificationService) {
        this.emailService = emailService;
        this.verificationService = verificationService;
    }

    @PostMapping(value = "/sendVerification", produces = "text/plain;charset=UTF-8")
    @ResponseBody
    public String sendCode(@RequestParam("email") String email) {
        String code = verificationService.generateCode(email);
        codeStore.put(email, code);
        emailService.sendVerificationEmail(email, code);
        return "인증 코드 전송 완료";
    }

    @PostMapping(value = "/verifyCode", produces = "text/plain; charset=UTF-8")
    @ResponseBody
    public ResponseEntity<String> verifyCode(@RequestParam("email") String email, @RequestParam("code") String code) {
        String storedCode = codeStore.get(email);
        if(storedCode !=null && storedCode.equals(code)) {
            return ResponseEntity.ok("인증성공!");
        }
        else{
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("인증 실패 ❌");
        }}
}
