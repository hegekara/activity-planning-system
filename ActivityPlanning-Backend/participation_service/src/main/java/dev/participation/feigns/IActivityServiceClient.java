package dev.participation.feigns;

import java.util.UUID;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import dev.dto.DtoActivity;

@FeignClient(name = "activity-service")
public interface IActivityServiceClient {

    @GetMapping("/activity/{activityId}")
    ResponseEntity<DtoActivity> getActivityById(@PathVariable UUID activityId);

}
