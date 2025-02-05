package dev.participation.controller;

import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import dev.participation.entities.Participation;
import dev.participation.service.ParticipationService;

@RestController
@RequestMapping("/participation")
public class ParticipationController {

    @Autowired
    private ParticipationService participationService;

    @PostMapping("/register")
    public ResponseEntity<Participation> registerUserToActivity(
            @RequestParam UUID userId, 
            @RequestParam UUID activityId) {
        return participationService.registerUserToActivity(userId, activityId);
    }

    @GetMapping("/activity/{activityId}")
    public ResponseEntity<List<Participation>> getParticipantsByActivity(@PathVariable UUID activityId) {
        return participationService.getParticipantsByActivity(activityId);
    }

    @GetMapping("/user/{userId}")
    public ResponseEntity<List<Participation>> getUserActivities(@PathVariable UUID userId) {
        return participationService.getUserActivities(userId);
    }

    @DeleteMapping("/remove")
    public ResponseEntity<Void> deleteParticipation(
            @RequestParam UUID userId, 
            @RequestParam UUID activityId) {
        return participationService.deleteParticipation(userId, activityId);
    }

}
