package com.eproject.parking_car.entites.customer;

import com.eproject.parking_car.entites.BaseEntity;
import com.eproject.parking_car.entites.UserEntity;
import com.eproject.parking_car.entites.supplier.ParkingImage;
import com.eproject.parking_car.entites.supplier.ParkingRental;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;
import java.util.Set;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@Entity
@Table(name = "customer_v2")
public class CustomerV2Entity extends BaseEntity {
    @Column(name = "user_document", nullable = false, unique = true)
    private String userDocument;
    @Column(name = "user_license", nullable = false, unique = true)
    private String userLicense;

    @OneToOne
    @JoinColumn(name = "user_id")
    @JsonManagedReference
    private UserEntity user;

    @JsonIgnore
    @OneToMany(mappedBy = "customerV2Id")
    private List<RegisterParkV2Entity> registerParkV2Entity;

    @JsonIgnore
    @OneToMany(mappedBy = "customerV2")
    private List<ParkingRental> parkingRentalList;
}
