package com.eproject.parking_car.services;

import com.eproject.parking_car.dtos.UserDTO;
import com.eproject.parking_car.entites.UserEntity;
import com.eproject.parking_car.entites.UserImageEntity;
import com.eproject.parking_car.entites.customer.CustomerEntity;
import com.eproject.parking_car.entites.customer.CustomerV2Entity;
import com.eproject.parking_car.repositories.UserImageRepository;
import com.eproject.parking_car.repositories.UserRepository;
import com.eproject.parking_car.requests.user.ChangePasswordRequest;
import com.eproject.parking_car.requests.user.UpdateInforByAdminRequest;
import com.eproject.parking_car.requests.user.UpdateInforByUserRequest;
import com.eproject.parking_car.response.user.UpdateInforByUserResponse;
import com.eproject.parking_car.response.user.UserDetailInforResponse;
import com.eproject.parking_car.utils.TransferDataUtils;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class UserService {

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private UserImageRepository userImageRepository;

    public UserEntity findByEmail(String email) {
        return userRepository.findByEmail(email);
    }

    public List<UserDTO> getList() {
        ModelMapper modelMapper = new ModelMapper();
        List<UserEntity> listUserEntity = userRepository.findAll();

        List<UserDTO> listUserDTO = listUserEntity.stream()
                .map(entity -> modelMapper.map(entity, UserDTO.class))
                .collect(Collectors.toList());
        
        return listUserDTO;
    }

    public UpdateInforByUserResponse updateInforByUser(UpdateInforByUserRequest updateInforByUserRequest) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String email = authentication.getName();

        // Retrieve the user's current password from the database
        UserEntity userEntity = findByEmail(email);
        if(userEntity == null) {
            return null;
        }

        UserImageEntity userImage = userEntity.getImage();

        if(userImage == null) {
            UserImageEntity userImageEntity = new UserImageEntity()
                    .setImageName(updateInforByUserRequest.getImageName())
                    .setImageUrl(updateInforByUserRequest.getImageUrl())
                    .setUserImage(userEntity);
            userImageRepository.save(userImageEntity);

        } else {
            userImage.setImageName(updateInforByUserRequest.getImageName());
            userImage.setImageUrl(updateInforByUserRequest.getImageUrl());
            userImageRepository.save(userImage);
        }

        TransferDataUtils<UserEntity, UpdateInforByUserRequest> transferRequest = new TransferDataUtils<>();
        UserEntity user = transferRequest.DTOToEntity(updateInforByUserRequest, userEntity);

        UserEntity updatedUser = userRepository.save(user);

        TransferDataUtils<UserEntity, UpdateInforByUserResponse> transferResponese = new TransferDataUtils<>();
        UpdateInforByUserResponse updateInforByUserResponse = transferResponese.EntityToDTO(updatedUser, new UpdateInforByUserResponse());

        return updateInforByUserResponse;
    }

    public UserEntity updateInforByAdmin(UpdateInforByAdminRequest updateInforByAdminRequest) {
        Optional<UserEntity> optionalUserEntity = userRepository.findById(updateInforByAdminRequest.getId());
        if(!optionalUserEntity.isPresent()) {
            return null;
        }
        UserEntity userEntity = optionalUserEntity.get();
        TransferDataUtils<UserEntity, UpdateInforByAdminRequest> transferRequest = new TransferDataUtils<>();
        UserEntity user = transferRequest.DTOToEntity(updateInforByAdminRequest, userEntity);

        UserEntity updatedUser = userRepository.save(user);

//        TransferDataUtils<UserEntity, UpdateInforByAdminResponse> transferResponese = new TransferDataUtils<>();
//        UpdateInforByAdminResponse updateInforByAdminResponse = transferResponese.EntityToDTO(updatedUser, new UpdateInforByAdminResponse());

        return updatedUser;
}

    public boolean deleteUser(Long id) {
        Optional<UserEntity> optionalUserEntity = userRepository.findById(id);
        if (optionalUserEntity.isPresent()) {
            UserEntity userEntity = optionalUserEntity.get();
            userRepository.delete(userEntity);
            return true;
        } return false;
    }

    public boolean changePassword(ChangePasswordRequest changePasswordRequest) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String email = authentication.getName();

        // Retrieve the user's current password from the database
        UserEntity userEntity = findByEmail(email);

        if (!changePasswordRequest.getPassword().equals(changePasswordRequest.getConfirmPassword())) {
            return false;
        }

        // Hash the new password
        String newPasswordHash = passwordEncoder.encode(changePasswordRequest.getPassword());

        TransferDataUtils<UserEntity, ChangePasswordRequest> transfer = new TransferDataUtils<>();
        UserEntity user = transfer.DTOToEntity(changePasswordRequest, userEntity);
        user.setPassword(newPasswordHash);
        userRepository.save(user);
        return true;
    }

    public UserDetailInforResponse getDetailInforUser() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String email = authentication.getName();

        // Retrieve the user's current password from the database
        UserEntity userEntity = findByEmail(email);
        if(userEntity == null) {
            return null;
        }

        UserImageEntity userImageEntity =  userEntity.getImage();
//        CustomerEntity customerEntity = userEntity.getCustomer();
        CustomerV2Entity customerV2Entity = userEntity.getCustomerV2();
        UserDetailInforResponse userInfor =  new UserDetailInforResponse();

        TransferDataUtils<UserEntity, UserDetailInforResponse> transferUser = new TransferDataUtils<>();
        transferUser.EntityToDTO(userEntity, userInfor);

        userInfor.setCreatedAt(userEntity.getCreatedAt());

        if(userImageEntity != null) {
            userInfor.setImageName(userImageEntity.getImageName());
            userInfor.setImageUrl(userImageEntity.getImageUrl());
        }

        if(customerV2Entity != null) {
            userInfor.setUserDocument(customerV2Entity.getUserDocument());
            userInfor.setUserLicense(customerV2Entity.getUserLicense());
        }
        return userInfor;

    }
}
