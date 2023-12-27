package com.eproject.parking_car.services.supplier;

import com.eproject.parking_car.dtos.CloudinaryImageInfor;
import com.eproject.parking_car.entites.UserEntity;
import com.eproject.parking_car.entites.customer.CustomerV2Entity;
import com.eproject.parking_car.entites.customer.RegisterParkV2Entity;
import com.eproject.parking_car.entites.enums.DetailStatusEnum;
import com.eproject.parking_car.entites.enums.RentalStatusEnum;
import com.eproject.parking_car.entites.supplier.ParkingAddress;
import com.eproject.parking_car.entites.supplier.ParkingDetail;
import com.eproject.parking_car.entites.supplier.ParkingImage;
import com.eproject.parking_car.entites.supplier.ParkingRental;
import com.eproject.parking_car.repositories.UserRepository;
import com.eproject.parking_car.repositories.supplier.ParkingAddressRepository;
import com.eproject.parking_car.repositories.supplier.ParkingDetailRepository;
import com.eproject.parking_car.repositories.supplier.ParkingImageRepository;
import com.eproject.parking_car.requests.supplier.*;
import com.eproject.parking_car.response.customer.CustomerOrderParkInforResponse;
import com.eproject.parking_car.response.customer.CustomerParkRentInforResponse;
import com.eproject.parking_car.response.supplier.EditParkingDetailResponse;
import com.eproject.parking_car.response.supplier.ParkingDetailResponse;
import com.eproject.parking_car.response.supplier.ParkingDetailResponseV2;
import com.eproject.parking_car.response.supplier.SynthesizeDataResponse;
import com.eproject.parking_car.services.UploadService;
import com.eproject.parking_car.utils.TransferDataUtils;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

@Service
public class ParkingDetailService {

    @Autowired
    private ModelMapper modelMapper;

    @Autowired
    private UploadService uploadService;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private ParkingDetailRepository parkingDetailRepository;

    @Autowired
    private ParkingImageRepository parkingImageRepository;

    @Autowired
    private ParkingAddressRepository parkingAddressRepository;

    public ParkingDetailResponse createParkingDetail(ParkingDetailRequest parkingDetailRequest) {
        try {
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            String email = authentication.getName();
            UserEntity userEntity = userRepository.findByEmail(email);

            parkingDetailRequest.setStatus(DetailStatusEnum.PENDING);
            TransferDataUtils<ParkingDetail, ParkingDetailRequest> transferParkingDetail = new TransferDataUtils<>();
            ParkingDetail parkingDetail = transferParkingDetail.DTOToEntity(parkingDetailRequest, new ParkingDetail());

            TransferDataUtils<ParkingAddress, ParkingDetailRequest> transferParkingAddress = new TransferDataUtils<>();
            ParkingAddress parkingAddress = transferParkingAddress.DTOToEntity(parkingDetailRequest, new ParkingAddress());

            parkingDetail.setParkingAddress(parkingAddress);
            parkingDetail.setSupplier(userEntity);
            parkingDetailRepository.save(parkingDetail);

            Set<CloudinaryImageInfor> listParkingImage = parkingDetailRequest.getListImage();
            Set<ParkingImage> listImage = new HashSet<>();
            for (CloudinaryImageInfor item : listParkingImage) {
                ParkingImage parkingImage = new ParkingImage();
                parkingImage.setImageName(item.getName()).setImageUrl(item.getUrl());
                parkingImage.setParkingDetail(parkingDetail);
                parkingImageRepository.save(parkingImage);
                listImage.add(parkingImage);
            }
            parkingDetail.setParkingImages(listImage);

            return modelMapper.map(parkingDetailRequest, ParkingDetailResponse.class);
        } catch (Exception e) {
            e.getMessage();
            return null;
        }

    }

    public EditParkingDetailResponse updateParkingDetail (EditParkingDetailRequest editParkingDetailRequest) {
        try {
            Optional<ParkingDetail> parkingDetailExist = parkingDetailRepository.findById(editParkingDetailRequest.getId());
            if (parkingDetailExist.isEmpty()) {
                throw new Exception();
            }

            ParkingDetail parkingDetail = parkingDetailExist.get();
            ParkingAddress parkingAddress = parkingDetail.getParkingAddress();

            TransferDataUtils<ParkingDetail, EditParkingDetailRequest> transferParkingDetail = new TransferDataUtils<>();
            ParkingDetail detailEntity = transferParkingDetail.DTOToEntity(editParkingDetailRequest, parkingDetail);
            TransferDataUtils<ParkingAddress, EditParkingDetailRequest> transferParkingAddress = new TransferDataUtils<>();
            ParkingAddress addressEntity = transferParkingAddress.DTOToEntity(editParkingDetailRequest, parkingAddress);

            detailEntity.setParkingAddress(addressEntity);

            ParkingDetail dataDetail = parkingDetailRepository.save(detailEntity);
            ParkingAddress dataAddress = dataDetail.getParkingAddress();
            EditParkingDetailResponse result = new EditParkingDetailResponse();

            TransferDataUtils<ParkingDetail, EditParkingDetailResponse> transferParkingDetailResponse = new TransferDataUtils<>();
            transferParkingDetailResponse.EntityToDTO(dataDetail, result);
            TransferDataUtils<ParkingAddress, EditParkingDetailResponse> transferParkingAddressResponse = new TransferDataUtils<>();
            transferParkingAddressResponse.EntityToDTO(dataAddress, result);

            return result;
        } catch (Exception e) {
            e.getMessage();
            return null;
        }
    }

    public boolean updateDetailImage (ParkingDetailImageRequest parkingDetailImageRequest) {
        try {
            Optional<ParkingDetail> parkingDetailExist = parkingDetailRepository.findById(parkingDetailImageRequest.getId());
            if (parkingDetailExist.isEmpty()) {
                throw new Exception();
            }

            ParkingDetail parkingDetail = parkingDetailExist.get();
            Set<String> listPublicIdImage = new HashSet<>();
            Set<ParkingImage> images = parkingDetail.getParkingImages();

            for (ParkingImage item : images) {
                var result = parkingImageRepository.findById(item.getId());
                if(result.isPresent()) {
                    listPublicIdImage.add(item.getImageName());
                    parkingImageRepository.deleteById(item.getId());
                }
            }
            uploadService.deleteMultiImage(listPublicIdImage);
            for (CloudinaryImageInfor item : parkingDetailImageRequest.getListImage()) {
                ParkingImage parkingImage = new ParkingImage();
                parkingImage.setImageName(item.getName()).setImageUrl(item.getUrl());
                parkingImage.setParkingDetail(parkingDetail);
                parkingImageRepository.save(parkingImage);
            }
            return true;
        } catch (Exception e) {
            e.getMessage();
            return false;
        }
    }

    public boolean deleteParkingDetail(Long id) {
        ParkingDetail parkingDetailExist =  parkingDetailRepository.findByIdAndDeletedAtIsNull(id);
        if(parkingDetailExist != null) {
            int value  = parkingDetailRepository.softDeleteById(parkingDetailExist.getId());
            if(value > 0) {
                parkingAddressRepository.softDeleteById(parkingDetailExist.getParkingAddress().getId());
                Set<ParkingImage> listImage = parkingDetailExist.getParkingImages();
                parkingImageRepository.deleteAll(listImage);
                return true;
            }
        } return false;
    }

    public List<ParkingDetailResponseV2> getAllParkingDetailById() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String email = authentication.getName();
        UserEntity userEntity = userRepository.findByEmail(email);
        if(userEntity != null) {
            List<ParkingDetail> listParkingDetail = parkingDetailRepository.findAllByDeletedAtIsNullAndSupplierId(userEntity.getId());
            if (listParkingDetail.isEmpty()) {
                return null;
            } else {
                List<ParkingDetailResponseV2> listData = new ArrayList<>();

                for (ParkingDetail item: listParkingDetail) {
                    Set<CloudinaryImageInfor> listImage = new HashSet<>();
                    ParkingDetailResponseV2 responseV2 = new ParkingDetailResponseV2();

                    for (ParkingImage itemImage: item.getParkingImages()) {
                        CloudinaryImageInfor imageInfor = new CloudinaryImageInfor();
                        imageInfor.setName(itemImage.getImageName()).setUrl(itemImage.getImageUrl());
                        listImage.add(imageInfor);
                    }

                    responseV2
                            .setId(item.getId()).setPrice(item.getPrice()).setTotalSlot(item.getTotalSlot()).setStatus(item.getStatus())
                            .setCity(item.getParkingAddress().getCity()).setDistrict(item.getParkingAddress().getDistrict())
                            .setWard(item.getParkingAddress().getWard()).setStreet(item.getParkingAddress().getStreet())
                            .setLatitude(item.getParkingAddress().getLatitude()).setLongitude(item.getParkingAddress().getLongitude())
                            .setListImage(listImage);

                    listData.add(responseV2);
                };

                return listData;
            }
        }
        return null;
    }

    public ParkingDetail getDetail(Long id) {
        return parkingDetailRepository.findByIdAndDeletedAtIsNull(id);
    }

    public boolean updateStatus(UpdateStatusParkingDetail updateStatusParkingDetail) {
        Optional<ParkingDetail> parkingDetailExist = parkingDetailRepository.findById(updateStatusParkingDetail.getId());
        if (parkingDetailExist.isEmpty()) {
            return false;
        }
        ParkingDetail parkingDetail = parkingDetailExist.get();
        switch (updateStatusParkingDetail.getStatus()) {
            case "PENDING":
                parkingDetail.setStatus(DetailStatusEnum.PENDING);
                break;
            case "AVAILABLE":
                parkingDetail.setStatus(DetailStatusEnum.AVAILABLE);
                break;
            case "RENTING":
                parkingDetail.setStatus(DetailStatusEnum.RENTING);
                break;
            case "DISABLE":
                parkingDetail.setStatus(DetailStatusEnum.DISABLE);
                break;
            case "CANCEL":
                parkingDetail.setStatus(DetailStatusEnum.CANCEL);
                break;
            default:
                break;
        }
        parkingDetailRepository.save(parkingDetail);
        return true;
    }

    public boolean updateParkingDetailInfor (EditParkingDetailInforRequest editParkingDetailInforRequest) {
        try {
            Optional<ParkingDetail> parkingDetailExist = parkingDetailRepository.findById(editParkingDetailInforRequest.getId());
            if (parkingDetailExist.isEmpty()) {
                throw new Exception();
            }

            ParkingDetail parkingDetail = parkingDetailExist.get();

            TransferDataUtils<ParkingDetail, EditParkingDetailInforRequest> transferParkingDetail = new TransferDataUtils<>();
            ParkingDetail detailEntity = transferParkingDetail.DTOToEntity(editParkingDetailInforRequest, parkingDetail);


            ParkingDetail dataDetail = parkingDetailRepository.save(detailEntity);

            if(dataDetail != null) {
                return true;
            }

            return false;
        } catch (Exception e) {
            e.getMessage();
            return false;
        }
    }

    public ParkingDetailResponseV2 getParkingDetailById(Long id) {
        ParkingDetail parkingDetail = parkingDetailRepository.findByIdAndDeletedAtIsNull(id);
        if (parkingDetail == null) {
            return null;
        }
        Set<CloudinaryImageInfor> listImage = new HashSet<>();

        for (ParkingImage item: parkingDetail.getParkingImages()) {
            CloudinaryImageInfor imageInfor = new CloudinaryImageInfor();
            imageInfor.setName(item.getImageName()).setUrl(item.getImageUrl());
            listImage.add(imageInfor);
        }

        ParkingDetailResponseV2 responseV2 = new ParkingDetailResponseV2();

        responseV2
                .setId(parkingDetail.getId()).setPrice(parkingDetail.getPrice()).setTotalSlot(parkingDetail.getTotalSlot()).setStatus(parkingDetail.getStatus())
                .setCity(parkingDetail.getParkingAddress().getCity()).setDistrict(parkingDetail.getParkingAddress().getDistrict())
                .setWard(parkingDetail.getParkingAddress().getWard()).setStreet(parkingDetail.getParkingAddress().getStreet())
                .setLatitude(parkingDetail.getParkingAddress().getLatitude()).setLongitude(parkingDetail.getParkingAddress().getLongitude())
                .setListImage(listImage);

        if (responseV2 != null) {
            return responseV2;
        }
        return null;

    }

    public List<CustomerOrderParkInforResponse> getAllRegisterParkWithParkingDetailById() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String email = authentication.getName();
        UserEntity userEntity = userRepository.findByEmail(email);
        if(userEntity != null) {
            List<ParkingDetail> listParkingDetail = parkingDetailRepository.findAllByDeletedAtIsNullAndSupplierId(userEntity.getId());
            if (listParkingDetail.isEmpty()) {
                return null;
            } else {
                List<RegisterParkV2Entity> registerParkV2EntityList = new ArrayList<>();
                for (ParkingDetail itemDetail: listParkingDetail) {
                    List<RegisterParkV2Entity> listRegister = itemDetail.getRegisterParkV2Entity();
                    if (!listRegister.isEmpty()) {
                        registerParkV2EntityList.addAll(listRegister);
                    }
                }
                if (registerParkV2EntityList.isEmpty()) {
                    return null;
                }

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

                if (!listData.isEmpty()) {
                    return listData;
                }
                return null;
            }
        }
        return null;
    }

    public List<CustomerParkRentInforResponse> getAllParkRentWithParkingDetailById() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String email = authentication.getName();
        UserEntity userEntity = userRepository.findByEmail(email);
        if(userEntity != null) {
            List<ParkingDetail> listParkingDetail = parkingDetailRepository.findAllByDeletedAtIsNullAndSupplierId(userEntity.getId());
            if (listParkingDetail.isEmpty()) {
                return null;
            } else {
                List<ParkingRental> parkingRentalList = new ArrayList<>();
                for (ParkingDetail itemDetail: listParkingDetail) {
                    List<RegisterParkV2Entity> listRegister = itemDetail.getRegisterParkV2Entity();
                    if (!listRegister.isEmpty()) {
                        for (RegisterParkV2Entity itemRegister: listRegister) {
                            ParkingRental parkingRental = itemRegister.getParkingRental();
                            if (parkingRental != null) {
                                parkingRentalList.add(parkingRental);
                            }
                        }
                    }
                }
                if (parkingRentalList.isEmpty()) {
                    return null;
                }
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

                if (!listData.isEmpty()) {
                    return listData;
                }
                return null;
            }
        }
        return null;
    }

    private static Map<RentalStatusEnum, Long> countStatus(List<CustomerParkRentInforResponse> rentList) {
        // Sử dụng Java Stream để nhóm và đếm số lượng từng trạng thái
        return rentList.stream()
                .collect(Collectors.groupingBy(CustomerParkRentInforResponse::getStatus, Collectors.counting()));
    }

    public SynthesizeDataResponse getCountStatusRenting() {
        int totalTransaction = 0;
        var listParkingDetail = getAllParkingDetailById();
        if(listParkingDetail == null) {
            return null;
        }
        for (ParkingDetailResponseV2 item: listParkingDetail) {
            totalTransaction += item.getTotalSlot();
        }

        var listRental = getAllParkRentWithParkingDetailById();
        if(listRental == null) {
            return null;
        }
        Map<RentalStatusEnum, Long> statusCounts = countStatus(listRental);
        int totalCancel = 0;
        int totalFinish = 0;
        int totalRenting = 0;
        int totalAll = 0;
        for (Map.Entry<RentalStatusEnum, Long> entry : statusCounts.entrySet()) {
            RentalStatusEnum status = entry.getKey();
            long count = entry.getValue();
            if(status.equals(RentalStatusEnum.RENTING)) {
                totalRenting += (int) count;
            } else if( status.equals(RentalStatusEnum.CANCEL)) {
                totalCancel += (int) count;
            } else if(status.equals(RentalStatusEnum.FINISH)) {
                totalFinish += (int) count;
            }
        }
        totalAll = totalRenting + totalCancel + totalFinish;
        SynthesizeDataResponse count = new SynthesizeDataResponse();
        count.setTotalCancel(totalCancel).setTotalSuccess(totalFinish).setTotalTransaction(totalAll).setTotalAllSlot(totalTransaction);

        return count;
    }

}
