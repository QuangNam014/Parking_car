package com.eproject.parking_car.repositories.supplier;

import com.eproject.parking_car.entites.enums.DetailStatusEnum;
import com.eproject.parking_car.entites.supplier.ParkingDetail;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import java.util.Optional;

public interface ParkingDetailRepository extends JpaRepository<ParkingDetail, Long> {
    @Modifying
    @Transactional
    @Query("UPDATE #{#entityName} e SET e.deletedAt =  CURRENT_TIMESTAMP, e.modifiedAt = CURRENT_TIMESTAMP where e.id = :id")
    int softDeleteById(Long id);

    ParkingDetail findByIdAndDeletedAtIsNull(Long id);

    List<ParkingDetail> findAllByDeletedAtIsNull();

    List<ParkingDetail> findAllByDeletedAtIsNullAndSupplierId(Long supplierId);

    List<ParkingDetail> findAllByDeletedAtIsNullAndStatus(DetailStatusEnum status);
}
