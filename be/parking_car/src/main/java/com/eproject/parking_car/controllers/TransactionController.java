package com.eproject.parking_car.controllers;


import com.eproject.parking_car.response.CustomStatusResponse;
import com.eproject.parking_car.services.TransactionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1")
public class TransactionController {
    @Autowired
    CustomStatusResponse customStatusResponse;
    @Autowired
    TransactionService transactionService;

    @GetMapping("/transaction/list")
    @PreAuthorize("hasAnyAuthority('ADMIN','MANAGER')")
    public ResponseEntity<?> getListTransaction() {
        try {
            var data = transactionService.getList();
            if (data.stream().count() > 0) {
                return customStatusResponse.OK200("Get list transaction success", data);

            } else {
                return customStatusResponse.NOTFOUND404("list transaction not found");
            }
        } catch (Exception e) {
            return customStatusResponse.INTERNALSERVERERROR500(e.getMessage());
        }
    }
}
