package com.example.board.controller;

import com.example.board.service.BoardService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequiredArgsConstructor
public class MainController {

    private final BoardService boardService;

    // MainController.java
    @GetMapping("/")
    public String home(@RequestParam(name="page", defaultValue="0") int page,
                       @RequestParam(name="size", defaultValue="10") int size,
                       @RequestParam(name="type", required=false) String type,
                       @RequestParam(name="keyword", required=false) String keyword,
                       Model model) {
        var boardPage = boardService.findAllPaged(type, keyword, page, size);
        model.addAttribute("page", boardPage);
        model.addAttribute("type", type);
        model.addAttribute("keyword", keyword);
        model.addAttribute("size", size);
        return "board/list";
    }

}
