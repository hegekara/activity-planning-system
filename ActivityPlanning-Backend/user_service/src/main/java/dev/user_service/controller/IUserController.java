package dev.user_service.controller;

import java.util.List;

import org.springframework.http.ResponseEntity;

import dev.dto.DtoUser;

public interface IUserController {

    public ResponseEntity<DtoUser> getUserById(String id);

    public ResponseEntity<List<DtoUser>> getAllUser();

    public ResponseEntity<DtoUser> updateUser(DtoUser dtoUser);

    public ResponseEntity<Void> changePassword(String id, String oldPassword, String newPassword);

}
