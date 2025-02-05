package dev.participation.repository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import dev.participation.entities.Participation;

@Repository
public interface IParticipationRepository extends JpaRepository<Participation, UUID> {
    boolean existsByUserIdAndActivityId(UUID userId, UUID activityId);

    List<Participation> findByActivityId(UUID activityId);

    List<Participation> findByUserId(UUID userId);

    Optional<Participation> findByUserIdAndActivityId(UUID userId, UUID activityId);
}
