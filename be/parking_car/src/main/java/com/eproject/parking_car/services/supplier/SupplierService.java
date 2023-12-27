package com.eproject.parking_car.services.supplier;

import com.eproject.parking_car.entites.enums.RentalStatusEnum;
import com.eproject.parking_car.entites.supplier.ParkingDetail;
import com.eproject.parking_car.entites.supplier.ParkingRental;
import com.eproject.parking_car.repositories.supplier.ParkingDetailRepository;
import com.eproject.parking_car.repositories.supplier.ParkingRentalRepository;
import com.eproject.parking_car.requests.supplier.UpdateStatusParkingRegisterCancel;
import com.eproject.parking_car.requests.supplier.UpdateStatusParkingRegisterSuccess;
import com.eproject.parking_car.requests.supplier.UpdateStatusParkingRentalCancel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;
import java.util.List;
import java.util.Optional;

@Service
public class SupplierService {

    @Autowired
    private ParkingDetailRepository parkingDetailRepository;

    @Autowired
    private ParkingRentalRepository parkingRentalRepository;

    public List<ParkingDetail> getAllParkingDetail() {
        return parkingDetailRepository.findAllByDeletedAtIsNull();
    }

}
