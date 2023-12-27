package com.eproject.parking_car.requests.supplier;

import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

@Getter
@Setter
@Accessors(chain = true)
public class EditParkingDetailRequest {
    private Long id;

    @NotNull(message = "price is not empty")
    @Min(value = 1, message = "Price must be greater than 0")
    private double price;

    @Min(value = 1, message = "Total slot must be greater than 0")
    @NotNull(message = "totalSlot is not empty")
    private int totalSlot;

//    @NotNull(message = "status is not empty")
//    private DetailStatusEnum status;


    @NotEmpty(message = "city is not empty")
    private String city;

    @NotEmpty(message = "district is not empty")
    private String district;

    @NotEmpty(message = "ward is not empty")
    private String ward;

    @NotEmpty(message = "street is not empty")
    private String street;

    @NotEmpty(message = "longitude is not empty")
    private String longitude;

    @NotEmpty(message = "latitude is not empty")
    private String latitude;
}
