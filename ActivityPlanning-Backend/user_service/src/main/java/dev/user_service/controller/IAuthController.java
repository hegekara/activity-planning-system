package dev.user_service.controller;

import org.springframework.http.ResponseEntity;

import dev.user_service.dto.DtoResponse;
import dev.user_service.dto.RegisterRequest;
import dev.user_service.dto.AuthRequest;

public interface IAuthController {

    public ResponseEntity<DtoResponse> login(AuthRequest authRequest);

    public ResponseEntity<DtoResponse> register(RegisterRequest registerRequest);

}
