package com.eproject.parking_car.response.auth;

import lombok.Builder;
import lombok.Data;

@Builder
@Data
public class SignInResponse {
    private String token;
}
