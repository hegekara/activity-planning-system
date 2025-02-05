package dev.activity.dto;

import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalTime;

import dev.activity.constants.Category;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class DtoActivity {
    private String activityName;

    private String description;

    private Category category;

    private LocalDate activityStartingDate;

    private LocalTime activityStartingTime;

    private Duration activityDurationEstimate;

    private Double lattitude;

    private Double longitude;
}
