package dev.user_service.security;

import java.security.Key;
import java.util.Date;

import org.springframework.stereotype.Component;

import dev.user_service.constants.Role;

import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.security.Keys;

@Component
public class JwtUtil {

    private static final Key SECRET_KEY = Keys.secretKeyFor(io.jsonwebtoken.SignatureAlgorithm.HS256);
    private final int EXPIRATION_TIME = 1000 * 60 * 60 * 3;

    public String generateToken(String username, Role role) {
        return Jwts.builder()
            .setSubject(username)
            .claim("role", role.name())
            .setIssuedAt(new Date())
            .setExpiration(new Date(System.currentTimeMillis() + EXPIRATION_TIME))
            .signWith(SECRET_KEY)
            .compact();
    }
}
