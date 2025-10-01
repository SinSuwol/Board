package com.example.user.dto;

import jakarta.validation.constraints.NotBlank;
import lombok.Data;

@Data
public class RegisterRequest {
	@NotBlank
	private String username;
	@NotBlank
	private String password;
	@NotBlank
	private String name;
	private String phone;
}