package com.example.user.controller;

import com.example.user.entity.User;
import com.example.board.service.BoardService;
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
    private final BoardService boardService;

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
            return "redirect:/";
        } catch (IllegalArgumentException e) {
            model.addAttribute("error", e.getMessage());
            return "user/login";
        }
    }

    @GetMapping("/mypage")
    public String mypage(@RequestParam(name="page", defaultValue="0") int page,
                         @RequestParam(name="size", defaultValue="10") int size,
                         HttpSession session, Model model) {
        String username = (String) session.getAttribute("loginUsername"); // 아이디
        String name     = (String) session.getAttribute("loginName");      // 사용자 이름
        if (username == null) {
            model.addAttribute("msg", "로그인이 필요합니다.");
            model.addAttribute("redirectUrl", "/user/login");
            return "common/alert";
        }

        var myPosts = boardService.findMinePaged(username, name, page, size);
        model.addAttribute("username", username);
        model.addAttribute("page", myPosts);
        model.addAttribute("size", size);
        return "user/mypage";
    }


    
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();              // 세션 완전 종료
        return "redirect:/?logout=1";      // 표시용 파라미터
    }
}
