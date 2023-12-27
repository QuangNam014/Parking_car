package com.eproject.parking_car.response.user;

import jakarta.persistence.Column;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

import java.sql.Timestamp;

@Getter
@Setter
@Accessors(chain = true)
public class UserDetailInforResponse {
    private String fullname;
    private String email;
    private String phone;
    private Double wallet;
    private Timestamp createdAt;

    private String imageName;
    private String imageUrl;

    private String userDocument;
    private String userLicense;
    private String paymentInfo;


}
