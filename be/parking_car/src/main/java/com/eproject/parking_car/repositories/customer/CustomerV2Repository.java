package com.eproject.parking_car.repositories.customer;

import com.eproject.parking_car.entites.customer.CustomerV2Entity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface CustomerV2Repository extends JpaRepository<CustomerV2Entity, Long> {
    Optional<CustomerV2Entity> findByUserDocument(String userDocument);

    CustomerV2Entity findByUserId(Long userId);
}
