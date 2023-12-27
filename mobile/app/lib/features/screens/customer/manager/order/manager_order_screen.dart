import 'package:app/constants/color.dart';
import 'package:app/features/controllers/customer/customer_manager_controller.dart';
import 'package:app/features/models/customer/list/get_customer_not_status_model.dart';
import 'package:app/features/screens/customer/manager/order/manager_detail_order_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManagerOrderCustomerScreen extends StatefulWidget {
  const ManagerOrderCustomerScreen({super.key});

  @override
  State<ManagerOrderCustomerScreen> createState() => _ManagerOrderCustomerScreenState();
}

class _ManagerOrderCustomerScreenState extends State<ManagerOrderCustomerScreen> {

  final List<String> statusList = ["PENDING", "CANCEL"];
  String selectedStatus = "";
  final controller = Get.put(CustomerManagerController());
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: viewBgColor,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: statusList
                    .map((status) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: FilterChip(
                          selected: selectedStatus == status,
                          label: Text(status), 
                          labelStyle: TextStyle(color: selectedStatus == status ? Colors.white : Colors.black,),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          selectedColor: Colors.green,
                          onSelected: (selected) {
                            setState(() {
                              selectedStatus = selected ? status : "";
                            });
                          }
                      ),
                    ),)
                    .toList(),
              ),
            ),
          ),

          FutureBuilder<List<GetDataCustomerNotStatusModel>?>(
            future: controller.getListOrderCustomerNotSuccess(),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if(snapshot.hasError) {
                return Center(child: Text('${snapshot.error}'));
              } else if(snapshot.data == null) {
                return const Center(child: Text('No data available!'));
              } else {
                
                final filterListDataOrder = controller.listDataOrder.value.where((item) {
                  return selectedStatus.isEmpty || selectedStatus.contains(item.status);
                }).toList();
                return Expanded(
                  child: ListView.builder(
                    itemCount: filterListDataOrder.length,
                    itemBuilder: (context, index) {
                      final product = filterListDataOrder[index];
                      return GestureDetector(
                        onTap: () => Get.to(() => const ManagerDetailOrderScreen(), arguments: product),
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(17.0),
                            color: Colors.white,
                            boxShadow: [BoxShadow(
                              color:  Colors.grey.shade300,
                              blurRadius: 10, spreadRadius: 3, offset: const Offset(3, 4),
                            )],
                          ),
                          child: ListTile(
                            leading: Image.network(product.image.url, fit: BoxFit.cover, width: 90, height: 100,),
                            title: Text("Address: ${product.street}, ${product.ward}, ${product.district}", style: const TextStyle(fontSize: 18),),
                            subtitle: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('TotalTime: ${product.totalTime} hours'),
                                Text("TotalPrice: ${product.totalPrice} \$"),
                                Text("Status: ${product.status}"),
                              ],
                            ),
                          ), 
                        ),
                      );
                    }
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}