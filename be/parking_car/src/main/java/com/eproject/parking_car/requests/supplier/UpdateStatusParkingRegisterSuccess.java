package com.eproject.parking_car.requests.supplier;

import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

@Getter
@Setter
@Accessors(chain = true)
public class UpdateStatusParkingRegisterSuccess {
    private Long registerParkId;
    private String status;
}
