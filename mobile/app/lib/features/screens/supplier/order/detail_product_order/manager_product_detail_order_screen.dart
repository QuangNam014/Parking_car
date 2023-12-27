import 'package:app/constants/color.dart';
import 'package:app/features/controllers/supplier/manager/supplier_manager_controller.dart';
import 'package:app/features/models/supplier/list/get_supplier_status_model.dart';
import 'package:app/features/models/supplier/status_model.dart';
import 'package:app/features/screens/customer/manager/detail/detail_date_time_widget.dart';
import 'package:app/features/screens/customer/manager/detail/detail_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ManagerProductDetailOrderScreen extends StatefulWidget {
  const ManagerProductDetailOrderScreen({super.key});

  @override
  State<ManagerProductDetailOrderScreen> createState() => _ManagerProductDetailOrderScreenState();
}

class _ManagerProductDetailOrderScreenState extends State<ManagerProductDetailOrderScreen> {

  final controller = Get.put(SupplierManagerController());

  @override
  Widget build(BuildContext context) {

    GetDataSupplierStatusModel data =  Get.arguments;

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 135,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.cancel, color: whiteColor,),
                      onPressed: () {
                        StatusModel status = StatusModel(id: data.id, status: 'CANCEL'); 
                        controller.updateStatusOrder(status, context);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red, side: BorderSide.none, shape: const StadiumBorder()),
                      label: const Text('Cancel', style: TextStyle(color: whiteColor)),
                    ),
                  ),

                  SizedBox(
                    width: 135,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.check_circle_outline_rounded, color: whiteColor,),
                      onPressed: () {
                        StatusModel status = StatusModel(id: data.id, status: 'SUCCESS'); 
                        controller.updateStatusOrder(status, context);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green, side: BorderSide.none, shape: const StadiumBorder()),
                      label: const Text('Success', style: TextStyle(color: whiteColor)),
                    ),
                  ),
                ],
              ) : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}