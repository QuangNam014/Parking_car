package com.eproject.parking_car.entites.customer;

import com.eproject.parking_car.entites.BaseEntity;
import com.eproject.parking_car.entites.enums.RegisterStatusEnum;
import com.eproject.parking_car.entites.supplier.ParkingDetail;
import com.eproject.parking_car.entites.supplier.ParkingRental;
import com.fasterxml.jackson.annotation.JsonBackReference;
import jakarta.persistence.*;
import lombok.*;

import java.sql.Timestamp;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@Entity
@Table(name = "register_park_v2")
public class RegisterParkV2Entity extends BaseEntity {
    @Column(name = "parking_time_start", nullable = false)
    private Timestamp parkingTimeStart;

    @Column(name = "parking_time_end", nullable = false)
    private Timestamp parkingTimeEnd;

    @Column(name = "total_time", nullable = false)
    private long totalTime;

    @Column(name = "total_price", nullable = false)
    private double totalPrice;

    @Column(name = "license", nullable = false)
    private String license;

    @Column(name = "status")
    @Enumerated(EnumType.STRING)
    private RegisterStatusEnum status;

    @ManyToOne
    @JoinColumn(name = "customer_id")
    private CustomerV2Entity customerV2Id;

    @ManyToOne
    @JoinColumn(name = "parking_details_id")
    private ParkingDetail parkingDetailsId;

    @OneToOne(mappedBy = "registerParkV2")
    @JsonBackReference
    private ParkingRental parkingRental;
}