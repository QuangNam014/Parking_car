import 'package:app/constants/color.dart';
import 'package:app/features/controllers/customer/customer_order_controller.dart';
import 'package:app/features/models/customer/product/product_detail_customer_model.dart';
import 'package:app/features/models/customer/product/product_order_park_model.dart';
import 'package:app/features/screens/customer/renting/renting_item_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickalert/quickalert.dart';

class CustomerRentScreen extends StatefulWidget {
  const CustomerRentScreen({super.key});

  @override
  State<CustomerRentScreen> createState() => _CustomerRentScreenState();
}

class _CustomerRentScreenState extends State<CustomerRentScreen> {

  final controller = Get.put(CustomerOrderController());
  ProductDetailModel detailProduct = Get.arguments; 
  DateTime sentDate = DateTime.now();
  DateTime pickDate = DateTime.now().add(const Duration(minutes: 30));
  double total = 0;
  int hours = 0;

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    if (0 < hours && hours < 24) {
      total = detailProduct.price * hours;
    } else if (hours >= 24) {
      total = detailProduct.price * hours * 0.7;
    }
  }

  @override
  Widget build(BuildContext context) {
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
              RentingItemWidget(title: "Ngày gửi", subtitle: "${sentDate.day} - ${sentDate.month} - ${sentDate.year}", icon: Icons.calendar_month_outlined, onPressed: () {
                showCupertinoModalPopup(context: context, builder: (BuildContext context) => SizedBox(
                  height: 400,
                  child: CupertinoDatePicker(
                    backgroundColor: whiteColor,
                    initialDateTime: sentDate,
                    use24hFormat: true,
                    mode: CupertinoDatePickerMode.date,
                    onDateTimeChanged: (DateTime newTime) {
                      if (newTime.isAfter(DateTime.now()) || newTime.isAtSameMomentAs(DateTime.now())) {
                        setState(() {
                          sentDate = newTime;
                        });
                      } else {
                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.error,
                          text: 'Please start date from now',
                        );
                      }
                    },
                  ),
                ));
              },),
              RentingItemWidget(title: "Giờ gửi", subtitle: "${sentDate.hour.toString().padLeft(2, '0')}:${sentDate.minute.toString().padLeft(2, '0')}", icon: Icons.timer_outlined, onPressed: () {
                showCupertinoModalPopup(context: context, builder: (BuildContext context) => SizedBox(
                  height: 400,
                  child: CupertinoDatePicker(
                    backgroundColor: whiteColor,
                    initialDateTime: sentDate,
                    use24hFormat: true,
                    mode: CupertinoDatePickerMode.time,
                    onDateTimeChanged: (DateTime newTime) {
                       if (newTime.isAfter(DateTime.now()) || newTime.isAtSameMomentAs(DateTime.now())) {
                        setState(() {
                          sentDate = newTime;
                        });
                      } else {
                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.error,
                          text: 'Please start time from now',
                        );
                      }
                    },
                  ),
                ));
              },),
              const SizedBox(height: 5,),
              const Divider(color: Colors.red,),
              const SizedBox(height: 5,),
              RentingItemWidget(title: "Ngày lấy", subtitle: "${pickDate.day} - ${pickDate.month} - ${pickDate.year}", icon: Icons.calendar_month_outlined, onPressed: () {
                showCupertinoModalPopup(context: context, builder: (BuildContext context) => SizedBox(
                  height: 400,
                  child: CupertinoDatePicker(
                    backgroundColor: whiteColor,
                    initialDateTime: pickDate,
                    use24hFormat: true,
                    mode: CupertinoDatePickerMode.date,
                    onDateTimeChanged: (DateTime newTime) {
                      setState(() {
                        pickDate = newTime;
                      });
                    },
                  ),
                ));
              },),
              RentingItemWidget(title: "Giờ lấy", subtitle: "${pickDate.hour.toString().padLeft(2, '0')}:${pickDate.minute.toString().padLeft(2, '0')}",  icon: Icons.timer_outlined, onPressed: () {
                showCupertinoModalPopup(context: context, builder: (BuildContext context) => SizedBox(
                  height: 400,
                  child: CupertinoDatePicker(
                    backgroundColor: whiteColor,
                    initialDateTime: pickDate,
                    use24hFormat: true,
                    mode: CupertinoDatePickerMode.time,
                    onDateTimeChanged: (DateTime newTime) {
                      setState(() {
                        pickDate = newTime;
                      });
                    },
                  ),
                ));
              },),
              const SizedBox(height: 5,),
              const Divider(color: Colors.red,),
              const SizedBox(height: 5,),
              totalMoney(),
              const SizedBox(height: 15,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0), 
                  backgroundColor: Colors.green,
                ),
                child: const Text('Rent', style: TextStyle(fontSize: 20),), 
                onPressed: ()  {
                  if(hours <= 0) {
                    QuickAlert.show(
                      context: context,
                      type: QuickAlertType.error,
                      text: 'Please choose a reasonable date',
                    );
                  } else {
                    ProductOrderParkModel orderProduct = ProductOrderParkModel(
                      id: detailProduct.id!,
                      totalTime: hours,
                      totalPrice: total,
                      parkingTimeStart: sentDate.toString(),
                      parkingTimeEnd: pickDate.toString(),
                    );
                    controller.createOrderPark(orderProduct, context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container totalMoney() {
    Duration difference = pickDate.difference(sentDate);
    setState(() {
      hours = difference.inHours;
    });
    
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(17.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 10,
            spreadRadius: 3,
            offset: const Offset(3, 4),
          )
        ],
      ),
      child:   Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        child: Row(
          children:  [
            const Expanded(
              child: Text(
                "Total money",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
              ),
            ),
        
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Text(
                  (hours <= 0) ? "0 \$" : "$total \$",
                  style: const TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}




