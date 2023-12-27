package com.eproject.parking_car.requests.supplier;

import com.eproject.parking_car.dtos.CloudinaryImageInfor;
import lombok.Getter;
import lombok.Setter;


import java.util.Set;

@Getter
@Setter
public class ParkingDetailImageRequest {
    private Long id;
    Set<CloudinaryImageInfor> listImage;
}
