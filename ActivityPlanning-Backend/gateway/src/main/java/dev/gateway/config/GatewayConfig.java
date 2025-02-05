package dev.gateway.config;

import dev.gateway.security.JwtAuthenticationFilter;
import org.springframework.cloud.gateway.route.RouteLocator;
import org.springframework.cloud.gateway.route.builder.RouteLocatorBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class GatewayConfig {

    private final JwtAuthenticationFilter jwtAuthenticationFilter;

    public GatewayConfig(JwtAuthenticationFilter jwtAuthenticationFilter) {
        this.jwtAuthenticationFilter = jwtAuthenticationFilter;
    }

    @Bean
    public RouteLocator customRouteLocator(RouteLocatorBuilder builder) {
        return builder.routes()

                .route("auth-service", r -> r.path("/auth/**")
                    .uri("lb://USER-SERVICE"))

                .route("user-service", r -> r.path("/user/**")
                    .filters(f -> f.filter(jwtAuthenticationFilter))
                    .uri("lb://USER-SERVICE"))

                .route("activity-service", r -> r.path("/activity/**")
                    .filters(f -> f.filter(jwtAuthenticationFilter))
                    .uri("lb://ACTIVITY-SERVICE"))

                .route("particiption-service", r -> r.path("/participation/**")
                    .filters(f -> f.filter(jwtAuthenticationFilter))
                    .uri("lb://PARTICIPATION-SERVICE"))

                .build();
    }
}
