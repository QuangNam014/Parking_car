package com.eproject.parking_car.controllers;

import com.eproject.parking_car.entites.enums.RoleEnum;
import com.eproject.parking_car.entites.UserEntity;
import com.eproject.parking_car.requests.auth.ForgetPasswordRequest;
import com.eproject.parking_car.requests.auth.MailRequest;
import com.eproject.parking_car.requests.auth.SignInRequest;
import com.eproject.parking_car.response.CustomStatusResponse;
import com.eproject.parking_car.response.auth.SignInResponse;
import com.eproject.parking_car.services.AuthService;
import com.eproject.parking_car.utils.GetDataErrorUtils;
import com.eproject.parking_car.requests.auth.SignUpRequest;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;



@RestController
@RequestMapping("/auth")
public class AuthController {

    @Autowired
    private GetDataErrorUtils getDataErrorUtils;

    @Autowired
    private CustomStatusResponse customStatusResponse;

    @Autowired
    private AuthService authService;

    @PostMapping("/register/admin")
    public ResponseEntity<?> registerAdmin(@RequestBody @Valid SignUpRequest signupRequest, BindingResult rs) {
        try {
            if(rs.hasErrors()){
                var errors = getDataErrorUtils.DataError(rs);
                return customStatusResponse.BADREQUEST400("Provider data is incorrect",errors);
            }
            signupRequest.setRole(RoleEnum.ADMIN);

            UserEntity userEntity = authService.createUser(signupRequest);

            if (userEntity == null) {
                return  customStatusResponse.BADREQUEST400("Created user fail");
            }
            return customStatusResponse.CREATED201("Created user success",userEntity);
        } catch (Exception e) {
            return customStatusResponse.INTERNALSERVERERROR500(e.getMessage());
        }
    }

    @PostMapping("/register/user")
    public ResponseEntity<?> registerUser(@RequestBody @Valid SignUpRequest signupRequest, BindingResult rs) {
        try {
            if(rs.hasErrors()){
                var errors = getDataErrorUtils.DataError(rs);
                return customStatusResponse.BADREQUEST400("Provider data is incorrect",errors);
            }
            signupRequest.setRole(RoleEnum.USER);

            UserEntity userEntity = authService.createUser(signupRequest);

            if (userEntity == null) {
                return  customStatusResponse.BADREQUEST400("Created user fail");
            }
            return customStatusResponse.CREATED201("Created user success",userEntity);
        } catch (Exception e) {
            return customStatusResponse.INTERNALSERVERERROR500(e.getMessage());
        }
    }

    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody @Valid SignInRequest signInRequest, BindingResult rs) throws Exception {
        try {
            if(rs.hasErrors()){
                var errors = getDataErrorUtils.DataError(rs);
                return customStatusResponse.BADREQUEST400("Provider data is incorrect",errors);
            }

            SignInResponse data = authService.login(signInRequest);
            return customStatusResponse.OK200("login success", data);
        } catch (Exception e) {
            return  customStatusResponse.UNAUTHORIZED401(e.getMessage());
        }
    }

    @GetMapping("/send")
    public ResponseEntity<String> sendMail(@RequestBody @Valid MailRequest mailRequest, BindingResult rs) {
        try {
            if(rs.hasErrors()){
                var errors = getDataErrorUtils.DataError(rs);
                return customStatusResponse.BADREQUEST400("Provider data is incorrect",errors);
            }

            UserEntity emailExist = authService.findByEmail(mailRequest.getEmail());
            if(emailExist != null) {
                return customStatusResponse.BADREQUEST400("Email already exists, please enter another email");
            }

            authService.sendMail(mailRequest);
            return customStatusResponse.OK200("Please enter your email to confirm");
        } catch (Exception e) {
            return customStatusResponse.INTERNALSERVERERROR500(e.getMessage());
        }
    }

    @GetMapping("/send/verified-token/{email}&{token}")
    public ResponseEntity<String> verifiedMail(@PathVariable("email") String email, @PathVariable("token") String token) {
        try { // s3
            boolean checkVerified = authService.verifiedMail(email, token);
            if(checkVerified) {
                return customStatusResponse.OK200("Verified mail success", email);
            } else {
                return customStatusResponse.BADREQUEST400("Token has expired");
            }
        } catch (Exception e) {
            return customStatusResponse.INTERNALSERVERERROR500(e.getMessage());
        }
    }

    @GetMapping("/forget-password")
    public ResponseEntity<String> sendMailForgetPass(@RequestBody @Valid MailRequest mailRequest, BindingResult rs) {
        try {
            if(rs.hasErrors()){
                var errors = getDataErrorUtils.DataError(rs);
                return customStatusResponse.BADREQUEST400("Provider data is incorrect",errors);
            }

            UserEntity emailExist = authService.findByEmail(mailRequest.getEmail());
            if(emailExist == null) {
                return customStatusResponse.NOTFOUND404("Email does not exist, please re-enter email");
            }

            authService.sendMailForgetPass(mailRequest);
            return customStatusResponse.OK200("Please enter your email to confirm");
        } catch (Exception e) {
            return customStatusResponse.INTERNALSERVERERROR500(e.getMessage());
        }
    }

    @GetMapping("/forget-password/verified-token/{email}&{token}")
    public ResponseEntity<String> verifiedMailForgetPass(@PathVariable("email") String email, @PathVariable("token") String token) {
        try {
            boolean checkVerified = authService.verifiedMail(email, token);
            if(checkVerified) {
                return customStatusResponse.OK200("Verified mail success", email);
            } else {
                return customStatusResponse.BADREQUEST400("Invalid token");
            }
        } catch (Exception e) {
            return customStatusResponse.INTERNALSERVERERROR500(e.getMessage());
        }
    }

    @PostMapping("/forget-password/change-password")
    public ResponseEntity<String> changeForgetPass(@RequestBody @Valid ForgetPasswordRequest forgetPasswordRequest, BindingResult rs) {
        try { //s4
            if(rs.hasErrors()){
                var errors = getDataErrorUtils.DataError(rs);
                return customStatusResponse.BADREQUEST400("Provider data is incorrect",errors);
            }

            boolean checkChangeForgetPass = authService.changeForgetPasswrod(forgetPasswordRequest);

            if(checkChangeForgetPass) {
                return customStatusResponse.OK200("Change password success");
            } else {
                return customStatusResponse.BADREQUEST400("Change passwrod fail");
            }
        } catch (Exception e) {
            return customStatusResponse.INTERNALSERVERERROR500(e.getMessage());
        }
    }

    @GetMapping("/check-email/{email}") // ktr email trong database
    public ResponseEntity<?> checkEmail(@PathVariable String email) { // s1
        try {
            UserEntity emailExist = authService.findByEmail(email);
            if(emailExist == null) {
                return customStatusResponse.BADREQUEST400("Email does not exist");
            }
            return customStatusResponse.OK200("Email is exist");
        } catch (Exception e) {
            return customStatusResponse.INTERNALSERVERERROR500(e.getMessage());
        }
    }

    @PostMapping("/send-token")
    public ResponseEntity<String> sendMailToken(@RequestBody @Valid MailRequest mailRequest, BindingResult rs) { //s2
        try {
            if(rs.hasErrors()){
                var errors = getDataErrorUtils.DataError(rs);
                return customStatusResponse.BADREQUEST400("Provider data is incorrect",errors);
            }

            authService.sendMail(mailRequest);
            return customStatusResponse.OK200("Please enter your email to confirm");
        } catch (Exception e) {
            return customStatusResponse.INTERNALSERVERERROR500(e.getMessage());
        }
    }
}
