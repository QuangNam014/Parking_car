package com.eproject.parking_car.entites.supplier;

import com.eproject.parking_car.entites.BaseEntity;
import com.fasterxml.jackson.annotation.JsonBackReference;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.*;
import lombok.experimental.Accessors;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@Accessors(chain = true)
@Entity
@Table(name = "parking_image")
public class ParkingImage extends BaseEntity {
    @Column(name = "image_name")
    private String imageName;
    @Column(name = "image_url")
    private String imageUrl;

    @ManyToOne
    @JsonBackReference
    private ParkingDetail parkingDetail;
}
