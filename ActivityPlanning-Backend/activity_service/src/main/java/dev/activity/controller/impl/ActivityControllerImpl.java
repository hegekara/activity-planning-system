package dev.activity.controller.impl;

import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import dev.activity.controller.IActivityController;
import dev.activity.entities.Activity;
import dev.activity.services.IActivityService;
import dev.constants.Category;
import dev.dto.DtoActivity;

@RestController
@RequestMapping("/activity")
public class ActivityControllerImpl implements IActivityController{

    @Autowired
    private IActivityService activityService;

    @Override
    @GetMapping("/{id}")
    public ResponseEntity<Activity> getActivityById(@PathVariable String id) {
        return activityService.getActivityById(id);
    }

    @Override
    @GetMapping("/category")
    public ResponseEntity<List<Activity>> getActivitiesByCategory(@RequestParam String categoryName) {
        return activityService.getActivitiesByCategory(categoryName);
    }

    @Override
    @GetMapping("/all")
    public ResponseEntity<List<Activity>> getAllActivities() {
        return activityService.getAllActivities();
    }

    @Override
    @PostMapping("/create")
    public ResponseEntity<DtoActivity> createActvity(@RequestBody DtoActivity dtoActivity) {
        return activityService.createActivity(dtoActivity);
    }

    @Override
    @PutMapping("/edit/{id}")
    public ResponseEntity<DtoActivity> updateActivity(@PathVariable String id, @RequestBody DtoActivity dtoActivity) {
        return activityService.updateActivity(id, dtoActivity);
    }

    @Override
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteActivity(@PathVariable String id) {
        return activityService.deleteActivity(id);
    }

    @Override
    @GetMapping("/categories")
    public ResponseEntity<List<Category>> getCategoryList() {
        return ResponseEntity.ok().body(Arrays.asList(Category.values()));
    }

    @Override
    @GetMapping("/control")
    public ResponseEntity<Void> control() {
        return ResponseEntity.ok().build();
    }

}
