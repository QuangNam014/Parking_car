package com.eproject.parking_car.response.supplier;

import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

@Getter
@Setter
@Accessors(chain = true)
public class SynthesizeDataResponse {
    private int totalSuccess;
    private int totalCancel;
    private int totalAllSlot;
    private int totalTransaction;
}
