package dev.activity.controller;

import java.util.List;

import org.springframework.http.ResponseEntity;

import dev.activity.entities.Activity;
import dev.constants.Category;
import dev.dto.DtoActivity;

public interface IActivityController {

    public ResponseEntity<Activity> getActivityById(String id);

    public ResponseEntity<List<Activity>> getActivitiesByCategory(String category);

    public ResponseEntity<List<Activity>> getAllActivities();
    
    public ResponseEntity<DtoActivity> createActvity(DtoActivity dtoActivity);

    public ResponseEntity<DtoActivity> updateActivity(String id, DtoActivity dtoActivity);

    public ResponseEntity<Void> deleteActivity(String id);

    public ResponseEntity<List<Category>> getCategoryList();

    public ResponseEntity<Void> control();

}
