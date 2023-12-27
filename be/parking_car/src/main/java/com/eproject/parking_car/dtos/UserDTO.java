package com.eproject.parking_car.dtos;

import com.eproject.parking_car.entites.enums.RoleEnum;
import lombok.Data;

@Data
public class UserDTO extends BaseDTO {
    private String fullname;
    private String email;
    private String phone;
    private RoleEnum role;
}
