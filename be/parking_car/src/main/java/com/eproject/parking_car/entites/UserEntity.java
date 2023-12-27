package com.eproject.parking_car.entites;

import com.eproject.parking_car.entites.customer.CustomerEntity;
import com.eproject.parking_car.entites.customer.CustomerV2Entity;
import com.eproject.parking_car.entites.enums.RoleEnum;
import com.fasterxml.jackson.annotation.JsonBackReference;
import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.SQLDelete;
import org.hibernate.annotations.Where;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@Entity
@Table(name = "user")
@SQLDelete(sql = "UPDATE user SET deleted_at = CURRENT_TIMESTAMP, modified_at = CURRENT_TIMESTAMP WHERE id = ?")
@Where(clause = "deleted_at is null")
public class UserEntity extends BaseEntity {
    @Column(name = "fullname", nullable = false)
    private String fullname;

    @Column(name = "email", unique = true, nullable = false)
    private String email;

    @Column(name = "password", nullable = false)
    private String password;

    @Column(name = "phone", nullable = false)
    private String phone;

    @Column(name = "wallet", nullable = false)
    private Double wallet = 0.0;

    @Column(name = "role")
    @Enumerated(EnumType.STRING)
    private RoleEnum role;

    @OneToOne(mappedBy = "user")
    private CustomerEntity customer;

    @OneToOne(mappedBy = "userImage")
    @JsonBackReference
    private UserImageEntity image;

    @OneToOne(mappedBy = "user")
    @JsonBackReference
    private CustomerV2Entity customerV2;
}
