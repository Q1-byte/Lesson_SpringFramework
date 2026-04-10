package org.zerock.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.log4j.Log4j2;

@Controller
@Log4j2
public class AccountController {
    
    @GetMapping("/account/login")
    public String loginPage() {
        log.info("Login Page");
        return "account/login";
    }
    
    @GetMapping("/accessDenied")
    public String accessDenied() {
        log.info("Access Denied");
        return "account/accessDenied";
    }
}
