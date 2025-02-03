package dev.user_service.repository;

import java.util.Optional;
import java.util.UUID;

import org.springframework.data.jpa.repository.JpaRepository;

import dev.user_service.entities.User;

public interface IUserRepository extends JpaRepository<User, UUID>{
    Optional<User> findByUsername(String username);
}
