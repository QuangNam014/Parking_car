package com.eproject.parking_car.controllers.supplier;

import com.eproject.parking_car.requests.supplier.UpdateStatusParkingDetail;
import com.eproject.parking_car.requests.supplier.UpdateStatusParkingRental;
import com.eproject.parking_car.response.CustomStatusResponse;
import com.eproject.parking_car.services.supplier.ParkingRentalService;
import com.eproject.parking_car.services.supplier.SupplierService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1")
public class SupplierController {

    @Autowired
    private CustomStatusResponse customStatusResponse;

    @Autowired
    private SupplierService supplierService;

    @Autowired
    private ParkingRentalService parkingRentalService;

    @GetMapping("/supplier/get-all")
    @PreAuthorize("hasAnyAuthority('ADMIN','MANAGER')")
    public ResponseEntity<?> getAllParkingDetail() {
        try {
            var response = supplierService.getAllParkingDetail();
            if(response.isEmpty()) {
                return customStatusResponse.BADREQUEST400("Get list information parking detail fail");
            }
            return customStatusResponse.OK200("Get list information parking detail success",response);
        } catch (Exception e) {
            return customStatusResponse.INTERNALSERVERERROR500(e.getMessage());
        }
    }

    @GetMapping("/get-list-rent-park")
    public ResponseEntity<?> getListOrderParkByCustomerNotCancel(){
        try {
            var data = parkingRentalService.getListParkRentByCustomerNotCancel();
            if(data != null ) {
                return customStatusResponse.OK200("Get list successfully",data);
            }
            return customStatusResponse.NOTFOUND404("Get list fail");
        } catch (Exception e) {
            e.printStackTrace();
            return  customStatusResponse.INTERNALSERVERERROR500(e.getMessage());
        }
    }

    @PostMapping("/supplier/update-status-rental")
    public ResponseEntity<?> updateStatus(@RequestBody UpdateStatusParkingRental updateStatusParkingRental) {
        try {
            var response = parkingRentalService.updateStatusRental(updateStatusParkingRental);
            if(response) {
                return customStatusResponse.OK200("Update status rental success", true);
            }
            return customStatusResponse.BADREQUEST400("Update status rental fail", false);
        } catch (Exception e) {
            return customStatusResponse.INTERNALSERVERERROR500(e.getMessage());
        }
    }
}
