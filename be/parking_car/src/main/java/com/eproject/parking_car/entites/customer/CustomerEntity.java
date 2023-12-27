package com.eproject.parking_car.entites.customer;

import com.eproject.parking_car.entites.BaseEntity;
import com.eproject.parking_car.entites.UserEntity;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import jakarta.persistence.*;
import lombok.*;

import java.util.List;

@Entity
@Data
@Table(name = "customer")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class CustomerEntity extends BaseEntity {

    @Column(name = "user_document", nullable = false, unique = true)
    private String userDocument;
    @Column(name = "user_license", nullable = false, unique = true)
    private String userLicense;
    @Column(name = "payment_info", nullable = false)
    private String paymentInfo;

    @JsonIgnore
    @OneToOne
    @JoinColumn(name = "user_id") // Tùy chỉnh tên cột khóa ngoại
    private UserEntity user;

    @JsonIgnore
    @OneToMany(mappedBy = "customerId", cascade = CascadeType.ALL)
    private List<RegisterParkEntity> registerParkEntity;
}
