package com.eproject.parking_car.services.customer;

import com.eproject.parking_car.dtos.CloudinaryImageInfor;
import com.eproject.parking_car.dtos.customer.CustomerDTO;
import com.eproject.parking_car.dtos.customer.RegisterParkDTO;
import com.eproject.parking_car.dtos.customer.RegisterParkV2DTO;
import com.eproject.parking_car.entites.UserEntity;
import com.eproject.parking_car.entites.customer.CustomerEntity;
import com.eproject.parking_car.entites.customer.CustomerV2Entity;
import com.eproject.parking_car.entites.customer.RegisterParkEntity;
import com.eproject.parking_car.entites.customer.RegisterParkV2Entity;
import com.eproject.parking_car.entites.enums.DetailStatusEnum;
import com.eproject.parking_car.entites.enums.RegisterStatusEnum;
import com.eproject.parking_car.entites.enums.RentalStatusEnum;
import com.eproject.parking_car.entites.supplier.ParkingAddress;
import com.eproject.parking_car.entites.supplier.ParkingDetail;
import com.eproject.parking_car.entites.supplier.ParkingImage;
import com.eproject.parking_car.entites.supplier.ParkingRental;
import com.eproject.parking_car.repositories.UserRepository;
import com.eproject.parking_car.repositories.customer.CustomerRepository;
import com.eproject.parking_car.repositories.customer.CustomerV2Repository;
import com.eproject.parking_car.repositories.customer.RegisterParkRepository;
import com.eproject.parking_car.repositories.customer.RegisterParkV2Repository;
import com.eproject.parking_car.repositories.supplier.ParkingDetailRepository;
import com.eproject.parking_car.repositories.supplier.ParkingRentalRepository;
import com.eproject.parking_car.requests.customer.RegisterParkRequest;
import com.eproject.parking_car.requests.customer.UpdateStatusRegisterPark;
import com.eproject.parking_car.requests.supplier.ParkingDetailRequest;
import com.eproject.parking_car.requests.supplier.UpdateStatusParkingDetail;
import com.eproject.parking_car.response.customer.CustomerOrderParkInforResponse;
import jakarta.persistence.EntityNotFoundException;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@ComponentScan
public class RegisterParkService {
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private RegisterParkRepository registerParkRepository;
    @Autowired
    private CustomerRepository customerRepository;
    @Autowired
    private ModelMapper modelMapper;
    @Autowired
    private ParkingDetailRepository parkingDetailRepository;

    @Autowired
    private CustomerV2Repository customerV2Repository;

    @Autowired
    private RegisterParkV2Repository registerParkV2Repository;

    @Autowired
    private ParkingRentalRepository parkingRentalRepository;


    // API for customers
    public RegisterParkDTO createRegisterPark(RegisterParkDTO registerParkDTO) {
        try {
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            String email = authentication.getName();
            UserEntity user = userRepository.findByEmail(email);


            Timestamp timesStart = Timestamp.valueOf(registerParkDTO.getParkingTimeStart());
            Timestamp timesEnd = Timestamp.valueOf(registerParkDTO.getParkingTimeEnd());
//            registerParkDTO.setParkingTimeStart();

            if(user != null) {
//                var customer = customerRepository.findByUserDocument(registerParkDTO.getUserDocument());
                CustomerEntity userId = customerRepository.findByUserId(user.getId());
                Optional<CustomerEntity> customerExits = customerRepository.findById(userId.getId());
                if(customerExits == null) {
                    return null;
                }

                Optional<ParkingDetail> parkingDetailExits = parkingDetailRepository.findById(registerParkDTO.getParkingDetailsId());
                if(parkingDetailExits == null) {
                    return null;
                }

                CustomerEntity customer = customerExits.get();
                ParkingDetail parkingDetail = parkingDetailExits.get();

                RegisterParkEntity registerParkEntity = modelMapper.map(registerParkDTO,
                        RegisterParkEntity.class);
                registerParkEntity.setCustomerId(customer);
                registerParkEntity.setParkingTimeStart(timesStart);
                registerParkEntity.setParkingTimeEnd(timesEnd);
                registerParkEntity.setParkingDetailsId(parkingDetail);
                registerParkEntity.setStatus(RegisterStatusEnum.PENDING);

                RegisterParkEntity createRegisterPark = registerParkRepository.save(registerParkEntity);
                if(createRegisterPark != null) {
                    return registerParkDTO;
                }
            }
        } catch (Exception e) {
            e.getMessage();
        }
        return null;
    }

    public RegisterParkDTO updateRegisterPark(RegisterParkDTO registerParkDTO) {
        try {
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            String email = authentication.getName();
            UserEntity user = userRepository.findByEmail(email);

            if(user != null) {
                //System.out.println("ParkingDetailsId: " + registerParkDTO.getParkingDetailsId());

                Optional<RegisterParkEntity> existingRegisterPark =
                        registerParkRepository.findByParkingDetailsId(registerParkDTO.getParkingDetailsId());
                if(existingRegisterPark.isPresent()) {
                    RegisterParkEntity registerParkEntity = existingRegisterPark.get();
                    // Kiểm tra xem đăng ký bãi đỗ thuộc về người dùng hiện tại hay không
                    if (!registerParkEntity.getCustomerId().getUser().equals(user)){
                        return null;
                    }
                    registerParkEntity.setParkingDetailsId(registerParkDTO.convertToParkingDetail());
                    registerParkEntity.setParkingTimeStart(Timestamp.valueOf(registerParkDTO.getParkingTimeStart()));
                    registerParkEntity.setParkingTimeEnd(Timestamp.valueOf(registerParkDTO.getParkingTimeEnd()));
                    registerParkEntity.setCustomerAddress(registerParkDTO.getCustomerAddress());
                    // Lưu lại vào cơ sở dữ liệu
                    RegisterParkEntity updateRegisterParkEntity = registerParkRepository.save(registerParkEntity);

                    return modelMapper.map(updateRegisterParkEntity, RegisterParkDTO.class);
                }
            }
        } catch (Exception exception) {
            exception.printStackTrace();
        }
        return null;
    }

    public RegisterParkDTO getRegisterInfoById(Long id) {
        try {
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            if (authentication != null && authentication.isAuthenticated()) {
                String email = authentication.getName();
                UserEntity user = userRepository.findByEmail(email);

                if (user != null) {
                    RegisterParkEntity registerParkEntity = registerParkRepository.findById(id).orElse(null);

                    if (registerParkEntity != null) {
                        return modelMapper.map(registerParkEntity, RegisterParkDTO.class);
                    } else {
                        // Trả về Optional rỗng nếu không tìm thấy dữ liệu
                        return null;
                    }
                }
            }
        } catch (Exception exception) {
            exception.getMessage();
        }
        return null;
    }

    public List<RegisterParkEntity> getAllRegisteredParking(){
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String email = authentication.getName();
        UserEntity userEntity = userRepository.findByEmail(email);
        if(userEntity != null) {
            return registerParkRepository.findAll();
        }
        return null;
    }

    public List<RegisterParkV2Entity> getAllRegisteredParkingV2(){
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String email = authentication.getName();
        UserEntity userEntity = userRepository.findByEmail(email);
        if(userEntity != null) {
            return registerParkV2Repository.findAll();
        }
        return null;
    } // test

    public List<RegisterParkV2DTO> getRegisteredParkingByCustomerV2ById(Long customerId){
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String email = authentication.getName();
        UserEntity user = userRepository.findByEmail(email);

        Optional<CustomerV2Entity> customerV2Exist = customerV2Repository.findById(customerId);
        if(customerV2Exist.isEmpty()) {
            return null;
        }
        CustomerV2Entity customerV2 = customerV2Exist.get();

        if(user != null && customerV2 != null) {
//                List<RegisterParkEntity> registrationHistory = registerParkService.getRegisteredParkingByCustomer(id);
            List<RegisterParkV2DTO> listRegisteredPark = customerV2.getRegisterParkV2Entity().stream()
                    .map(registerParkEntity -> modelMapper.map(registerParkEntity, RegisterParkV2DTO.class))
                    .collect(Collectors.toList());

            return listRegisteredPark;
        }
        return null;
    } // test







    public List<RegisterParkEntity> getRegisteredParkingByCustomer(Long customerId){
        return registerParkRepository.findRegisterParkEntityByCustomer(customerId);
    }

    public boolean createOrderPark(RegisterParkRequest registerParkRequest) {
        try {
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            String email = authentication.getName();
            UserEntity user = userRepository.findByEmail(email);

            Timestamp timesStart = Timestamp.valueOf(registerParkRequest.getParkingTimeStart());
            Timestamp timesEnd = Timestamp.valueOf(registerParkRequest.getParkingTimeEnd());

            if(user != null) {
                CustomerV2Entity userId = customerV2Repository.findByUserId(user.getId());
                if(userId == null) {
                    return false;
                }

                ParkingDetail parkingDetailExits = parkingDetailRepository.findByIdAndDeletedAtIsNull(registerParkRequest.getId());
                if(parkingDetailExits == null) {
                    return false;
                }

                RegisterParkV2Entity registerParkV2Entity = new RegisterParkV2Entity();

                registerParkV2Entity.setParkingTimeStart(timesStart);
                registerParkV2Entity.setParkingTimeEnd(timesEnd);
                registerParkV2Entity.setStatus(RegisterStatusEnum.PENDING);
                registerParkV2Entity.setTotalPrice(registerParkRequest.getTotalPrice());
                registerParkV2Entity.setTotalTime(registerParkRequest.getTotalTime());
                registerParkV2Entity.setLicense(userId.getUserLicense());
                registerParkV2Entity.setCustomerV2Id(userId);
                registerParkV2Entity.setParkingDetailsId(parkingDetailExits);


                RegisterParkV2Entity createData = registerParkV2Repository.save(registerParkV2Entity);
                if(createData != null) {
                    return true;
                }
            }
        } catch (Exception e) {
            e.getMessage();
        }
        return false;
    }

    public List<CustomerOrderParkInforResponse> getListOrderParkByCustomerNotSuccess() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String email = authentication.getName();
        UserEntity user = userRepository.findByEmail(email);

        List<RegisterParkV2Entity> registerParkV2EntityList = registerParkV2Repository.findAllByStatusNotAndCustomerV2Id(RegisterStatusEnum.SUCCESS, user.getCustomerV2());

        List<CustomerOrderParkInforResponse> listData = new ArrayList<>();

        for (RegisterParkV2Entity item: registerParkV2EntityList) {
            ParkingAddress address = item.getParkingDetailsId().getParkingAddress();
            CustomerV2Entity customerV2 = item.getCustomerV2Id();

            CloudinaryImageInfor imageInfor = new CloudinaryImageInfor();
            ParkingImage firstImage = item.getParkingDetailsId().getParkingImages().iterator().next();



            imageInfor.setName(firstImage.getImageName()).setUrl(firstImage.getImageUrl());


            CustomerOrderParkInforResponse data = new CustomerOrderParkInforResponse();
            data.setId(item.getId()).setParkingTimeStart(item.getParkingTimeStart()).setParkingTimeEnd(item.getParkingTimeEnd()).setTotalTime(item.getTotalTime()).setTotalPrice(item.getTotalPrice())
                    .setCity(address.getCity()).setDistrict(address.getDistrict()).setWard(address.getWard()).setStreet(address.getStreet())
                    .setFullname(customerV2.getUser().getFullname()).setUserDocument(customerV2.getUserDocument()).setUserLicense(item.getLicense())
                    .setStatus(item.getStatus()).setImage(imageInfor);

            listData.add(data);
        }
        if(listData.isEmpty()) {
            return null;
        } return listData;
    }

    public String updateStatus(UpdateStatusRegisterPark updateStatusRegisterPark) {
        Optional<RegisterParkV2Entity> registerParkV2Exist = registerParkV2Repository.findById(updateStatusRegisterPark.getId());
        if (registerParkV2Exist.isEmpty()) {
            return "Not found id order parking car";
        }
        RegisterParkV2Entity registerParkV2Entity = registerParkV2Exist.get();
        switch (updateStatusRegisterPark.getStatus()) {
            case "PENDING":
                registerParkV2Entity.setStatus(RegisterStatusEnum.PENDING);
                break;
            case "CANCEL":
                registerParkV2Entity.setStatus(RegisterStatusEnum.CANCEL);
                break;
            case "SUCCESS":
                ParkingDetail parkingDetail = registerParkV2Entity.getParkingDetailsId();
                if(parkingDetail.getTotalSlot() == 0) {
                    return "The parking lot is full";
                }

                registerParkV2Entity.setStatus(RegisterStatusEnum.SUCCESS);

                parkingDetail.setTotalSlot(parkingDetail.getTotalSlot() - 1);
                if(parkingDetail.getTotalSlot() == 0) {
                    parkingDetail.setStatus(DetailStatusEnum.RENTING);
                }
                parkingDetailRepository.save(parkingDetail);

                ParkingRental parkingRental = new ParkingRental();
                parkingRental.setStatus(RentalStatusEnum.RENTING);
                parkingRental.setTotalPrice(registerParkV2Entity.getTotalPrice());
                parkingRental.setTotalTime(registerParkV2Entity.getTotalTime());
                parkingRental.setRegisterParkV2(registerParkV2Entity);
                parkingRental.setCustomerV2(registerParkV2Entity.getCustomerV2Id());

                parkingRentalRepository.save(parkingRental);
                break;
            default:
                break;
        }
        registerParkV2Repository.save(registerParkV2Entity);
        return "Update status success";
    }


    // test filter by address
//    public List<ParkingDetailRequest> getParkingDetailsByAddress(String address) {
//        // Lấy tất cả bãi đỗ
//        List<ParkingDetail> allParkingDetails = parkingDetailRepository.findAll();
//
//        // Lọc và chuyển đổi sang DTO trước khi trả về
//        return convertToDTOList(findParkingDetailsByAddress(allParkingDetails, address));
//    }
//
//    private List<ParkingDetail> findParkingDetailsByAddress(List<ParkingDetail> parkingDetails, String address) {
//        // Lọc theo địa chỉ (ví dụ: chỉ giữ lại các bãi đỗ ở quận 6)
//        return parkingDetails.stream()
//                .filter(p -> {
//                    ParkingAddress parkingAddress = p.getParkingAddress();
//                    return parkingAddress != null &&
//                            parkingAddress.getDistrict() != null &&
//                            parkingAddress.getDistrict().equalsIgnoreCase(address);
//                })
//                .collect(Collectors.toList());
//    }
//
//    private List<ParkingDetailRequest> convertToDTOList(List<ParkingDetail> parkingDetails) {
//        ModelMapper modelMapper = new ModelMapper();
//        return parkingDetails.stream()
//                .map(p -> modelMapper.map(p, ParkingDetailRequest.class))
//                .collect(Collectors.toList());
//    }
}
