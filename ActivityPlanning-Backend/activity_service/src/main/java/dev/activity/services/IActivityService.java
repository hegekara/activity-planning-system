package dev.activity.services;

import java.util.List;

import org.springframework.http.ResponseEntity;

import dev.activity.entities.Activity;
import dev.dto.DtoActivity;

public interface IActivityService {

    public ResponseEntity<Activity> getActivityById(String id);

    public ResponseEntity<List<Activity>> getActivitiesByCategory(String category);

    public ResponseEntity<List<Activity>> getAllActivities();
    
    public ResponseEntity<DtoActivity> createActivity(DtoActivity dtoActivity);

    public ResponseEntity<DtoActivity> updateActivity(String id, DtoActivity dtoActivity);

    public ResponseEntity<Void> deleteActivity(String id);
}
