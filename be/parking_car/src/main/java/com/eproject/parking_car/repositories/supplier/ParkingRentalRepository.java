package com.eproject.parking_car.repositories.supplier;

import com.eproject.parking_car.entites.customer.CustomerV2Entity;
import com.eproject.parking_car.entites.customer.RegisterParkV2Entity;
import com.eproject.parking_car.entites.enums.DetailStatusEnum;
import com.eproject.parking_car.entites.enums.RegisterStatusEnum;
import com.eproject.parking_car.entites.enums.RentalStatusEnum;
import com.eproject.parking_car.entites.supplier.ParkingDetail;
import com.eproject.parking_car.entites.supplier.ParkingRental;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface ParkingRentalRepository extends JpaRepository<ParkingRental, Long> {

    @Query("SELECT r FROM ParkingRental r WHERE r.deletedAt IS NULL AND r.customerV2 = :customerV2 AND r.status != :status")
    List<ParkingRental> findAllByStatusNotAndCustomerV2(@Param("status") RentalStatusEnum status, @Param("customerV2") CustomerV2Entity customerV2);

    @Query("SELECT r FROM ParkingRental r WHERE r.deletedAt IS NULL AND r.customerV2 = :customerV2")
    List<ParkingRental> findAllByCustomerV2(@Param("customerV2") CustomerV2Entity customerV2);

    @Query("SELECT COUNT(r) FROM ParkingRental r WHERE r.status = 'RENTING'")
    int countRenting();

    @Query("SELECT COUNT(r) FROM ParkingRental r WHERE r.status = 'CANCEL'")
    int countCancel();

    @Query("SELECT COUNT(r) FROM ParkingRental r WHERE r.status = 'FINISH'")
    int countFinish();

    @Query("SELECT COUNT(r) FROM ParkingRental r")
    int countAll();

    List<ParkingRental> findAllByDeletedAtIsNullAndStatus(RentalStatusEnum status);
}
