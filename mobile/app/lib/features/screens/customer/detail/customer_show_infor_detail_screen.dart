import 'package:app/constants/color.dart';
import 'package:app/features/models/customer/product/product_detail_customer_model.dart';
import 'package:app/features/screens/customer/detail/customer_detai_infor_body_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerShowInforDetailScreen extends StatelessWidget {
  const CustomerShowInforDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {

    ProductDetailModel data = Get.arguments;

    return Scaffold(
      backgroundColor: viewBgColor,
      appBar: AppBar(
        leading: SizedBox(
          width: 60,
          child: TextButton(
            onPressed: () => Get.back(),
            child: const Icon(Icons.arrow_back_ios),
          ),
        ),
      ),
      body: CustomerBodyDetailInforWidget(product: data),
    );
  }
}