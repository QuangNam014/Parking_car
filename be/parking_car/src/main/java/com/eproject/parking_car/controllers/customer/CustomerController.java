package com.eproject.parking_car.controllers.customer;

import com.eproject.parking_car.dtos.customer.CustomerDTO;
import com.eproject.parking_car.entites.customer.CustomerEntity;
import com.eproject.parking_car.requests.customer.CustomerInforRequest;
import com.eproject.parking_car.requests.customer.UpdateCustomerDocRequest;
import com.eproject.parking_car.requests.user.ChangePasswordRequest;
import com.eproject.parking_car.response.CustomStatusResponse;
import com.eproject.parking_car.services.customer.CustomerService;
import com.eproject.parking_car.utils.GetDataErrorUtils;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.RequestEntity;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/customer")
public class CustomerController {
    @Autowired
    private CustomerService customerService;

    @Autowired
    private CustomStatusResponse customStatusResponse;

    @Autowired
    private GetDataErrorUtils getDataErrorUtils;
    @PostMapping("/add-customer-info")
    @PreAuthorize("hasAuthority('USER')")
    public ResponseEntity<?> addCustomerInfo(@RequestBody CustomerDTO customerDTO) {
        boolean result = customerService.addCustomerInfoToUser(customerDTO);
        if (result) {
            return customStatusResponse.OK200("Add successfully.");
        } else {
            return customStatusResponse.BADREQUEST400("Add fail.");
        }
//        return new ResponseEntity<>(HttpStatus.OK);
    }

    @PutMapping("/edit-customer-info")
    @PreAuthorize("hasAuthority('USER')")
    public ResponseEntity<?> editCustomerInfo(@RequestBody CustomerDTO customerDTO) {
        boolean result = customerService.editCustomerInfo(customerDTO);
        if (result) {
            return customStatusResponse.OK200("Edit successfully.");
        } else {
            return customStatusResponse.BADREQUEST400("Edit fail.");
        }
    }

    @GetMapping("/user/{userDocument}")
    @PreAuthorize("hasAnyAuthority('USER')")
    public ResponseEntity<?> findCustomerByUserDocumentByUser(@PathVariable String userDocument) {
        CustomerEntity customer = customerService.findCustomerByUserDocument(userDocument);

        if(customer != null) {
            return customStatusResponse.OK200("Find customer by user document successfully.", customer);
        } else {
            return customStatusResponse.NOTFOUND404("Not Found");
        }
    }
    @GetMapping("/list")
    @PreAuthorize("hasAnyAuthority('ADMIN','MANAGER')")
    public ResponseEntity<?> getList() { // done
        try {
            var data = customerService.getListCustomerByCCCDV2();
            if (data.stream().count() > 0) {
                return customStatusResponse.OK200("Get list successfully", data);
            } else {
                return customStatusResponse.NOTFOUND404("Get list fail");
            }
        } catch (Exception e) {
            return customStatusResponse.INTERNALSERVERERROR500(e.getMessage());
        }
    }

    @GetMapping("/admin/{userDocument}") // done
    @PreAuthorize("hasAnyAuthority('ADMIN','MANAGER')")
    public ResponseEntity<?> findCustomerByUserDocumentByAdmin(@PathVariable String userDocument) {
        var customer = customerService.findCustomerByUserDocumentV2(userDocument);

        if(customer != null) {
            return customStatusResponse.OK200("Find customer by user document successfully.", customer);
        } else {
            return customStatusResponse.NOTFOUND404("Not Found");
        }
    }

    @PostMapping("/customer-infor-create") // just token customer
    public ResponseEntity<?> createCustomerInfo(@RequestBody @Valid CustomerInforRequest customerInforRequest, BindingResult rs) {
        try {
            if(rs.hasErrors()){
                var errors = getDataErrorUtils.DataError(rs);
                return customStatusResponse.BADREQUEST400("Provider data is incorrect",errors);
            }

            boolean data = customerService.createCustomerInfor(customerInforRequest);

            if(data) {
                return customStatusResponse.CREATED201("Create information success", data);
            } else {
                return customStatusResponse.BADREQUEST400("Create information fail");
            }
        } catch (Exception e) {
            return customStatusResponse.INTERNALSERVERERROR500(e.getMessage());
        }
    }

    @GetMapping("/customer-list-parking-detail-available") // not yet
    public ResponseEntity<?> getListParkAvailable() {
        try {
            var data = customerService.getListParkAvailable();

            if(data != null) {
                return customStatusResponse.OK200("Get list success", data);
            } else {
                return customStatusResponse.BADREQUEST400("Get list fail");
            }
        } catch (Exception e) {
            return customStatusResponse.INTERNALSERVERERROR500(e.getMessage());
        }
    }

    @PostMapping("/customer-update-infor-doc")
    public ResponseEntity<?> updateCustomerInforDoc(@RequestBody @Valid UpdateCustomerDocRequest updateCustomerDocRequest, BindingResult rs) {
        try {
            if(rs.hasErrors()){
                var errors = getDataErrorUtils.DataError(rs);
                return customStatusResponse.BADREQUEST400("Provider data is incorrect",errors);
            }
            boolean data = customerService.updateCustomerInforDoc(updateCustomerDocRequest);

            if(data) {
                return customStatusResponse.OK200("Update information success");
            } else {
                return customStatusResponse.BADREQUEST400("Update information fail");
            }
        } catch (Exception e) {
            return customStatusResponse.INTERNALSERVERERROR500(e.getMessage());
        }
    }
}
