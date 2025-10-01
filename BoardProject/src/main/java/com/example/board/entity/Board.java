package com.example.board.entity;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

@Entity
@Table(name = "board")
@Getter @Setter
@NoArgsConstructor @AllArgsConstructor
@Builder
public class Board {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;         //게시글 번호

    @Column(nullable = false)
    private String title;     // 제목

    @Column(nullable = false, length = 4000)
    private String content;   // 내용

    @Column(nullable = false)
    private String writer;    // 작성자

    @Column(nullable = false)
    private LocalDateTime createdAt;  // 작성일

    @PrePersist
    public void prePersist() {
        this.createdAt = LocalDateTime.now();
    }
    
    public Date getCreatedAtDate() {
        return createdAt == null ? null :
               Date.from(createdAt.atZone(ZoneId.systemDefault()).toInstant());
    }
}
