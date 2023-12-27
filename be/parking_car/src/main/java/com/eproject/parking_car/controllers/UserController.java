package com.eproject.parking_car.controllers;


import com.eproject.parking_car.requests.user.ChangePasswordRequest;
import com.eproject.parking_car.requests.user.UpdateInforByAdminRequest;
import com.eproject.parking_car.requests.user.UpdateInforByUserRequest;
import com.eproject.parking_car.response.CustomStatusResponse;
import com.eproject.parking_car.response.user.UserDetailInforResponse;
import com.eproject.parking_car.services.UserService;
import com.eproject.parking_car.services.customer.CustomerService;
import com.eproject.parking_car.utils.GetDataErrorUtils;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1")
public class UserController {

    @Autowired
    private GetDataErrorUtils getDataErrorUtils;

    @Autowired
    private UserService userService;

    @Autowired
    private CustomStatusResponse customStatusResponse;

    @Autowired
    private CustomerService customerService;

    @GetMapping("/user/list")
    @PreAuthorize("hasAnyAuthority('ADMIN','MANAGER')")
    public ResponseEntity<?> getList() {
        try {
            var data = userService.getList();
            if (data.stream().count() > 0) {
                return customStatusResponse.OK200("Get list success", data);

            } else {
                return customStatusResponse.NOTFOUND404("list not found");
            }
        } catch (Exception e) {

            return customStatusResponse.INTERNALSERVERERROR500(e.getMessage());
        }
    }

    @PostMapping("/edit/user")
    @PreAuthorize("hasAuthority('USER')")
    public ResponseEntity<?> editByUser(@RequestBody @Valid UpdateInforByUserRequest updateInforByUserRequest, BindingResult rs) {
        try {
            if(rs.hasErrors()){
                var errors = getDataErrorUtils.DataError(rs);
                return customStatusResponse.BADREQUEST400("Provider data is incorrect",errors);
            }

            var data = userService.updateInforByUser(updateInforByUserRequest);

            if(data == null) {
                return customStatusResponse.BADREQUEST400("Update information fail");
            }
            return customStatusResponse.OK200("Update information success");
        } catch (Exception e) {
            return customStatusResponse.INTERNALSERVERERROR500(e.getMessage());
        }
    }

    @PostMapping("/edit/admin")
    @PreAuthorize("hasAnyAuthority('ADMIN','MANAGER')")
    public ResponseEntity<?> editByAdmin(@RequestBody @Valid UpdateInforByAdminRequest updateInforByAdminRequest, BindingResult rs) {
        try {
            if(rs.hasErrors()){
                var errors = getDataErrorUtils.DataError(rs);
                return customStatusResponse.BADREQUEST400("Provider data is incorrect",errors);
            }

            var data = userService.updateInforByAdmin(updateInforByAdminRequest);

            if(data == null) {
                return customStatusResponse.BADREQUEST400("Update information fail");
            }
            return customStatusResponse.OK200("Update information success", data);
        } catch (Exception e) {
            return customStatusResponse.INTERNALSERVERERROR500(e.getMessage());
        }
    }

    @GetMapping("/delete/{id}")
    @PreAuthorize("hasAnyAuthority('ADMIN','MANAGER')")
    public ResponseEntity<?> delete(@PathVariable Long id) {
        try{
            boolean checkUser = userService.deleteUser(id);
            if(checkUser) {
                return customStatusResponse.OK200("Delete success");
            } else {
                return customStatusResponse.BADREQUEST400("Delete fail");
            }
        } catch (Exception e) {
            return customStatusResponse.INTERNALSERVERERROR500(e.getMessage());
        }
    }

    @PostMapping("/change-password")
    public ResponseEntity<?> changePassword(@RequestBody @Valid ChangePasswordRequest changePasswordRequest, BindingResult rs) {
        try {
            if(rs.hasErrors()){
                var errors = getDataErrorUtils.DataError(rs);
                return customStatusResponse.BADREQUEST400("Provider data is incorrect",errors);
            }

            boolean checkChangePassword = userService.changePassword(changePasswordRequest);

            if(checkChangePassword) {
                return customStatusResponse.OK200("Change password success");
            } else {
                return customStatusResponse.BADREQUEST400("Change password fail");
            }
        } catch (Exception e) {
            return customStatusResponse.INTERNALSERVERERROR500(e.getMessage());
        }
    }

    @GetMapping("/user-infor-detail")
    public ResponseEntity<?> getDetail() {
        try {
            UserDetailInforResponse userInfor = userService.getDetailInforUser();
            if(userInfor != null) {
                return customStatusResponse.OK200("Get detail success", userInfor);
            } else {
                return customStatusResponse.BADREQUEST400("Get detail fail");
            }
        } catch (Exception e) {
            return customStatusResponse.INTERNALSERVERERROR500(e.getMessage());
        }
    }

}
