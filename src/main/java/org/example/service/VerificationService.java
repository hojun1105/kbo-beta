package org.example.service;
import org.springframework.stereotype.Service;
import java.util.Random;
import java.util.concurrent.ConcurrentHashMap;

@Service
public class VerificationService {

    private final ConcurrentHashMap<String, String> codeStore = new ConcurrentHashMap<>();

    public String generateCode(String email) {
        var code = String.valueOf(new Random().nextInt(899999) + 100000); // 6자리 코드
        codeStore.put(email, code);
        return code;
    }

    public boolean verifyCode(String email, String inputCode) {
        return codeStore.containsKey(email) && codeStore.get(email).equals(inputCode);
    }
}
