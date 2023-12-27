package com.eproject.parking_car.repositories.customer;

import com.eproject.parking_car.entites.customer.CustomerEntity;
import com.eproject.parking_car.entites.customer.RegisterParkEntity;
import com.eproject.parking_car.entites.supplier.ParkingAddress;
import com.eproject.parking_car.entites.supplier.ParkingDetail;
import jakarta.persistence.NamedNativeQuery;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface RegisterParkRepository extends JpaRepository<RegisterParkEntity, Long> {
    @Query(nativeQuery = true, name = "RegisterParkEntity.findByParkingDetailsId")
    Optional<RegisterParkEntity> findByParkingDetailsId(@Param("id") Long id);

    @Query("SELECT r FROM RegisterParkEntity r WHERE r.customerId.id = :customerId")
    List<RegisterParkEntity> findRegisterParkEntityByCustomer(@Param("customerId") Long customerId);
}
