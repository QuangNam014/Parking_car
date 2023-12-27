package com.eproject.parking_car.response.customer;

import com.eproject.parking_car.dtos.CloudinaryImageInfor;
import com.eproject.parking_car.entites.enums.DetailStatusEnum;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

@Getter
@Setter
@Accessors(chain = true)
public class ParkingDetailAvailableResponse {
    private Long id;
    private double price;
    private int totalSlot;

    private String city;
    private String district;
    private String ward;
    private String street;
    private String longitude;
    private String latitude;

    private CloudinaryImageInfor image;
}
