package dev.activity.services;

import java.util.List;

import org.springframework.http.ResponseEntity;

import dev.dto.DtoActivity;

public interface IActivityService {

    public ResponseEntity<DtoActivity> getActivityById(String id);

    public ResponseEntity<List<DtoActivity>> getActivitiesByCategory(String category);

    public ResponseEntity<List<DtoActivity>> getAllActivities();
    
    public ResponseEntity<DtoActivity> createActvity(DtoActivity dtoActivity);

    public ResponseEntity<DtoActivity> updateActivity(String id, DtoActivity dtoActivity);

    public ResponseEntity<Void> deleteActivity(String id);
}
