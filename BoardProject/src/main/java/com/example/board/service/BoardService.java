package com.example.board.service;

import com.example.board.entity.Board;
import com.example.board.repository.BoardRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.data.domain.*;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class BoardService {
    private final BoardRepository boardRepository;

    public List<Board> findAll() {
        return boardRepository.findAll();
    }

    public Optional<Board> findById(Long id) {
        return boardRepository.findById(id);
    }

    public Board save(Board board) {
        return boardRepository.save(board);
    }

    public void delete(Long id) {
        boardRepository.deleteById(id);
    }
    
    public Board update(Long id, String title, String content) {
        Board b = boardRepository.findById(id).orElseThrow();
        b.setTitle(title);
        b.setContent(content);
        return boardRepository.save(b);
    }
    
    
    public Page<Board> findMinePaged(String username, String name, int page, int size) {
        Pageable pageable = PageRequest.of(page, size, Sort.by(Sort.Direction.DESC, "id"));
        // 1) 아이디로 먼저
        Page<Board> p = boardRepository.findByWriterIgnoreCase(username, pageable);
        if (p.isEmpty() && name != null && !name.isBlank()) {
            // 2) 결과 없으면 이름으로 한 번 더
            p = boardRepository.findByWriterIgnoreCase(name, pageable);
        }
        return p;
    }
    
    public Page<Board> findAllPaged(String type, String keyword, int page, int size) {
        Pageable pageable = PageRequest.of(page, size, Sort.by(Sort.Direction.DESC, "id"));
        if (keyword == null || keyword.isBlank()) {
            return boardRepository.findAll(pageable);
        }
        return switch (type == null ? "all" : type) {
            case "title"  -> boardRepository.findByTitleContainingIgnoreCase(keyword, pageable);
            case "writer" -> boardRepository.findByWriterContainingIgnoreCase(keyword, pageable);
            default       -> boardRepository.findByTitleContainingIgnoreCaseOrWriterContainingIgnoreCase(keyword, keyword, pageable);
        };
    }
}
