package com.eproject.parking_car.dtos.customer;

import com.eproject.parking_car.dtos.BaseDTO;
import com.eproject.parking_car.entites.supplier.ParkingDetail;
import jakarta.validation.constraints.*;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class RegisterParkV2DTO extends BaseDTO {

    @NotEmpty(message = "Parking Details Id is not empty")
    @Digits(integer = 10, fraction = 0, message = "Parking Details Id must be an integer")
    private Long parkingDetailsId;

    @NotEmpty(message = "Parking Time Start is not empty")
    @Future(message = "Parking Time Start must be a future date")
    @PastOrPresent(message = "Parking Time Start must be in the past or present")
    @Pattern(regexp = "\\d{4}-\\d{2}-\\d{2} \\d{2}:\\d{2}:\\d{2}", message = "Invalid Timestamp format")
    private String parkingTimeStart;

    @NotEmpty(message = "Parking Time End is not empty")
    @Past(message = "Parking Time End must be a past date")
    @FutureOrPresent(message = "Parking Time End must be in the future or present")
    @Pattern(regexp = "\\d{4}-\\d{2}-\\d{2} \\d{2}:\\d{2}:\\d{2}", message = "Invalid Timestamp format")
    private String parkingTimeEnd;

    @NotEmpty(message = "Total Price is not empty")
    @DecimalMin(value = "0.0", inclusive = true, message = "Total Price must be a non-negative number")
    private double totalPrice;

    @NotEmpty(message = "Total Time is not empty")
    private long totalTime;

    public ParkingDetail convertToParkingDetail() {
        ParkingDetail parkingDetail = new ParkingDetail();
        parkingDetail.setId(this.parkingDetailsId);
        // Các trường khác của ParkingDetail có thể được thiết lập tại đây
        return parkingDetail;
    }
}
