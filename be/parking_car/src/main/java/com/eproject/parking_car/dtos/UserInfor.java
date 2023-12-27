package com.eproject.parking_car.dtos;


import com.eproject.parking_car.entites.enums.RoleEnum;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class UserInfor {
    private String fullname;
    private String email;
    private String phone;
    private RoleEnum role;
}
