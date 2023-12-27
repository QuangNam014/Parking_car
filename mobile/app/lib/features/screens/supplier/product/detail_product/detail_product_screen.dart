import 'package:app/constants/color.dart';
import 'package:app/features/models/supplier/product/product_list_model.dart';
import 'package:app/features/screens/supplier/product/detail_product/detai_product_body_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailProductScreen extends StatelessWidget {
  const DetailProductScreen({super.key});


  @override
  Widget build(BuildContext context) {

    ProductListModel data = Get.arguments;

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
      body: BodyDetailProduct(product: data),
    );
  }
}
