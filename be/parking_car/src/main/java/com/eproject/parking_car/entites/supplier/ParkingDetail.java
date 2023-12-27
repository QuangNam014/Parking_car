package com.eproject.parking_car.entites.supplier;

import com.eproject.parking_car.entites.BaseEntity;
import com.eproject.parking_car.entites.UserEntity;
import com.eproject.parking_car.entites.customer.RegisterParkV2Entity;
import com.eproject.parking_car.entites.enums.DetailStatusEnum;
import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import jakarta.persistence.*;
import lombok.*;

import java.util.List;
import java.util.Set;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@Entity
@Table(name = "parking_detail")
public class ParkingDetail extends BaseEntity {
    @Column(name = "price", nullable = false)
    private double price;

    @Column(name = "total_slot", nullable = false)
    private int totalSlot;

    @Column(name = "status")
    @Enumerated(EnumType.STRING)
    private DetailStatusEnum status;

    @ManyToOne(fetch = FetchType.LAZY)
    @JsonBackReference
    private UserEntity supplier;

    @OneToOne(cascade = CascadeType.ALL,fetch = FetchType.EAGER)
    @JoinColumn(name = "parking_address_id")
    @JsonManagedReference
    private ParkingAddress parkingAddress;

    @OneToMany(fetch = FetchType.LAZY ,orphanRemoval = true)
    @JoinColumn(name="parking_detail_id")
    @JsonManagedReference
    private Set<ParkingImage> parkingImages;

    @JsonIgnore
    @OneToMany(mappedBy = "parkingDetailsId")
    private List<RegisterParkV2Entity> registerParkV2Entity;
}
