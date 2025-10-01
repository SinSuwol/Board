// src/main/java/com/example/board/controller/CommentController.java
package com.example.board.controller;

import com.example.board.service.CommentService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

@Controller
@RequestMapping("/comment")
@RequiredArgsConstructor
public class CommentController {

	private final CommentService commentService;

	// com.example.board.controller.CommentController

	@PostMapping("/add")
	public String add(@RequestParam("boardId") Long boardId,
	                  @RequestParam("content") String content,
	                  HttpSession session, Model model) {
		// ★ 로그인 검사
		Object uid = session.getAttribute("loginUserId");
		if (uid == null) {
			model.addAttribute("msg", "로그인이 필요한 서비스입니다.");
			model.addAttribute("redirectUrl", "/user/login");
			return "common/alert";
		}

		String writer = (String) session.getAttribute("loginUsername");
		if (writer == null || writer.isBlank()) {
			model.addAttribute("msg", "로그인 정보를 확인할 수 없습니다. 다시 로그인해 주세요.");
			model.addAttribute("redirectUrl", "/user/login");
			return "common/alert";
		}
		if (content == null || content.isBlank()) {
			String msg = java.net.URLEncoder.encode("댓글 내용을 입력해 주세요.", java.nio.charset.StandardCharsets.UTF_8);
			return "redirect:/board/" + boardId + "?toast=" + msg;
		}

		commentService.add(boardId, writer, content);
		String msg = java.net.URLEncoder.encode("댓글이 등록되었습니다.", java.nio.charset.StandardCharsets.UTF_8);
		return "redirect:/board/" + boardId + "?toast=" + msg;
	}

	@PostMapping("/delete/{id}")
	public String delete(@PathVariable("id") Long id,
	                     @RequestParam("boardId") Long boardId,
	                     HttpSession session, Model model) {
		// ★ 로그인 검사
		String writer = (String) session.getAttribute("loginUsername");
		if (writer == null) {
			model.addAttribute("msg", "로그인이 필요한 서비스입니다.");
			model.addAttribute("redirectUrl", "/user/login");
			return "common/alert";
		}
		try {
			commentService.delete(id, writer);
			String msg = java.net.URLEncoder.encode("댓글이 삭제되었습니다.", java.nio.charset.StandardCharsets.UTF_8);
			return "redirect:/board/" + boardId + "?toast=" + msg;
		} catch (IllegalStateException e) {
			model.addAttribute("msg", e.getMessage());
			model.addAttribute("redirectUrl", "/board/" + boardId);
			return "common/alert";
		}
	}

}
