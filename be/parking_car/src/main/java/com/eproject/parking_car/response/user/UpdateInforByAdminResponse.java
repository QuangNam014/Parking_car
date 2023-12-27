package com.eproject.parking_car.response.user;

import com.eproject.parking_car.dtos.BaseDTO;
import lombok.Data;

@Data
public class UpdateInforByAdminResponse extends BaseDTO {
    private String fullname;
    private String email;
    private String phone;
}
