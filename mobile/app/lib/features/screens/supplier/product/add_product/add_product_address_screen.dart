// ignore_for_file: use_build_context_synchronously, sort_child_properties_last

import 'package:app/constants/color.dart';
import 'package:app/data/address_data.dart';
import 'package:app/features/controllers/supplier/product/supplier_add_product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
class AddProductAddressScreen extends StatefulWidget {
  const AddProductAddressScreen({super.key});

  @override
  State<AddProductAddressScreen> createState() => _AddProductAddressScreenState();
}

class _AddProductAddressScreenState extends State<AddProductAddressScreen> {

  final controller = Get.put(SupplierAddProductController());
  final GlobalKey<FormState> formKeyAddress = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: viewBgColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            ValueListenableBuilder(
              valueListenable: controller.districtValue,
              builder: (BuildContext context, String value, _) {
                return DropdownButton<String>(
                  padding: const EdgeInsets.all(20.0),
                  isExpanded: true,
                  
                  hint: const Text('Choose District ....'),
                  value: (value.isEmpty) ? null:value, 
                  onChanged: (value) {
                    setState(() {
                      controller.districtValue.value = value.toString();
                      controller.wardValue.value = "";
                    });
                  },
                  items: districtWardData.keys.map<DropdownMenuItem<String>>((data) {
                      return DropdownMenuItem(
                          child: Text(data), value: data);
                    }).toList(),
                );
              }
            ),
    
            (controller.districtValue.value.isEmpty) ? const SizedBox() :  
            ValueListenableBuilder(
              valueListenable: controller.wardValue,
              builder: (BuildContext context, String value, _) {
                return DropdownButton<String>(
                  padding: const EdgeInsets.all(20.0),
                  isExpanded: true,
                  
                  hint: const Text('Choose Ward ....'),
                  value: (value.isEmpty) ? null:value, 
                  onChanged: (value) {
                    setState(() {
                      controller.wardValue.value = value.toString();
                    });
                  },
                  items: districtWardData[controller.districtValue.value]!.map<DropdownMenuItem<String>>((data) {
                      return DropdownMenuItem(
                          child: Text(data), value: data);
                    }).toList(),
                );
              }
            ),
    
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: formKeyAddress,
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: controller.addressController,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(
                    label: Text('Address'), 
                    prefixIcon: Icon(LineAwesomeIcons.address_card)
                  ),
                  validator: (value) => value!.isEmpty ? "Address is not empty":null,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


