import 'package:app/constants/size.dart';
import 'package:app/features/controllers/supplier/product/supplier_add_product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class AddProductInforScreen extends StatelessWidget {
  const AddProductInforScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(SupplierAddProductController());

    return SingleChildScrollView(
      child: Form(
        onChanged: () {
          if(controller.formKeyInfor.currentState!.validate()) {
            controller.isValidInfor = true;
          } else {
            controller.isValidInfor = false;
          }
        },
        key: controller.formKeyInfor,
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.number,
                controller: controller.totalSlotController,
      
                decoration: const InputDecoration(
                  label: Text('Total Slot'), 
                  prefixIcon: Icon(LineAwesomeIcons.parking),
                ),
                validator:(value) {
                  if (value!.isEmpty) {
                    return "Total Slot is not empty";
                  } else if (int.parse(value) <= 0) {
                    return "There must be at least 1 parking lot";
                  }
                  return null;
                },
              ),
              const SizedBox(height: formHeight - 10),
              
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: controller.priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  label: Text('Price/h'), 
                  prefixIcon: Icon(LineAwesomeIcons.money_check)
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Price is not empty";
                  } else if (int.parse(value) <= 0) {
                    return "The price of an hour must be greater than zero";
                  } else if (int.parse(value) > 500) {
                    return "The price must be less than or equal to 500";
                  }
                  return null;
                },
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}