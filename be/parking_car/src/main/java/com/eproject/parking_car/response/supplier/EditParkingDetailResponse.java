package com.eproject.parking_car.response.supplier;

import com.eproject.parking_car.entites.enums.DetailStatusEnum;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

@Getter
@Setter
@Accessors(chain = true)
public class EditParkingDetailResponse {
    private double price;
    private int totalSlot;
    private DetailStatusEnum status;

    private String city;
    private String district;
    private String ward;
    private String street;
    private String longitude;
    private String latitude;
}
