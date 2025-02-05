package dev.participation.feigns;

import java.util.UUID;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import dev.dto.DtoUser;

@FeignClient(name = "user-service")
public interface IUserServiceClient {

    @GetMapping("/user/{userId}")
    ResponseEntity<DtoUser> getUserById(@PathVariable UUID userId);
}
