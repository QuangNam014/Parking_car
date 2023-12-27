package com.eproject.parking_car.requests.supplier;

import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

@Getter
@Setter
@Accessors(chain = true)
public class EditParkingDetailInforRequest {
    private Long id;
    @NotNull(message = "price is not empty")
    @Min(value = 1, message = "Price must be greater than 0")
    private double price;

    @Min(value = 1, message = "Total slot must be greater than 0")
    @NotNull(message = "totalSlot is not empty")
    private int totalSlot;
}
