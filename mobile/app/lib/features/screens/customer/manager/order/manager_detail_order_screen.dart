import 'package:app/constants/color.dart';
import 'package:app/features/controllers/customer/customer_manager_controller.dart';
import 'package:app/features/models/customer/list/get_customer_not_status_model.dart';
import 'package:app/features/models/supplier/status_model.dart';
import 'package:app/features/screens/customer/manager/detail/detail_date_time_widget.dart';
import 'package:app/features/screens/customer/manager/detail/detail_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ManagerDetailOrderScreen extends StatefulWidget {
  const ManagerDetailOrderScreen({super.key});



  @override
  State<ManagerDetailOrderScreen> createState() => _ManagerDetailOrderScreenState();
}

class _ManagerDetailOrderScreenState extends State<ManagerDetailOrderScreen> {
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
        title: const Text('Order'),
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

              (data.status.contains("PENDING")) ?
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0), 
                  backgroundColor: Colors.red,
                ),
                child: const Text('Cancel', style: TextStyle(fontSize: 20),), 
                onPressed: () {
                  StatusModel status = StatusModel(id: data.id, status: 'CANCEL'); 
                  controller.updateStatusOrder(status, context);
                },
              ) : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}



