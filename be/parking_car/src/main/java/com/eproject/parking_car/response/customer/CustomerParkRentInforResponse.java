package com.eproject.parking_car.response.customer;

import com.eproject.parking_car.dtos.CloudinaryImageInfor;
import com.eproject.parking_car.entites.enums.RentalStatusEnum;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

import java.sql.Timestamp;

@Getter
@Setter
@Accessors(chain = true)
public class CustomerParkRentInforResponse {
    private Long id;
    private Timestamp parkingTimeStart;
    private Timestamp parkingTimeEnd;
    private long totalTime;
    private double totalPrice;

    private String city;
    private String district;
    private String ward;
    private String street;

    private String fullname;
    private String userDocument;
    private String userLicense;

    private RentalStatusEnum status;
    private CloudinaryImageInfor image;
}
