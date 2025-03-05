package dev.participation.starter;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.cloud.openfeign.EnableFeignClients;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

@EnableJpaRepositories(basePackages = {"dev.participation"})
@EntityScan(basePackages = {"dev.participation"})
@ComponentScan(basePackages = {"dev.participation"})
@SpringBootApplication(scanBasePackages = {"dev.participation"})
@EnableFeignClients(basePackages = {"dev.participation"})
public class ParticipationServiceApplication {

	public static void main(String[] args) {
		SpringApplication.run(ParticipationServiceApplication.class, args);
	}

}
