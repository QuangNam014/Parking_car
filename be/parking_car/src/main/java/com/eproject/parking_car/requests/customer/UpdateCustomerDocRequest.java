package com.eproject.parking_car.requests.customer;

import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

@Getter
@Setter
@Accessors(chain = true)
public class UpdateCustomerDocRequest {
    private String userDocument;
    private String userLicense;
}
