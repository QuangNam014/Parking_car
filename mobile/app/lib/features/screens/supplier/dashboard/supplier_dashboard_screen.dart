import 'package:app/constants/color.dart';
import 'package:app/features/controllers/supplier/supplier_home_controller.dart';
import 'package:app/features/models/supplier/list/get_supplier_count_dashboard.dart';
import 'package:app/features/screens/supplier/dashboard/dashboard_option_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SupplierDashBoardScreen extends StatefulWidget {
  const SupplierDashBoardScreen({super.key});

  @override
  State<SupplierDashBoardScreen> createState() => _SupplierDashBoardScreenState();
}

class _SupplierDashBoardScreenState extends State<SupplierDashBoardScreen> {

  List<double> weeklySummary = [
    30.6,20.9,70.6,90.6,40.2,10.8,84.5
  ];






  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SupplierHomeController());

    return Scaffold(
      backgroundColor: viewBgColor,
      
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Padding(
              padding: const EdgeInsets.all(12.0),
              child: FutureBuilder<GetDataSupplierCountModel?>(
                future: controller.getDataCountSupplier(),
                builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if(snapshot.hasError) {
                    return Center(child: Text('${snapshot.error}'));
                  } else if(snapshot.data == null) {
                    return const Center(child: Text('No data available!'));
                  } else {
                    return Center(
                      child:  Wrap(
                        spacing: 20.0,
                        runSpacing: 20.0,
                        children: [
                          OptionDashboardWidget(subTitle: snapshot.data!.totalSuccess.toString(), title: "Giao dịch thành công", colorBgCard: Colors.green),
                          OptionDashboardWidget(subTitle: snapshot.data!.totalCancel.toString(), title: "Giao dịch thất bại", colorBgCard: Colors.red,),
                          OptionDashboardWidget(subTitle: snapshot.data!.totalAllSlot.toString(), title: "Tổng số bãi hiện có", colorBgCard: Colors.blue,),
                          OptionDashboardWidget(subTitle: snapshot.data!.totalTransaction.toString(), title: "Tổng số giao dịch"),
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
            const SizedBox(height: 30,),
            // SizedBox(height: 300 ,child: MyBarGraph(weeklySummary: weeklySummary)),
          ],
        ),
      ),
    );
  }
}