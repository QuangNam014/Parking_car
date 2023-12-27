package com.eproject.parking_car.repositories;

import com.eproject.parking_car.entites.UserEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AuthRepository extends JpaRepository<UserEntity, Long> {
    UserEntity findByEmail(String email);
}
