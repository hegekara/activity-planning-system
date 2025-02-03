package dev.user_service.controller.impl;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;

import dev.user_service.controller.IAuthController;
import dev.user_service.dto.DtoResponse;
import dev.user_service.dto.RegisterRequest;
import dev.user_service.dto.AuthRequest;
import dev.user_service.entities.User;
import dev.user_service.repository.IUserRepository;
import dev.user_service.security.JwtUtil;

@RestController
@RequestMapping("/auth")
public class AuthController implements IAuthController {

    @Autowired
    private AuthenticationManager authenticationManager;

    @Autowired
    private IUserRepository userRepository;

    @Autowired
    private JwtUtil jwtUtil;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Override
    @PostMapping("/login")
    public ResponseEntity<DtoResponse> login(@RequestBody AuthRequest authRequest) {
        try {
            User user = userRepository.findByUsername(authRequest.getUsername())
                    .orElseThrow(() -> new BadCredentialsException("Invalid credentials"));

            /* authenticationManager.authenticate(
                    new UsernamePasswordAuthenticationToken(user.getUsername(), authRequest.getPassword())
            ); */

            String token = jwtUtil.generateToken(user.getUsername(), user.getRole());
            return ResponseEntity.ok(new DtoResponse(token, user, "Login successful"));

        } catch (BadCredentialsException e) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                    .body(new DtoResponse(null, null, "Invalid username or password"));
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(new DtoResponse(null, null, "An error occurred"));
        }
    }

    @Override
    @PostMapping("/register")
    public ResponseEntity<DtoResponse> register(@RequestBody RegisterRequest registerRequest) {
        try {
            if (userRepository.findByUsername(registerRequest.getUsername()).isPresent()) {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                        .body(new DtoResponse(null, null, "Username already exists"));
            }

            User user = new User();
            BeanUtils.copyProperties(registerRequest, user);
            user.setPassword(passwordEncoder.encode(registerRequest.getPassword()));

            userRepository.save(user);

            String token = jwtUtil.generateToken(user.getUsername(), user.getRole());
            return ResponseEntity.ok(new DtoResponse(token, user, "Registration successful"));

        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(new DtoResponse(null, null, "An error occurred"));
        }
    }
}