package com.eproject.parking_car.repositories;

import com.eproject.parking_car.entites.Accounting;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AccountingRepository extends JpaRepository<Accounting, Long> {
}
