package com.eproject.parking_car.entites.supplier;

import com.eproject.parking_car.entites.BaseEntity;
import com.eproject.parking_car.entites.Transaction;
import com.eproject.parking_car.entites.UserEntity;
import com.eproject.parking_car.entites.UserImageEntity;
import com.eproject.parking_car.entites.customer.CustomerV2Entity;
import com.eproject.parking_car.entites.customer.RegisterParkV2Entity;
import com.eproject.parking_car.entites.enums.RentalStatusEnum;
import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import jakarta.persistence.*;
import lombok.*;

import java.sql.Timestamp;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@Entity
@Table(name = "parking_rental")
public class ParkingRental extends BaseEntity {
    @Column(name = "totalPrice")
    private Double totalPrice;

    @Column(name = "totalTime")
    private Long totalTime;

    @Column(name = "status")
    @Enumerated(EnumType.STRING)
    private RentalStatusEnum status;

    @OneToOne
    @JoinColumn(name = "register_park_id")
    @JsonManagedReference
    private RegisterParkV2Entity registerParkV2;

    @ManyToOne
    @JoinColumn(name = "customer_id")
    private CustomerV2Entity customerV2;

    @OneToOne(mappedBy = "parkingRental")
    @JsonBackReference
    private Transaction transaction;
}
