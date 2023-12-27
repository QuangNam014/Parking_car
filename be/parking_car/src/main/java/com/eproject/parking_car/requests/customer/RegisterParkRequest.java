package com.eproject.parking_car.requests.customer;

import jakarta.validation.constraints.*;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

@Getter
@Setter
@Accessors(chain = true)
public class RegisterParkRequest {
    private Long id;
    private Long totalTime;
    private double totalPrice;
    private String parkingTimeStart;
    private String parkingTimeEnd;
}
