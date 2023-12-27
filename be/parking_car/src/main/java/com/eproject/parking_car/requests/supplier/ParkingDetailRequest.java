package com.eproject.parking_car.requests.supplier;

import com.eproject.parking_car.dtos.CloudinaryImageInfor;
import com.eproject.parking_car.entites.enums.DetailStatusEnum;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.*;
import lombok.experimental.Accessors;

import java.util.Set;

@Getter
@Setter
@Accessors(chain = true)
public class ParkingDetailRequest {

    @NotNull(message = "price is not empty")
    @Min(value = 1, message = "Price must be greater than 0")
    private double price;

    @Min(value = 1, message = "Total slot must be greater than 0")
    @NotNull(message = "totalSlot is not empty")
    private int totalSlot;

    private DetailStatusEnum status;


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


    @Size(min = 1, message = "List of images must not be empty")
    Set<CloudinaryImageInfor> listImage;
}
