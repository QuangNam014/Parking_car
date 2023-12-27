package com.eproject.parking_car.services.supplier;

import com.eproject.parking_car.dtos.CloudinaryImageInfor;
import com.eproject.parking_car.entites.Accounting;
import com.eproject.parking_car.entites.Transaction;
import com.eproject.parking_car.entites.UserEntity;
import com.eproject.parking_car.entites.customer.CustomerV2Entity;
import com.eproject.parking_car.entites.customer.RegisterParkV2Entity;
import com.eproject.parking_car.entites.enums.DetailStatusEnum;
import com.eproject.parking_car.entites.enums.RentalStatusEnum;
import com.eproject.parking_car.entites.supplier.ParkingAddress;
import com.eproject.parking_car.entites.supplier.ParkingDetail;
import com.eproject.parking_car.entites.supplier.ParkingImage;
import com.eproject.parking_car.entites.supplier.ParkingRental;
import com.eproject.parking_car.repositories.AccountingRepository;
import com.eproject.parking_car.repositories.TransactionRepository;
import com.eproject.parking_car.repositories.UserRepository;
import com.eproject.parking_car.repositories.supplier.ParkingDetailRepository;
import com.eproject.parking_car.repositories.supplier.ParkingRentalRepository;
import com.eproject.parking_car.requests.supplier.UpdateStatusParkingRental;
import com.eproject.parking_car.response.customer.CustomerParkRentInforResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class ParkingRentalService {

    @Autowired
    private ParkingRentalRepository parkingRentalRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private ParkingDetailRepository parkingDetailRepository;

    @Autowired
    private TransactionRepository transactionRepository;

    @Autowired
    private AccountingRepository accountingRepository;

    public List<CustomerParkRentInforResponse> getListParkRentByCustomerNotCancel() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String email = authentication.getName();
        UserEntity user = userRepository.findByEmail(email);

//        List<ParkingRental> parkingRentalList = parkingRentalRepository.findAllByStatusNotAndCustomerV2(RentalStatusEnum.CANCEL, user.getCustomerV2());

        List<ParkingRental> parkingRentalList = parkingRentalRepository.findAllByCustomerV2(user.getCustomerV2());
        List<CustomerParkRentInforResponse> listData = new ArrayList<>();

        for (ParkingRental item: parkingRentalList) {
            ParkingAddress address = item.getRegisterParkV2().getParkingDetailsId().getParkingAddress();
            CustomerV2Entity customerV2 = item.getCustomerV2();
            RegisterParkV2Entity order = item.getRegisterParkV2();

            CloudinaryImageInfor imageInfor = new CloudinaryImageInfor();
            ParkingImage firstImage = item.getRegisterParkV2().getParkingDetailsId().getParkingImages().iterator().next();

            imageInfor.setName(firstImage.getImageName()).setUrl(firstImage.getImageUrl());


            CustomerParkRentInforResponse data = new CustomerParkRentInforResponse();

            data.setId(item.getId()).setParkingTimeStart(order.getParkingTimeStart()).setParkingTimeEnd(order.getParkingTimeEnd()).setTotalTime(item.getTotalTime()).setTotalPrice(item.getTotalPrice())
                            .setCity(address.getCity()).setDistrict(address.getDistrict()).setWard(address.getWard()).setStreet(address.getStreet())
                            .setFullname(customerV2.getUser().getFullname()).setUserDocument(customerV2.getUserDocument()).setUserLicense(order.getLicense())
                            .setStatus(item.getStatus()).setImage(imageInfor);
            listData.add(data);
        }
        if(listData.isEmpty()) {
            return null;
        } return listData;
    }

    public boolean updateStatusRental(UpdateStatusParkingRental updateStatusParkingRental) {
        Optional<ParkingRental> parkingRentalExist = parkingRentalRepository.findById(updateStatusParkingRental.getId());
        if (parkingRentalExist.isEmpty()) {
            return false;
        }
        ParkingRental parkingRental = parkingRentalExist.get();
        switch (updateStatusParkingRental.getStatus()) {
            case "PENDING":
                parkingRental.setStatus(RentalStatusEnum.RENTING);
                break;
            case "CANCEL":
                parkingRental.setStatus(RentalStatusEnum.CANCEL);
                break;
            case "FINISH":
                parkingRental.setStatus(RentalStatusEnum.FINISH);

                ParkingDetail parkingDetail = parkingRental.getRegisterParkV2().getParkingDetailsId();
                if(parkingDetail.getTotalSlot() == 0) {
                    parkingDetail.setStatus(DetailStatusEnum.AVAILABLE);
                }
                parkingDetail.setTotalSlot(parkingDetail.getTotalSlot() + 1);
                parkingDetailRepository.save(parkingDetail);

                String metadata = "receiver: "+parkingDetail.getSupplier().getFullname()+", sender: "+parkingRental.getCustomerV2().getUser().getFullname()+", total price: "+updateStatusParkingRental.getTotalPrice();
                Transaction transaction = new Transaction();
                transaction.setReceiver(parkingDetail.getSupplier().getId());
                transaction.setSender(parkingRental.getCustomerV2().getId());
                transaction.setMetadata(metadata);
                transaction.setParkingRental(parkingRental);
                transactionRepository.save(transaction);

                Accounting accounting = new Accounting();
                accounting.setRevenue(updateStatusParkingRental.getTotalPrice());
                accounting.setProfit(updateStatusParkingRental.getTotalPrice() * 0.1);
                accounting.setExpense(updateStatusParkingRental.getTotalPrice() * 0.9);
                accounting.setTransaction(transaction);
                accountingRepository.save(accounting);

                UserEntity userEntity = parkingDetail.getSupplier();
                userEntity.setWallet((userEntity.getWallet()) + (updateStatusParkingRental.getTotalPrice() * 0.9));
                userRepository.save(userEntity);

                break;
            default:
                break;
        }
        parkingRentalRepository.save(parkingRental);
        return true;
    }

}
