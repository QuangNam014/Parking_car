package com.eproject.parking_car.controllers.supplier;

import com.eproject.parking_car.requests.supplier.*;
import com.eproject.parking_car.response.CustomStatusResponse;
import com.eproject.parking_car.services.supplier.ParkingDetailService;
import com.eproject.parking_car.requests.supplier.UpdateStatusParkingDetail;
import com.eproject.parking_car.utils.GetDataErrorUtils;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1")
public class ParkingDetailController {

    @Autowired
    private GetDataErrorUtils getDataErrorUtils;

    @Autowired
    private CustomStatusResponse customStatusResponse;

    @Autowired
    private ParkingDetailService parkingDetailService;

    @PostMapping("/supplier/create-detail")
    public ResponseEntity<?> createParkingDetail(@RequestBody @Valid ParkingDetailRequest parkingDetailRequest, BindingResult rs) {
        try {
            if(rs.hasErrors()){
                var errors = getDataErrorUtils.DataError(rs);
                return customStatusResponse.BADREQUEST400("Provider data is incorrect",errors);
            }

            var response = parkingDetailService.createParkingDetail(parkingDetailRequest);

            if(response == null) {
                return customStatusResponse.BADREQUEST400("Create information parking detail fail");
            }
            return customStatusResponse.CREATED201("Create information parking detail success", response);
        } catch (Exception e) {
            return customStatusResponse.INTERNALSERVERERROR500(e.getMessage());
        }
    }

    @PutMapping("/supplier/update-detail")
    public ResponseEntity<?> updateParkingDetail(@RequestBody @Valid EditParkingDetailRequest editParkingDetailRequest, BindingResult rs) {
        try {
            if(rs.hasErrors()){
                var errors = getDataErrorUtils.DataError(rs);
                return customStatusResponse.BADREQUEST400("Provider data is incorrect",errors);
            }

            var response = parkingDetailService.updateParkingDetail(editParkingDetailRequest);

            if(response == null) {
                return customStatusResponse.BADREQUEST400("Update information parking detail fail");
            }
            return customStatusResponse.OK200("Update information parking detail success", response);
        } catch (Exception e) {
            return customStatusResponse.INTERNALSERVERERROR500(e.getMessage());
        }
    }

    @PostMapping("/supplier/update-detail-image")
    public ResponseEntity<?> updateDetailImage(@RequestBody ParkingDetailImageRequest parkingDetailImageRequest) {
        try {
            var response = parkingDetailService.updateDetailImage(parkingDetailImageRequest);
            if(response) {
                return customStatusResponse.OK200("Update image information parking detail success", true);
            }
            return customStatusResponse.BADREQUEST400("Update image information parking detail fail", false);
        } catch (Exception e) {
            return customStatusResponse.INTERNALSERVERERROR500(e.getMessage());
        }
    }

    @DeleteMapping("/supplier/delete-detail/{id}")
    public ResponseEntity<?> deleteParkingDetail(@PathVariable("id") Long id) {
        try {
            var response = parkingDetailService.deleteParkingDetail(id);
            if(response) {
                return customStatusResponse.OK200("Delete information parking detail success", true);
            }
            return customStatusResponse.BADREQUEST400("Delete information parking detail fail", false);
        } catch (Exception e) {
            return customStatusResponse.INTERNALSERVERERROR500(e.getMessage());
        }
    }

    @GetMapping("/supplier/get-all-detail")
    public ResponseEntity<?> getAllParkingDetail() {
        try {
            var response = parkingDetailService.getAllParkingDetailById();
            if(response == null) {
                return customStatusResponse.BADREQUEST400("Get list information parking detail fail");
            }
            return customStatusResponse.OK200("Get list information parking detail success",response);
        } catch (Exception e) {
            return customStatusResponse.INTERNALSERVERERROR500(e.getMessage());
        }
    }

    @GetMapping("/supplier/get-detail/{id}")
    public ResponseEntity<?> getDetail(@PathVariable("id") Long id) {
        try {
            var response = parkingDetailService.getDetail(id);
            if(response != null) {
                return customStatusResponse.OK200("Get information parking detail success", response);
            }
            return customStatusResponse.BADREQUEST400("Get information parking detail fail");
        } catch (Exception e) {
            return customStatusResponse.INTERNALSERVERERROR500(e.getMessage());
        }
    }

    @PostMapping("/supplier/update-status")
    public ResponseEntity<?> updateStatus(@RequestBody UpdateStatusParkingDetail updateStatusParkingDetail) {
        try {
            var response = parkingDetailService.updateStatus(updateStatusParkingDetail);
            if(response) {
                return customStatusResponse.OK200("Update status information parking detail success", true);
            }
            return customStatusResponse.BADREQUEST400("Update status information parking detail fail", false);
        } catch (Exception e) {
            return customStatusResponse.INTERNALSERVERERROR500(e.getMessage());
        }
    }

    @PostMapping("/supplier/update-detail-infor")
    public ResponseEntity<?> updateParkingInforDetail(@RequestBody @Valid EditParkingDetailInforRequest editParkingDetailInforRequest, BindingResult rs) {
        try {
            if(rs.hasErrors()){
                var errors = getDataErrorUtils.DataError(rs);
                return customStatusResponse.BADREQUEST400("Provider data is incorrect",errors);
            }

            var response = parkingDetailService.updateParkingDetailInfor(editParkingDetailInforRequest);

            if(response) {
                return customStatusResponse.OK200("Update information parking detail success");
            }
            return customStatusResponse.BADREQUEST400("Update information parking detail fail");
        } catch (Exception e) {
            return customStatusResponse.INTERNALSERVERERROR500(e.getMessage());
        }
    }

    @GetMapping("/supplier/get-detail-product/{id}")
    public ResponseEntity<?> getDetailProduct(@PathVariable("id") Long id) {
        try {
            var response = parkingDetailService.getParkingDetailById(id);
            if(response != null) {
                return customStatusResponse.OK200("Get information parking detail success", response);
            }
            return customStatusResponse.BADREQUEST400("Get information parking detail fail");
        } catch (Exception e) {
            return customStatusResponse.INTERNALSERVERERROR500(e.getMessage());
        }
    }

    @GetMapping("/supplier/get-all-order-from-detail")
    public ResponseEntity<?> getAllRegisterParkWithParkingDetailById() {
        try {
            var response = parkingDetailService.getAllRegisterParkWithParkingDetailById();
            if(response == null) {
                return customStatusResponse.BADREQUEST400("Get list information parking detail fail");
            }
            return customStatusResponse.OK200("Get list information parking detail success",response);
        } catch (Exception e) {
            return customStatusResponse.INTERNALSERVERERROR500(e.getMessage());
        }
    }

    @GetMapping("/supplier/get-all-rent-from-detail")
    public ResponseEntity<?> getAllParkRentWithParkingDetailById() {
        try {
            var response = parkingDetailService.getAllParkRentWithParkingDetailById();
            if(response == null) {
                return customStatusResponse.BADREQUEST400("Get list information parking detail fail");
            }
            return customStatusResponse.OK200("Get list information parking detail success",response);
        } catch (Exception e) {
            return customStatusResponse.INTERNALSERVERERROR500(e.getMessage());
        }
    }

    @GetMapping("/supplier/get-count")
    public ResponseEntity<?> getCount() {
        try {
            var response = parkingDetailService.getCountStatusRenting();
            if(response == null) {
                return customStatusResponse.BADREQUEST400("Get count fail");
            }
            return customStatusResponse.OK200("Get count success",response);
        } catch (Exception e) {
            return customStatusResponse.INTERNALSERVERERROR500(e.getMessage());
        }
    }
}
