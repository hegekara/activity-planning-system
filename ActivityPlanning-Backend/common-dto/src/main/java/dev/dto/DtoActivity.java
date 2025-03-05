package dev.dto;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.UUID;

import dev.constants.Category;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class DtoActivity {

    private UUID id;

    private String activityName;

    private String description;

    private Category category;

    private LocalDate activityStartingDate;

    private LocalTime activityStartingTime;

    private Long activityDurationEstimate;

    private Double latitude;

    private Double longitude;
}
