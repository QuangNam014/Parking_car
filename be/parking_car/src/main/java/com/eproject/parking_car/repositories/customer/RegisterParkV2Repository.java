package com.eproject.parking_car.repositories.customer;

import com.eproject.parking_car.entites.customer.CustomerV2Entity;
import com.eproject.parking_car.entites.customer.RegisterParkEntity;
import com.eproject.parking_car.entites.customer.RegisterParkV2Entity;
import com.eproject.parking_car.entites.enums.DetailStatusEnum;
import com.eproject.parking_car.entites.enums.RegisterStatusEnum;
import com.eproject.parking_car.entites.supplier.ParkingDetail;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface RegisterParkV2Repository extends JpaRepository<RegisterParkV2Entity, Long> {
//    @Query(nativeQuery = true, name = "RegisterParkEntity.findByParkingDetailsId")
//    Optional<RegisterParkV2Entity> findByParkingDetailsId(@Param("id") Long id);
//
//    @Query("SELECT r FROM RegisterParkEntity r WHERE r.customerId.id = :customerId")
//    List<RegisterParkV2Entity> findRegisterParkEntityByCustomer(@Param("customerId") Long customerId);

    @Query("SELECT r FROM RegisterParkV2Entity r WHERE r.deletedAt IS NULL AND r.customerV2Id = :customerV2Id AND r.status != :status")
    List<RegisterParkV2Entity> findAllByStatusNotAndCustomerV2Id(@Param("status") RegisterStatusEnum status, @Param("customerV2Id") CustomerV2Entity customerV2Id);
}

