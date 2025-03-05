package dev.user_service.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import dev.dto.DtoUser;
import dev.user_service.entities.User;
import dev.user_service.repository.IUserRepository;
import dev.user_service.service.IUserService;

@Service
public class UserServiceImpl implements IUserService{

    @Autowired
    private IUserRepository userRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Override
    public ResponseEntity<DtoUser> getUserById(String id) {
        try {
            Optional<User> optional = userRepository.findById(UUID.fromString(id));

            if(optional.isPresent()){
                User user = optional.get();

                DtoUser dtoUser = new DtoUser();

                BeanUtils.copyProperties(user, dtoUser);

                return ResponseEntity.ok().body(dtoUser);
            }

            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    @Override
    public ResponseEntity<List<DtoUser>> getAllUser() {

        try {
            List<User> userList = userRepository.findAll();

            if(!userList.isEmpty()){

                List<DtoUser> dtoUsers = new ArrayList<>();
                for (User user : userList) {
                    DtoUser dtoUser = new DtoUser();
                    BeanUtils.copyProperties(user, dtoUser);
                    dtoUsers.add(dtoUser);
                }

                return ResponseEntity.ok().body(dtoUsers);
            }
            
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        } catch (Exception e) {
            
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
        
    }

    @Override
    public ResponseEntity<DtoUser> updateUser(DtoUser dtoUser) {
        try {
            Optional<User> optionalUser = userRepository.findById(dtoUser.getId());
            if (optionalUser.isPresent()) {
                User user = optionalUser.get();
                
                BeanUtils.copyProperties(dtoUser, user, "id"); 
                userRepository.save(user);

                DtoUser updatedDtoUser = new DtoUser();
                BeanUtils.copyProperties(user, updatedDtoUser);

                return ResponseEntity.ok().body(updatedDtoUser);
            }

            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    @Override
    public ResponseEntity<Void> changePassword(String id, String oldPassword, String newPassword) {
        try {
            Optional<User> optionalUser = userRepository.findById(UUID.fromString(id));
            if (optionalUser.isPresent()) {
                User user = optionalUser.get();

                if (passwordEncoder.matches(oldPassword, user.getPassword())) {
                    user.setPassword(newPassword);
                    System.out.println("şifre değişti : " +newPassword);
                    userRepository.save(user);
                    System.out.println("kullanıcı kaydedildi" + user);
                    return ResponseEntity.ok().build();
                }

                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
            }

            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }
}
