package com.example.board.controller;

import com.example.board.entity.Board;
import com.example.board.service.BoardService;
import com.example.board.service.CommentService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

@Controller
@RequestMapping("/board")
@RequiredArgsConstructor
public class BoardController {

	private final BoardService boardService;
	 private final CommentService commentService; 

	@GetMapping("/list")
	public String list(@RequestParam(name = "page", defaultValue = "0") int page,
			@RequestParam(name = "size", defaultValue = "10") int size,
			@RequestParam(name = "type", required = false) String type, // title | writer | all
			@RequestParam(name = "keyword", required = false) String keyword, Model model) {

		// null/빈 문자열이면 기본값 all
		if (type == null || type.isBlank())
			type = "all";

		var boardPage = boardService.findAllPaged(type, keyword, page, size);
		model.addAttribute("page", boardPage);
		model.addAttribute("type", type);
		model.addAttribute("keyword", keyword);
		model.addAttribute("size", size);
		return "board/list";
	}

	// 작성 폼 (로그인 필요)
	@GetMapping("/write")
	public String writeForm(HttpSession session, Model model) {
		if (session.getAttribute("loginUserId") == null) {
			model.addAttribute("msg", "로그인이 필요합니다.");
			model.addAttribute("redirectUrl", "/user/login");
			return "common/alert";
		}
		return "board/write";
	}

	// 작성 처리
	@PostMapping("/write")
	public String write(@ModelAttribute Board board, HttpSession session, Model model) {
		Object uid = session.getAttribute("loginUserId");
		if (uid == null) {
			model.addAttribute("msg", "로그인이 필요합니다.");
			model.addAttribute("redirectUrl", "/user/login");
			return "common/alert";
		}
		String username = (String) session.getAttribute("loginUsername");
		board.setWriter(username);
		boardService.save(board);

		String msg = enc("등록되었습니다.");
		return "redirect:/board/list?toast=" + msg;
	}

	// 상세
	@GetMapping("/{id}")
	public String detail(@PathVariable("id") Long id, Model model) {
		var board = boardService.findById(id).orElseThrow();
		model.addAttribute("board", board);

		// 댓글 목록 추가
		model.addAttribute("comments", commentService.listByBoard(id));
		return "board/detail";
	}

	// 수정 폼 (작성자만)
	@GetMapping("/edit/{id}")
	public String editForm(@PathVariable("id") Long id, HttpSession session, Model model) {
		var board = boardService.findById(id).orElseThrow();
		String loginUsername = (String) session.getAttribute("loginUsername");
		if (loginUsername == null || !loginUsername.equals(board.getWriter())) {
			model.addAttribute("msg", "수정 권한이 없습니다.");
			model.addAttribute("redirectUrl", "/board/" + id);
			return "common/alert";
		}
		model.addAttribute("board", board);
		return "board/edit";
	}

	// 수정 처리 (작성자만)
	@PostMapping("/edit/{id}")
	public String edit(@PathVariable("id") Long id, @RequestParam("title") String title,
			@RequestParam("content") String content, HttpSession session, Model model) {

		var board = boardService.findById(id).orElseThrow();
		String loginUsername = (String) session.getAttribute("loginUsername");
		if (loginUsername == null || !loginUsername.equals(board.getWriter())) {
			model.addAttribute("msg", "수정 권한이 없습니다.");
			model.addAttribute("redirectUrl", "/board/" + id);
			return "common/alert";
		}
		boardService.update(id, title, content);

		String msg = enc("수정되었습니다.");
		return "redirect:/board/" + id + "?toast=" + msg;
	}

	// 삭제 (작성자만) - POST 권장
	@PostMapping("/delete/{id}")
	public String delete(@PathVariable("id") Long id, HttpSession session, Model model) {
		var board = boardService.findById(id).orElseThrow();
		String loginUsername = (String) session.getAttribute("loginUsername");
		if (loginUsername == null || !loginUsername.equals(board.getWriter())) {
			model.addAttribute("msg", "삭제 권한이 없습니다.");
			model.addAttribute("redirectUrl", "/board/" + id);
			return "common/alert";
		}
		boardService.delete(id);

		String msg = enc("삭제되었습니다.");
		return "redirect:/board/list?toast=" + msg;
	}

	// --- util ---
	private String enc(String s) {
		return URLEncoder.encode(s, StandardCharsets.UTF_8);
	}
}
