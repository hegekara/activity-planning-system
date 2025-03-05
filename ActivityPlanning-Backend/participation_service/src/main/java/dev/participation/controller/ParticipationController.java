package dev.participation.controller;

import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import dev.dto.DtoActivity;
import dev.participation.entities.Participation;
import dev.participation.service.ParticipationService;

@RestController
@RequestMapping("/participation")
public class ParticipationController {

    @Autowired
    private ParticipationService participationService;
    

    @GetMapping("/check-user-participation")
    public ResponseEntity<Void> checkUserParticipation(@RequestHeader String userId, @RequestHeader String activityId) {
        return participationService.checkUserParticipation(UUID.fromString(userId), UUID.fromString(activityId));
    }
    

    @PostMapping("/register")
    public ResponseEntity<Participation> registerUserToActivity(
            @RequestHeader String userId, 
            @RequestHeader String activityId) {
        return participationService.registerUserToActivity(UUID.fromString(userId), UUID.fromString(activityId));
    }

    @GetMapping("/activity")
    public ResponseEntity<List<Participation>> getParticipantsByActivity(@RequestHeader String activityId) {
        return participationService.getParticipantsByActivity(UUID.fromString(activityId));
    }

    @GetMapping("/user")
    public ResponseEntity<List<DtoActivity>> getUserActivities(@RequestHeader String userId) {
        return participationService.getUserActivities(UUID.fromString(userId));
    }

    @DeleteMapping("/unregister")
    public ResponseEntity<Void> deleteParticipation(
            @RequestHeader String userId, 
            @RequestHeader String activityId) {
        return participationService.deleteParticipation(UUID.fromString(userId), UUID.fromString(activityId));
    }

}
