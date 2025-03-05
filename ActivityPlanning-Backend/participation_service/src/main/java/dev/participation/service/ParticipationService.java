package dev.participation.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import dev.dto.DtoActivity;
import dev.participation.entities.Participation;
import dev.participation.feigns.IActivityServiceClient;
import dev.participation.repository.IParticipationRepository;

@Service
public class ParticipationService {

    @Autowired
    private IParticipationRepository participationRepository;

    @Autowired
    private IActivityServiceClient activityServiceClient;

    public ResponseEntity<Void> checkUserParticipation(UUID userId, UUID activityId){
        try {
            boolean exists = participationRepository.existsByUserIdAndActivityId(userId, activityId);

            if (exists) {
                return ResponseEntity.ok().build();
            }

            return ResponseEntity.status(HttpStatus.CONFLICT).build();

        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    public ResponseEntity<Participation> registerUserToActivity(UUID userId, UUID activityId) {
        try {
            boolean exists = participationRepository.existsByUserIdAndActivityId(userId, activityId);

            if (exists) {
                return ResponseEntity.status(HttpStatus.CONFLICT).build();
            }

            Participation participation = new Participation(null, userId, activityId);
            participationRepository.save(participation);
            return ResponseEntity.ok(participation);

        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    public ResponseEntity<List<Participation>> getParticipantsByActivity(UUID activityId) {
        try {
            List<Participation> participations = participationRepository.findByActivityId(activityId);
            return ResponseEntity.ok(participations);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    public ResponseEntity<List<DtoActivity>> getUserActivities(UUID userId) {
        try {
            List<Participation> participationList = participationRepository.findByUserId(userId);
            List<DtoActivity> activities = new ArrayList<>();
            for (Participation participation : participationList) {
                DtoActivity activity = activityServiceClient.getActivityById(participation.getActivityId()).getBody();
                activities.add(activity);
            }
            return ResponseEntity.ok(activities);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    public ResponseEntity<Void> deleteParticipation(UUID userId, UUID activityId) {
        try {
            Optional<Participation> participation = participationRepository.findByUserIdAndActivityId(userId, activityId);
    
            if (participation.isPresent()) {
                participationRepository.delete(participation.get());
                return ResponseEntity.ok().build();
            } else {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
            }
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }
}
