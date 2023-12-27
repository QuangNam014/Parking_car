package com.eproject.parking_car.requests.customer;

import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

@Getter
@Setter
@Accessors(chain = true)
public class CustomerInforRequest {
    @NotEmpty(message = "userDocument is not empty")
    @Size(min = 12, max = 12, message = "userDocument phải chứa đúng 12 ký tự")
    private String userDocument;
    @NotEmpty(message = "userLicense is not empty")
    private String userLicense;
}
