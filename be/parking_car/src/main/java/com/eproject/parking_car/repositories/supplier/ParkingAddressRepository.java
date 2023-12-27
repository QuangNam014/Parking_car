package com.eproject.parking_car.repositories.supplier;

import com.eproject.parking_car.entites.supplier.ParkingAddress;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

public interface ParkingAddressRepository extends JpaRepository<ParkingAddress, Long> {
    @Modifying
    @Transactional
    @Query("UPDATE #{#entityName} e SET e.deletedAt =  CURRENT_TIMESTAMP, e.modifiedAt = CURRENT_TIMESTAMP where e.id = :id")
    int softDeleteById(Long id);

    ParkingAddress findByIdAndDeletedAtIsNull(Long id);
}
