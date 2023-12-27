package com.eproject.parking_car.entites;

import com.eproject.parking_car.entites.supplier.ParkingRental;
import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.Accessors;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@Accessors(chain = true)
@Entity
@Table(name = "transaction")
public class Transaction extends BaseEntity {
    @Column(name = "receiver")
    private Long receiver;

    @Column(name = "sender")
    private Long sender;

    @Column(name = "metadata")
    private String metadata;

    @OneToOne
    @JoinColumn(name = "parking_rental_id")
    @JsonManagedReference
    private ParkingRental parkingRental;

    @OneToOne(mappedBy = "transaction")
    @JsonBackReference
    private Accounting accounting;

}
