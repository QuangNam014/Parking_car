package com.eproject.parking_car.controllers.customer;

import com.eproject.parking_car.dtos.customer.CustomerDTO;
import com.eproject.parking_car.dtos.customer.RegisterParkDTO;
import com.eproject.parking_car.entites.UserEntity;
import com.eproject.parking_car.entites.customer.CustomerEntity;
import com.eproject.parking_car.entites.customer.RegisterParkEntity;
import com.eproject.parking_car.repositories.UserRepository;
import com.eproject.parking_car.requests.customer.RegisterParkRequest;
import com.eproject.parking_car.requests.customer.UpdateStatusRegisterPark;
import com.eproject.parking_car.requests.supplier.ParkingDetailRequest;
import com.eproject.parking_car.requests.supplier.UpdateStatusParkingDetail;
import com.eproject.parking_car.response.CustomStatusResponse;
import com.eproject.parking_car.services.UserService;
import com.eproject.parking_car.services.customer.CustomerService;
import com.eproject.parking_car.services.customer.RegisterParkService;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/v1/customer")
public class RegisterParkController {
    @Autowired
    private RegisterParkService registerParkService;
    @Autowired
    private CustomStatusResponse customStatusResponse;
    @Autowired
    private CustomerService customerService;
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private ModelMapper modelMapper;


    @PutMapping("/update-register-park")
    @PreAuthorize("hasAuthority('USER')")
    public ResponseEntity<?> updateRegisterPark(@RequestBody RegisterParkDTO registerParkDTO) {
        try {
            RegisterParkDTO result = registerParkService.updateRegisterPark(registerParkDTO);
            if (result != null) {
                return customStatusResponse.OK200("Update successfully.",result);
            }
            return customStatusResponse.BADREQUEST400("Create fail.");
        } catch (Exception exception) {
            return  customStatusResponse.INTERNALSERVERERROR500(exception.getMessage());
        }
    }

    @GetMapping("/get-register-info/{id}")
    @PreAuthorize("hasAuthority('USER')")
    public ResponseEntity<?> getRegisterDetailsById(@PathVariable Long id) {
        try {
            RegisterParkDTO registerParkDTO = registerParkService.getRegisterInfoById(id);

            if (registerParkDTO != null){
                return customStatusResponse.OK200("Get register park info sucessfully",registerParkDTO);
            }
            return customStatusResponse.NOTFOUND404("Not found", registerParkDTO);
        } catch (Exception e) {
            return  customStatusResponse.INTERNALSERVERERROR500(e.getMessage());
        }
    }

    @GetMapping("/get-list-registered-parking/{id}") // doi author cho admin
    @PreAuthorize("hasAuthority('USER')")
    public ResponseEntity<?> getRegisteredParkingByCustomer(@PathVariable Long id){
        try {
            var response = registerParkService.getRegisteredParkingByCustomerV2ById(id);
            if(response != null) {
                return customStatusResponse.OK200("Get list registed park by customer id successfully",
                        response);
            }
            return customStatusResponse.NOTFOUND404("Not found");
        } catch (Exception e) {
            e.printStackTrace();
            return  customStatusResponse.INTERNALSERVERERROR500(e.getMessage());
        }
    }

    @GetMapping("get-list-registered-parking") //done
    public ResponseEntity<List<RegisterParkEntity>> getAllRegisteredParking() {
        try {
            var response = registerParkService.getAllRegisteredParkingV2();
            if(response == null) {
                return customStatusResponse.BADREQUEST400("Get list information parking detail fail");
            }
            return customStatusResponse.OK200("Get list information parking detail success",response);
        } catch (Exception e) {
            return customStatusResponse.INTERNALSERVERERROR500(e.getMessage());
        }
    }

    @PostMapping("/create-order-register-park") // cai nay chi co token customer moi dk dc
    public ResponseEntity<?> createOrderPark(@RequestBody RegisterParkRequest registerParkRequest) {
        try {
            var result = registerParkService.createOrderPark(registerParkRequest);
            if (result) {
                return customStatusResponse.CREATED201("Create order successfully", result);
            }
            return customStatusResponse.BADREQUEST400("Create order fail");
        } catch (Exception e) {
            return customStatusResponse.INTERNALSERVERERROR500(e.getMessage());
        }
    }

    @GetMapping("/get-list-order-park") // not yet
    public ResponseEntity<?> getListOrderParkByCustomerNotSuccess(){
        try {
            var data = registerParkService.getListOrderParkByCustomerNotSuccess();
            if(data != null ) {
                return customStatusResponse.OK200("Get list successfully",data);
            }
            return customStatusResponse.NOTFOUND404("Get list fail");
        } catch (Exception e) {
            e.printStackTrace();
            return  customStatusResponse.INTERNALSERVERERROR500(e.getMessage());
        }
    }

    @PostMapping("/customer-update-status-order") // done
    public ResponseEntity<?> updateStatus(@RequestBody UpdateStatusRegisterPark updateStatusRegisterPark) {
        try {
            var response = registerParkService.updateStatus(updateStatusRegisterPark);
            if(response.contains("Update status success")) {
                return customStatusResponse.OK200("Update status order success");
            }
            return customStatusResponse.BADREQUEST400(response);
        } catch (Exception e) {
            return customStatusResponse.INTERNALSERVERERROR500(e.getMessage());
        }
    }
}
