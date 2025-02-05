package dev.activity.services.impl;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import dev.activity.entities.Activity;
import dev.activity.repository.IActivityRepository;
import dev.activity.services.IActivityService;
import dev.constants.Category;
import dev.dto.DtoActivity;

@Service
public class ActivityServiceImpl implements IActivityService {

    @Autowired
    private IActivityRepository activityRepository;

    private ModelMapper modelMapper;

    @Override
    public ResponseEntity<DtoActivity> getActivityById(String id) {
        
        try {
            Optional<Activity> optional = activityRepository.findById(UUID.fromString(id));
            if(optional.isPresent()){
                Activity activity = optional.get();
                return ResponseEntity.ok(modelMapper.map(activity, DtoActivity.class));
            } else {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
            }
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    @Override
    public ResponseEntity<List<DtoActivity>> getActivitiesByCategory(String category) {
        try {
            Category activityCategory = Category.valueOf(category.toUpperCase());
            List<Activity> activities = activityRepository.findByCategory(activityCategory);
            List<DtoActivity> dtoActivities = activities.stream()
                    .map(activity -> modelMapper.map(activity, DtoActivity.class))
                    .toList();
            return ResponseEntity.ok(dtoActivities);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    @Override
    public ResponseEntity<List<DtoActivity>> getAllActivities() {
        try {
            List<Activity> activities = activityRepository.findAll();
            List<DtoActivity> dtoActivities = activities.stream()
                    .map(activity -> modelMapper.map(activity, DtoActivity.class))
                    .toList();
            return ResponseEntity.ok(dtoActivities);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    @Override
    public ResponseEntity<DtoActivity> createActvity(DtoActivity dtoActivity) {
        try {
            Activity activity = modelMapper.map(dtoActivity, Activity.class);
            Activity savedActivity = activityRepository.save(activity);
            return ResponseEntity.ok().body(modelMapper.map(savedActivity, DtoActivity.class));
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    @Override
    public ResponseEntity<DtoActivity> updateActivity(String id, DtoActivity dtoActivity) {
        try {
            Optional<Activity> optional = activityRepository.findById(UUID.fromString(id));

            if(optional.isPresent()){
                Activity activity = optional.get();
                modelMapper.map(dtoActivity, activity);
                Activity updatedActivity = activityRepository.save(activity);
                return ResponseEntity.ok(modelMapper.map(updatedActivity, DtoActivity.class));
            }else{
                return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
            }
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    @Override
    public ResponseEntity<Void> deleteActivity(String id) {
        try {
            Optional<Activity> optional = activityRepository.findById(UUID.fromString(id));
            if(optional.isPresent()){
                Activity activity = optional.get();
                activityRepository.delete(activity);
                return ResponseEntity.ok().build();
            }else{
                return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
            }
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }
}

