package com.eproject.parking_car.services.customer;

import com.eproject.parking_car.dtos.CloudinaryImageInfor;
import com.eproject.parking_car.dtos.customer.CustomerDTO;
import com.eproject.parking_car.dtos.customer.CustomerV2DTO;
import com.eproject.parking_car.entites.UserEntity;
import com.eproject.parking_car.entites.customer.CustomerEntity;
import com.eproject.parking_car.entites.customer.CustomerV2Entity;
import com.eproject.parking_car.entites.enums.DetailStatusEnum;
import com.eproject.parking_car.entites.supplier.ParkingAddress;
import com.eproject.parking_car.entites.supplier.ParkingDetail;
import com.eproject.parking_car.entites.supplier.ParkingImage;
import com.eproject.parking_car.repositories.UserRepository;
import com.eproject.parking_car.repositories.customer.CustomerRepository;
import com.eproject.parking_car.repositories.customer.CustomerV2Repository;
import com.eproject.parking_car.repositories.supplier.ParkingDetailRepository;
import com.eproject.parking_car.requests.customer.CustomerInforRequest;
import com.eproject.parking_car.requests.customer.UpdateCustomerDocRequest;
import com.eproject.parking_car.response.customer.ParkingDetailAvailableResponse;
import com.eproject.parking_car.response.user.UserDetailInforResponse;
import com.eproject.parking_car.services.UserService;
import com.eproject.parking_car.utils.TransferDataUtils;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.Set;
import java.util.stream.Collectors;

@Service
public class CustomerService {
    @Autowired
    private CustomerRepository customerRepository;

    @Autowired
    private CustomerV2Repository customerV2Repository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private ParkingDetailRepository parkingDetailRepository;

    public boolean addCustomerInfoToUser(CustomerDTO customerDTO) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String email = authentication.getName();
        UserEntity user  = userRepository.findByEmail(email);

        if (user  != null)
        {
            CustomerEntity customer = new CustomerEntity();
            customer.setUserDocument(customerDTO.getUserDocument());
            customer.setUserLicense(customerDTO.getUserLicense());
            customer.setPaymentInfo(customerDTO.getPaymentInfo());
            customer.setUser(user);
            customerRepository.save(customer);

            return true;
        }
        return false;
    }

    public boolean editCustomerInfo(CustomerDTO customerDTO) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String email = authentication.getName();
        UserEntity user = userRepository.findByEmail(email);


        if(user != null) {
            if (user.getCustomer() != null) {
                CustomerEntity customer = user.getCustomer();
                customer.setUserDocument(customerDTO.getUserDocument());
                customer.setUserLicense(customerDTO.getUserLicense());
                customer.setPaymentInfo(customerDTO.getPaymentInfo());

                // Lưu cập nhật vào cơ sở dữ liệu
                customerRepository.save(customer);

                return true;
            }
        }
        return false;
    }

    public List<CustomerDTO> getListCustomerByCCCD() {
        ModelMapper modelMapper = new ModelMapper();
        List<CustomerEntity> customerEntityList = customerRepository.findAll();
        List<CustomerDTO> customerDTOList = customerEntityList.stream()
                .map(entity -> modelMapper.map(entity,CustomerDTO.class))
                .collect(Collectors.toList());

        return  customerDTOList;
    }

    public List<CustomerV2DTO> getListCustomerByCCCDV2() {
        ModelMapper modelMapper = new ModelMapper();
        List<CustomerV2Entity> customerEntityList = customerV2Repository.findAll();
        List<CustomerV2DTO> customerDTOList = customerEntityList.stream()
                .map(entity -> modelMapper.map(entity, CustomerV2DTO.class))
                .collect(Collectors.toList());

        return  customerDTOList;
    } // test

    public CustomerEntity findCustomerByUserDocument(String userDocument) {
        Optional<CustomerEntity> customerEntity = customerRepository.findByUserDocument(userDocument);

        if (customerEntity.isPresent()) {
            CustomerEntity customer = customerEntity.get();
            return customer;
        } else {
            return null;
        }
    }

    public CustomerV2Entity findCustomerByUserDocumentV2(String userDocument) {
        Optional<CustomerV2Entity> customerEntity = customerV2Repository.findByUserDocument(userDocument);

        if (customerEntity.isPresent()) {
            CustomerV2Entity customer = customerEntity.get();
            return customer;
        } else {
            return null;
        }
    } // test

    public CustomerEntity getCustomerById(Long id) {
        Optional<CustomerEntity> customer = customerRepository.findById(id);
        return customer.orElse(null);
    }

    public boolean createCustomerInfor(CustomerInforRequest customerInforRequest) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String email = authentication.getName();
        UserEntity user  = userRepository.findByEmail(email);

        if (user  != null)
        {
            CustomerV2Entity customerV2 = new CustomerV2Entity();
            customerV2.setUserDocument(customerInforRequest.getUserDocument());
            customerV2.setUserLicense(customerInforRequest.getUserLicense());
            customerV2.setUser(user);
            customerV2Repository.save(customerV2);
            return true;
        }
        return false;
    }

    public List<ParkingDetailAvailableResponse> getListParkAvailable() {
        List<ParkingDetail> parkingDetailList =  parkingDetailRepository.findAllByDeletedAtIsNullAndStatus(DetailStatusEnum.AVAILABLE);

        List<ParkingDetailAvailableResponse> listData = new ArrayList<>();
        for (ParkingDetail item: parkingDetailList) {
            ParkingAddress address = item.getParkingAddress();
            Set<ParkingImage> image = item.getParkingImages();
            CloudinaryImageInfor imageInfor = new CloudinaryImageInfor();

            ParkingImage firstImage = image.iterator().next();

            imageInfor.setName(firstImage.getImageName()).setUrl(firstImage.getImageUrl());

            ParkingDetailAvailableResponse data = new ParkingDetailAvailableResponse();
            data.setId(item.getId()).setPrice(item.getPrice()).setTotalSlot(item.getTotalSlot()).setCity(address.getCity())
                    .setDistrict(address.getDistrict()).setWard(address.getWard()).setStreet(address.getStreet())
                    .setLatitude(address.getLatitude()).setLongitude(address.getLongitude()).setImage(imageInfor);

            if(item.getTotalSlot() > 0) {
                listData.add(data);
            }

        }

        if(listData.isEmpty()) {
            return null;
        } return listData;
    }

    public boolean updateCustomerInforDoc(UpdateCustomerDocRequest updateCustomerDocRequest) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String email = authentication.getName();
        UserEntity user  = userRepository.findByEmail(email);

        if (user != null) {
            CustomerV2Entity customerV2 = customerV2Repository.findByUserId(user.getId());
            if (customerV2 != null) {
                customerV2.setUserDocument(updateCustomerDocRequest.getUserDocument());
                customerV2.setUserLicense(updateCustomerDocRequest.getUserLicense());
                customerV2Repository.save(customerV2);

                return true;
            }
        }
        return false;
    }
}
