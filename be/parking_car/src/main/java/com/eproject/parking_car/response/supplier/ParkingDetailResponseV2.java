package com.eproject.parking_car.response.supplier;

import com.eproject.parking_car.dtos.CloudinaryImageInfor;
import com.eproject.parking_car.entites.enums.DetailStatusEnum;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

import java.util.Set;

@Getter
@Setter
@Accessors(chain = true)
public class ParkingDetailResponseV2 {
    private Long id;
    private double price;
    private int totalSlot;
    private DetailStatusEnum status;

    private String city;
    private String district;
    private String ward;
    private String street;
    private String longitude;
    private String latitude;

    Set<CloudinaryImageInfor> listImage;
}
