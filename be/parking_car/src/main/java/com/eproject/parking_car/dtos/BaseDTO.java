package com.eproject.parking_car.dtos;

import lombok.Data;

import java.sql.Timestamp;

@Data
public class BaseDTO {
    private Long id;
    private Timestamp createdAt;
    private Timestamp modifiedAt;
    private Timestamp deletedAt;
}
