// src/main/java/com/example/board/service/CommentService.java
package com.example.board.service;

import com.example.board.entity.Board;
import com.example.board.entity.Comment;
import com.example.board.repository.BoardRepository;
import com.example.board.repository.CommentRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class CommentService {
    private final CommentRepository commentRepository;
    private final BoardRepository boardRepository;

    public List<Comment> listByBoard(Long boardId) {
        return commentRepository.findByBoardIdOrderByIdDesc(boardId);
    }

    @Transactional
    public Comment add(Long boardId, String writer, String content) {
        Board board = boardRepository.findById(boardId).orElseThrow();
        Comment c = Comment.builder()
                .board(board)
                .writer(writer)
                .content(content)
                .build();
        return commentRepository.save(c);
    }

    @Transactional
    public void delete(Long commentId, String requester) {
        Comment c = commentRepository.findById(commentId).orElseThrow();
        if (!c.getWriter().equals(requester)) {
            throw new IllegalStateException("삭제 권한이 없습니다.");
        }
        commentRepository.delete(c);
    }
}
