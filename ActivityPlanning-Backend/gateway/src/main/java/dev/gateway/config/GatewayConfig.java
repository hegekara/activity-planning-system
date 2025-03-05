package dev.gateway.config;

import org.springframework.cloud.gateway.route.RouteLocator;
import org.springframework.cloud.gateway.route.builder.RouteLocatorBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class GatewayConfig {

    @Bean
    public RouteLocator customRouteLocator(RouteLocatorBuilder builder) {
        return builder.routes()

                .route("activity-service", r -> r.path("/activity/**")
                    .uri("lb://ACTIVITY-SERVICE"))

                .route("auth-service", r -> r.path("/auth/**")
                    .uri("lb://USER-SERVICE"))

                .route("user-service", r -> r.path("/user/**")
                    .uri("lb://USER-SERVICE"))

                .route("particiption-service", r -> r.path("/participation/**")
                    .uri("lb://PARTICIPATION-SERVICE"))

                .build();
    }
}
