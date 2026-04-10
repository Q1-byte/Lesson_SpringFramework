package org.zerock.security;

import java.io.IOException;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.log4j.Log4j2;

@Log4j2
public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler {
    
    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
            Authentication authentication) throws IOException, ServletException {
        
        log.warn("Login Success");
        log.warn("User: " + authentication.getName());
        log.warn("Authorities: " + authentication.getAuthorities());
        
        // 관리자면 리스트 페이지로, 아니면 접근 거부 페이지로
        boolean isAdmin = authentication.getAuthorities().stream()
                .anyMatch(auth -> auth.getAuthority().equals("ROLE_ADMIN"));
        
        if (isAdmin) {
            response.sendRedirect("/product/list");
        } else {
            // 일반 사용자는 접근 거부 페이지로
            response.sendRedirect("/accessDenied");
        }
    }
}
