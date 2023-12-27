package com.eproject.parking_car.services;


import com.eproject.parking_car.dtos.UserInfor;
import com.eproject.parking_car.entites.UserEntity;
import com.eproject.parking_car.entites.VerifiedToken;
import com.eproject.parking_car.repositories.AuthRepository;
import com.eproject.parking_car.repositories.VerifiedTokenRepository;
import com.eproject.parking_car.requests.auth.ForgetPasswordRequest;
import com.eproject.parking_car.requests.auth.MailRequest;
import com.eproject.parking_car.requests.auth.SignInRequest;
import com.eproject.parking_car.requests.auth.SignUpRequest;
import com.eproject.parking_car.response.auth.SignInResponse;
import com.eproject.parking_car.utils.JwtUtils;
import com.eproject.parking_car.utils.SendMailUtils;
import com.eproject.parking_car.utils.TransferDataUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Calendar;
import java.util.Date;

@Service
public class AuthService {

    @Autowired
    private SendMailUtils sendMailUtils;

    @Autowired
    private JwtUtils jwtUtils;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private AuthRepository authRepository;

    @Autowired
    private VerifiedTokenRepository verifiedTokenRepository;

    @Autowired
    private AuthenticationManager authenticationManager;

    public UserEntity findByEmail(String email) {
        return authRepository.findByEmail(email);
    }

    public UserEntity createUser(SignUpRequest signupRequest) {

        signupRequest.setPassword(passwordEncoder.encode(signupRequest.getPassword()));

        TransferDataUtils<UserEntity, SignUpRequest> transferEntity = new TransferDataUtils<>();
        UserEntity userEntity = transferEntity.DTOToEntity(signupRequest, new UserEntity());

        UserEntity createdUser = authRepository.save(userEntity);
        return  createdUser;
    }

    public SignInResponse login(SignInRequest signInRequest) throws Exception {
        try{
            Authentication authentication = authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(signInRequest.getEmail(), signInRequest.getPassword()));
            SecurityContextHolder.getContext().setAuthentication(authentication);

            String email = authentication.getName();
            UserEntity userEntity = findByEmail(email);

            UserInfor userInfor = new UserInfor();
            userInfor.setEmail(userEntity.getEmail());
            userInfor.setFullname(userEntity.getFullname());
            userInfor.setPhone(userEntity.getPhone());
            userInfor.setRole(userEntity.getRole());

            final String token = jwtUtils.generateToken(userInfor);
            return SignInResponse.builder().token(token).build();

        } catch (Exception e) {
            throw new Exception("email or password incorrect");
        }
    }

    public void sendMail(MailRequest mailRequest) {
        try {
            VerifiedToken verifiedToken = new VerifiedToken(mailRequest.getEmail());
            verifiedTokenRepository.save(verifiedToken);
            String token = verifiedToken.getToken();
            String message = "<p>Mã token có thời hạn trong vòng 10p.</p> <p>Token: <strong style=\"font-size: 30px;\">"+token+"</strong>.</p>";
            mailRequest
                    .setSubject("Verified token")
                    .setMessage(message);

            sendMailUtils.sendMail(mailRequest);
        } catch (Exception e) {
            e.getMessage();
        }
    }

    public void sendMailForgetPass(MailRequest mailRequest) {
        try {
            VerifiedToken verifiedToken = new VerifiedToken(mailRequest.getEmail());
            verifiedTokenRepository.save(verifiedToken);
            String token = verifiedToken.getToken();
            String link = "http://localhost:8080/auth/forget-password/verified-token/"+mailRequest.getEmail()+"&"+token;
            String message = "<p>Link có thời hạn trong vòng 10p.</p> Click on the following link to verify your email: <a href='" +link+ "'>" +link+ "</a>";

            mailRequest
                    .setSubject("Verified token")
                    .setMessage(message);

            sendMailUtils.sendMail(mailRequest);
        } catch (Exception e) {
            e.getMessage();
        }
    }

    public boolean verifiedMail(String email, String token) {
        VerifiedToken emailExist = verifiedTokenRepository.findByEmail(email);
        if(emailExist != null) {
            Date currentTime = Calendar.getInstance().getTime();
            String tokenDB = emailExist.getToken();
            if(tokenDB.equals(token) && currentTime.before(emailExist.getExpiredAt())) {
                return true;
            }
            return false;
        } return false;
    }

    public boolean changeForgetPasswrod(ForgetPasswordRequest forgetPasswordRequest) {
        UserEntity userExist = findByEmail(forgetPasswordRequest.getEmail());

        if(userExist == null) {
            return false;
        } else {
            if(!forgetPasswordRequest.getPassword().equals(forgetPasswordRequest.getConfirmPassword())) {
                return false;
            }
            String newPasswordHash = passwordEncoder.encode(forgetPasswordRequest.getPassword());

            TransferDataUtils<UserEntity, ForgetPasswordRequest> transfer = new TransferDataUtils<>();
            UserEntity user = transfer.DTOToEntity(forgetPasswordRequest, userExist);
            user.setPassword(newPasswordHash);
            authRepository.save(user);
            return true;
        }
    }
}
