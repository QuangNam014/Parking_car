package com.eproject.parking_car.services;

import com.eproject.parking_car.entites.UserEntity;
import com.eproject.parking_car.repositories.AuthRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.Collections;

@Service
public class AuthorUserDetailService implements UserDetailsService {

    @Autowired
    AuthRepository authRepository;

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        UserEntity userEntity = authRepository.findByEmail(email);

        if (userEntity != null) {
            return new org.springframework.security.core.userdetails.User(userEntity.getEmail(),
                    userEntity.getPassword(), Collections.singleton(new SimpleGrantedAuthority(userEntity.getRole().toString())));
        }else{
            throw new UsernameNotFoundException("Invalid email or password.");
        }
    }
}
