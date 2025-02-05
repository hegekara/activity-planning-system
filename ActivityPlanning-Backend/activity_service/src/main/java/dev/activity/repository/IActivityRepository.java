package dev.activity.repository;

import java.util.UUID;

import org.springframework.data.jpa.repository.JpaRepository;

import dev.activity.entities.Activity;
import java.util.List;
import dev.activity.constants.Category;


public interface IActivityRepository extends JpaRepository<Activity, UUID>{

    List<Activity> findByCategory(Category category);
}
