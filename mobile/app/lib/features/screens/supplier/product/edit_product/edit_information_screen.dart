import 'package:app/constants/color.dart';
import 'package:app/constants/size.dart';
import 'package:app/constants/text.dart';
import 'package:app/features/controllers/supplier/product/supplier_edit_product_infor_controller.dart';
import 'package:app/features/models/supplier/product/product_list_model.dart';
import 'package:app/features/models/supplier/product/update_product_infor_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class EditInformationScreen extends StatelessWidget {
  const EditInformationScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SupplierEditProductInforController());

    ProductListModel data = Get.arguments;


    return SafeArea(
      child: Scaffold(
        appBar: AppBar(backgroundColor: lightBlueColor, title: const Text('Edit Information'), centerTitle: true,),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: controller.formKey,
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
                        } else if (double.parse(value) <= 0) {
                          return "The price of an hour must be greater than zero";
                        } else if (double.parse(value) > 500) {
                          return "The price must be less than or equal to 500";
                        }
                        return null;
                      },
                    ),
                    
                    const SizedBox(height: formHeight - 10),
                    
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (controller.formKey.currentState!.validate()) {
                            UpdateProductInforModel updateInfor = UpdateProductInforModel(
                              id: data.id!, 
                              totalSlot: int.parse(controller.totalSlotController.text), 
                              price: double.parse(controller.priceController.text),
                            );

                            await controller.updateInformation(updateInfor, context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            side: BorderSide.none,
                            shape: const StadiumBorder()),
                        child: const Text(textUpdate, style: TextStyle(color: darkColor)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}