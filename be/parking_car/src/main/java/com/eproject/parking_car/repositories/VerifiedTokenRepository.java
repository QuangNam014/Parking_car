package com.eproject.parking_car.repositories;

import com.eproject.parking_car.entites.VerifiedToken;
import org.springframework.data.jpa.repository.JpaRepository;

public interface VerifiedTokenRepository extends JpaRepository<VerifiedToken, String> {
    public VerifiedToken findByEmail(String email);
}
