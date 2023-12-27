package com.eproject.parking_car.requests.user;

import jakarta.validation.constraints.NotEmpty;
import lombok.Data;

@Data
public class ChangePasswordRequest {
    @NotEmpty(message = "password is not empty")
    private String password;
    @NotEmpty(message = "confirm password is not empty")
    private String confirmPassword;
}
