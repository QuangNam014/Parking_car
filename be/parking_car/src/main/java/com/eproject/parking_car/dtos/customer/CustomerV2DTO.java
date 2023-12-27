package com.eproject.parking_car.dtos.customer;

import com.eproject.parking_car.dtos.BaseDTO;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.Size;
import lombok.Data;

@Data
public class CustomerV2DTO extends BaseDTO {
    @NotEmpty(message = "userDocument is not empty")
    @Size(min = 12, max = 12, message = "userDocument phải chứa đúng 12 ký tự")
    private String userDocument;
    @NotEmpty(message = "userLicense is not empty")
    @Size(min = 12, max = 12, message = "userLicense phải chứa đúng 12 ký tự")
    private String userLicense;

}
