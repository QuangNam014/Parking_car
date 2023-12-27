package com.eproject.parking_car.entites;

import com.eproject.parking_car.entites.supplier.ParkingRental;
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
@Table(name = "accounting")
public class Accounting extends BaseEntity {
    @Column(name = "revenue")
    private Double revenue;

    @Column(name = "profit")
    private Double profit;

    @Column(name = "expense")
    private Double expense;

    @OneToOne
    @JoinColumn(name = "transaction_id")
    @JsonManagedReference
    private Transaction transaction;
}
