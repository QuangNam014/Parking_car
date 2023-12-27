package com.eproject.parking_car.services;

import com.eproject.parking_car.entites.Accounting;
import com.eproject.parking_car.entites.Transaction;
import com.eproject.parking_car.entites.customer.CustomerV2Entity;
import com.eproject.parking_car.entites.supplier.ParkingDetail;
import com.eproject.parking_car.entites.supplier.ParkingRental;
import com.eproject.parking_car.repositories.TransactionRepository;
import com.eproject.parking_car.response.admin.GetDetailTransactionResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service

public class TransactionService {
    @Autowired
    private TransactionRepository transactionRepository;

    public List<GetDetailTransactionResponse> getList() {
        List<Transaction> getDetailTransactionResponses =
                transactionRepository.findAllByDeletedAtIsNull();

        List<GetDetailTransactionResponse> listData = new ArrayList<>();
        for (Transaction item: getDetailTransactionResponses) {
            ParkingRental parkingRental = item.getParkingRental();
            ParkingDetail parkingDetail =parkingRental.getRegisterParkV2().getParkingDetailsId();
            CustomerV2Entity customerV2 = parkingRental.getCustomerV2();
            Accounting accounting = item.getAccounting();

            GetDetailTransactionResponse data = new GetDetailTransactionResponse();

            data.setId(item.getId()).setIdRental(parkingRental.getId()).setReceiveName(customerV2.getUser().getFullname()).setSendName(parkingDetail.getSupplier().getFullname())
                    .setTotalPrice(accounting.getRevenue()).setExpense(accounting.getExpense()).setProfit(accounting.getProfit())
                    .setCreatedAt(item.getCreatedAt());

            listData.add(data);
        }

        if(!listData.isEmpty()) {
            return listData;
        }
        return listData;
    }
}
