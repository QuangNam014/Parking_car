package com.eproject.parking_car.repositories.customer;

import com.eproject.parking_car.entites.customer.CustomerEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface CustomerRepository extends JpaRepository<CustomerEntity, Long> {
    Optional<CustomerEntity> findByUserDocument(String userDocument);

    CustomerEntity findByUserId(Long userId);
}
