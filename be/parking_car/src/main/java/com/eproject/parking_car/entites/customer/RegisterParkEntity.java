package com.eproject.parking_car.entites.customer;

import com.eproject.parking_car.entites.BaseEntity;
import com.eproject.parking_car.entites.enums.RegisterStatusEnum;
import com.eproject.parking_car.entites.supplier.ParkingDetail;
import com.fasterxml.jackson.annotation.JsonBackReference;
import jakarta.persistence.*;
import lombok.*;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Currency;

@Entity
@Data
@Table(name = "register_park")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@NamedNativeQuery(
        name = "RegisterParkEntity.findByParkingDetailsId",
        query = "SELECT * FROM register_park WHERE parking_details_id = :id",
        resultClass = RegisterParkEntity.class
)
public class RegisterParkEntity extends BaseEntity {
    @Column(name = "customer_address", nullable = false)
    private String customerAddress;

    @Column(name = "parking_time_start", nullable = false)
    private Timestamp parkingTimeStart;

    @Column(name = "parking_time_end", nullable = false)
    private Timestamp parkingTimeEnd;

    @Column(name = "total_time", nullable = false)
    private long totalTime;

    @Column(name = "total_price", nullable = false)
    private double totalPrice;

    @Column(name = "status")
    @Enumerated(EnumType.STRING)
    private RegisterStatusEnum status;

    @ManyToOne
    @JoinColumn(name = "customer_id", nullable = false, referencedColumnName = "id")
    private CustomerEntity customerId;

    @ManyToOne
    @JoinColumn(name = "parking_details_id", nullable = false, referencedColumnName = "id")
    private ParkingDetail parkingDetailsId;


}