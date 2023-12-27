package com.eproject.parking_car.response.admin;


import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

import java.sql.Timestamp;

@Getter
@Setter
@Accessors(chain = true)
public class GetDetailTransactionResponse {
    Long id;
    Long idRental;
    String receiveName;
    String sendName;
    double totalPrice;
    double expense;
    double profit;
    Timestamp createdAt;
}
