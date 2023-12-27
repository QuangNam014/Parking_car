package com.eproject.parking_car.response.user;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
public class UpdateInforByUserResponse {
    private String fullname;
    private String phone;
}
