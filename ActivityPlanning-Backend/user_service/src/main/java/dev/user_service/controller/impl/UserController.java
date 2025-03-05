package dev.user_service.controller.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import dev.dto.DtoUser;
import dev.user_service.controller.IUserController;
import dev.user_service.dto.PasswordRequest;
import dev.user_service.service.IUserService;


@RestController
@RequestMapping("/user")
public class UserController implements IUserController{

    @Autowired
    private IUserService userService;

    @Override
    @GetMapping("/{id}")
    public ResponseEntity<DtoUser> getUserById(@PathVariable String id) {
        return userService.getUserById(id);
    }

    @Override
    @GetMapping("/list")
    public ResponseEntity<List<DtoUser>> getAllUser() {
        return userService.getAllUser();
    }

    @Override
    @PutMapping()
    public ResponseEntity<DtoUser> updateUser(@RequestBody DtoUser dtoUser) {
        return userService.updateUser(dtoUser);
    }

    @Override
    @PatchMapping("/change-password/{id}")
    public ResponseEntity<Void> changePassword(@PathVariable String id, @RequestBody PasswordRequest passwordRequest) {

        System.out.println(passwordRequest);

        return userService.changePassword(id, passwordRequest.getOldPassword(), passwordRequest.getNewPassword());
    }

    @GetMapping("/test/{id}")
    public ResponseEntity<Void> test(@PathVariable String id, @RequestBody PasswordRequest passwordRequest) {

        System.out.println(id);
        System.out.println(passwordRequest);

        return ResponseEntity.ok().build();

    }
    
}
