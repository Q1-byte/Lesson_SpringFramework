package org.zerock.security;

import org.junit.jupiter.api.Test;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

public class BCryptTests {
    
    @Test
    public void testEncode() {
        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
        
        String password = "1234";
        String encodedPassword = encoder.encode(password);
        
        System.out.println("===========================================");
        System.out.println("Original Password: " + password);
        System.out.println("Encoded Password: " + encodedPassword);
        System.out.println("===========================================");
        
        // 검증
        boolean matches = encoder.matches(password, encodedPassword);
        System.out.println("Password matches: " + matches);
    }
    
    @Test
    public void testMatches() {
        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
        
        String rawPassword = "1234";
        // SQL에서 사용할 해시값
        String encodedPassword = "$2a$10$k.K/LIRzC5MIvBUhMxwOauFiVH8mxU6Qf5U6aAl0qI1pYNAp2c8mK";
        
        boolean result = encoder.matches(rawPassword, encodedPassword);
        System.out.println("Match result: " + result);
    }
}
