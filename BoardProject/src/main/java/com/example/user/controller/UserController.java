package com.example.user.controller;

import com.example.user.entity.User;
import com.example.user.dto.LoginRequest;
import com.example.user.dto.RegisterRequest;
import com.example.user.service.UserService;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequiredArgsConstructor
@RequestMapping("/user")
public class UserController {

    private final UserService userService;

    @GetMapping("/register")
    public String registerForm() {
        return "user/register";
    }

    @PostMapping("/register")
    public String register(@Valid RegisterRequest req, Model model) {
        try {
            userService.register(req);
            model.addAttribute("msg", "회원가입이 완료되었습니다. 로그인 해주세요.");
            model.addAttribute("redirectUrl", "/user/login");
            return "common/alert";
        } catch (IllegalArgumentException e) {
            model.addAttribute("error", e.getMessage());
            return "user/register";
        }
    }

    @GetMapping("/login")
    public String loginForm() {
        return "user/login";
    }

    @PostMapping("/login")
    public String login(@Valid LoginRequest req, HttpSession session, Model model) {
        try {
            User user = userService.login(req);
            session.setAttribute("loginUserId", user.getId());
            session.setAttribute("loginUsername", user.getUsername());
            session.setAttribute("loginName", user.getName());
            session.setAttribute("loginRole", user.getRole());
            return "redirect:/user/mypage";
        } catch (IllegalArgumentException e) {
            model.addAttribute("error", e.getMessage());
            return "user/login";
        }
    }

    @GetMapping("/mypage")
    public String mypage(HttpSession session, Model model) {
        Object uid = session.getAttribute("loginUserId");
        if (uid == null) return "redirect:/user/login";
        model.addAttribute("username", session.getAttribute("loginUsername"));
        model.addAttribute("name", session.getAttribute("loginName"));
        return "user/mypage";
    }

    @PostMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/user/login";
    }
}
