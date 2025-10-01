// src/main/java/com/example/board/entity/Comment.java
package com.example.board.entity;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

@Entity
@Table(name = "board_comment")
@Getter @Setter
@NoArgsConstructor @AllArgsConstructor @Builder
public class Comment {

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // 어떤 게시글의 댓글인지
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "board_id", nullable = false)
    private Board board;

    @Column(nullable = false, length = 1000)
    private String content;

    @Column(nullable = false, length = 100)
    private String writer;   // 로그인 아이디

    @Column(nullable = false)
    private LocalDateTime createdAt;

    @PrePersist
    public void prePersist(){
        if (createdAt == null) createdAt = LocalDateTime.now();
    }

    // JSP fmt:formatDate용
    public Date getCreatedAtDate() {
        return createdAt == null ? null :
                Date.from(createdAt.atZone(ZoneId.systemDefault()).toInstant());
    }
}
