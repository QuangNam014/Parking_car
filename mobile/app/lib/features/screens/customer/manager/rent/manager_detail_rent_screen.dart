// ignore_for_file: avoid_print

import 'package:app/constants/color.dart';
import 'package:app/constants/text.dart';
import 'package:app/features/controllers/customer/customer_manager_controller.dart';
import 'package:app/features/models/customer/list/get_customer_not_status_model.dart';
import 'package:app/features/models/supplier/status_model_rent.dart';
import 'package:app/features/screens/customer/manager/detail/detail_date_time_widget.dart';
import 'package:app/features/screens/customer/manager/detail/detail_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ManagerDetailRentScreen extends StatefulWidget {
  const ManagerDetailRentScreen({super.key});

  @override
  State<ManagerDetailRentScreen> createState() => _ManagerDetailRentScreenState();
}

class _ManagerDetailRentScreenState extends State<ManagerDetailRentScreen> {
  final controller = Get.put(CustomerManagerController());

  @override
  Widget build(BuildContext context) {

    GetDataCustomerNotStatusModel data =  Get.arguments;

    DateTime timeStart = DateTime.parse(data.parkingTimeStart);
    DateTime utcTimeStart = timeStart.toUtc();
    DateTime localTimeStart = utcTimeStart.toLocal();
    String formattedDateStart = DateFormat('dd/MM').format(localTimeStart);
    String formattedTimeStart = DateFormat('HH:mm').format(localTimeStart);

    DateTime timeEnd = DateTime.parse(data.parkingTimeEnd);
    DateTime utcTimeEnd = timeEnd.toUtc();
    DateTime localTimeEnd = utcTimeEnd.toLocal();
    String formattedDateEnd = DateFormat('dd/MM').format(localTimeEnd);
    String formattedTimeEnd = DateFormat('HH:mm').format(localTimeEnd);

    return Scaffold(
      backgroundColor: viewBgColor,
      appBar: AppBar(
        backgroundColor: lightBlueColor,
        title: const Text('Renting'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Column(
            children: [
              DetailItemWidget(title: "Người gửi", subtitle: data.fullname),
              DetailItemWidget(title: "BLX", subtitle: data.userLicense),

              const SizedBox(height: 5,),
              const Divider(color: Colors.red,),
              const SizedBox(height: 5,),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                child: Image.network(data.image.url, fit: BoxFit.cover),
              ),
              
              DetailItemWidget(title: "Nơi gửi", subtitle: "${data.street}, ${data.ward}, ${data.district}, ${data.city}"),
              DetailDateTimeWidget(
                fromDateToDate: "$formattedDateStart ~ $formattedDateEnd",
                fromTimeToTime: "$formattedTimeStart ~ $formattedTimeEnd",  
              ),

              DetailItemWidget(title: "Total time", subtitle: "${data.totalTime} hours"),
              DetailItemWidget(title: "Total price", subtitle: "${data.totalPrice} \$"),

              const SizedBox(height: 25,),

              (data.status.contains("RENTING")) ?
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0), 
                  backgroundColor: Colors.green,
                ),
                child: const Text('Payment', style: TextStyle(fontSize: 20),), 
                onPressed: ()  {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => PaypalCheckoutView(
                      sandboxMode: true,
                      clientId: CLIENT_ID,
                      secretKey: SECRET_KEY,
                      transactions: [
                        {
                          "amount": {
                            "total": '${data.totalPrice}',
                            "currency": "USD",
                          },
                          "description": "The payment transaction description.",
                        }
                      ],
                      note: "Contact us for any questions on your order.",
                      onSuccess: (Map params) async {
                        print("onSuccess: $params");
                        StatusRentModel status = StatusRentModel(id: data.id, status: "FINISH", totalPrice: data.totalPrice);
                        controller.updateStatusRent(status, context);
                      },
                      onError: (error) {
                        print("onError: $error");
                        Navigator.pop(context);
                      },
                      onCancel: () {
                        print('cancelled:');
                        Navigator.pop(context);
                      },
                    ),
                  ));
                },
              ) : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}