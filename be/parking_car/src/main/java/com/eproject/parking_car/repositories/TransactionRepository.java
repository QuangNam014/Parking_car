package com.eproject.parking_car.repositories;

import com.eproject.parking_car.entites.Transaction;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface TransactionRepository extends JpaRepository<Transaction, Long> {

    List<Transaction> findAllByDeletedAtIsNull();
}
