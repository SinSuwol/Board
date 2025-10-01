package com.example.board.repository;

import com.example.board.entity.Board;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface BoardRepository extends JpaRepository<Board, Long> {
    Page<Board> findByWriterIgnoreCase(String writer, Pageable pageable); 
    Page<Board> findByTitleContainingIgnoreCase(String keyword, Pageable pageable);
    Page<Board> findByWriterContainingIgnoreCase(String keyword, Pageable pageable);
    Page<Board> findByTitleContainingIgnoreCaseOrWriterContainingIgnoreCase(String k1, String k2, Pageable pageable);

}


