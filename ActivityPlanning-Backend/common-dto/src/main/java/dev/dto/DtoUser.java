package dev.dto;

import java.util.UUID;

import dev.constants.Role;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@AllArgsConstructor
@NoArgsConstructor
public class DtoUser {
    private UUID id;
    private String username;
    private Role role;
}
