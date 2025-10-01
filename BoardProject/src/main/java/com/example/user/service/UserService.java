package com.example.user.service;

import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.stereotype.Service;

import com.example.user.dto.LoginRequest;
import com.example.user.dto.RegisterRequest;
import com.example.user.entity.User;
import com.example.user.repository.UserRepository;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class UserService {

    private final UserRepository repo;

    @Transactional
    public Long register(RegisterRequest req) {
        if (repo.existsByUsername(req.getUsername())) {
            throw new IllegalArgumentException("이미 존재하는 아이디입니다.");
        }
        User u = new User();
        u.setUsername(req.getUsername());
        u.setPassword(BCrypt.hashpw(req.getPassword(), BCrypt.gensalt()));
        u.setName(req.getName());
        u.setPhone(req.getPhone());
        u.setRole("USER");
        return repo.save(u).getId();
    }

    public User login(LoginRequest req) {
        User user = repo.findByUsername(req.getUsername())
                .orElseThrow(() -> new IllegalArgumentException("아이디 또는 비밀번호가 올바르지 않습니다."));
        if (!BCrypt.checkpw(req.getPassword(), user.getPassword())) {
            throw new IllegalArgumentException("아이디 또는 비밀번호가 올바르지 않습니다.");
        }
        return user;
    }
}