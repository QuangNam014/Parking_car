package com.eproject.parking_car.entites.supplier;

import com.eproject.parking_car.entites.BaseEntity;
import com.fasterxml.jackson.annotation.JsonBackReference;
import jakarta.persistence.*;
import lombok.*;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@Entity
@Table(name = "parking_address")
public class ParkingAddress extends BaseEntity {
    @Column(name = "city")
    private String city;

    @Column(name = "district")
    private String district;

    @Column(name = "ward")
    private String ward;

    @Column(name = "street")
    private String street;

    @Column(name = "longitude")
    private String longitude;

    @Column(name = "latitude")
    private String latitude;

    @OneToOne(mappedBy = "parkingAddress")
    @JsonBackReference
    private ParkingDetail parkingDetail;
}
