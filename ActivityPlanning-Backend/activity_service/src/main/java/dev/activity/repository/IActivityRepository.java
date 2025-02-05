package dev.activity.repository;

import java.util.UUID;

import org.springframework.data.jpa.repository.JpaRepository;

import dev.activity.entities.Activity;
import dev.constants.Category;

import java.util.List;


public interface IActivityRepository extends JpaRepository<Activity, UUID>{

    List<Activity> findByCategory(Category category);
}
