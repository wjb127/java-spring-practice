package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class HomeController {

    /**
     * 홈페이지
     */
    @GetMapping("/")
    public String home(Model model) {
        model.addAttribute("message", "Spring MVC + MyBatis + PostgreSQL 데모 애플리케이션");
        return "index";
    }

    /**
     * 상태 확인용 API
     */
    @GetMapping("/health")
    @ResponseBody
    public String health() {
        return "OK - Spring Application is running!";
    }
} 