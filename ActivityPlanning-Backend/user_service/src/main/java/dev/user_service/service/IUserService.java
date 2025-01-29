package dev.user_service.service;

import java.util.List;

import org.springframework.http.ResponseEntity;

import dev.user_service.dto.DtoUser;

public interface IUserService {

    public ResponseEntity<DtoUser> getUserById(String id);

    public ResponseEntity<List<DtoUser>> getAllUser();

    public ResponseEntity<DtoUser> updateUser(DtoUser dtoUser);

    public ResponseEntity<Void> changePassword(String id, String oldPassword, String newPassword);

}
