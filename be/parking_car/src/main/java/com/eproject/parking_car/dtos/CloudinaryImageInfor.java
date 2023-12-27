package com.eproject.parking_car.dtos;

import lombok.*;
import lombok.experimental.Accessors;

@Getter
@Setter
@Accessors(chain = true)
public class CloudinaryImageInfor {
    private String name;
    private String url;
}
