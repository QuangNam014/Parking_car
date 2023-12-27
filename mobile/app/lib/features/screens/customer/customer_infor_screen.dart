import 'package:app/constants/color.dart';
import 'package:app/constants/size.dart';
import 'package:app/features/controllers/customer/customer_infor_controller.dart';
import 'package:app/features/models/customer/customer_infor_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class CustomerInforScreen extends StatelessWidget {
  const CustomerInforScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CustomerHomeInforController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: lightBlueColor,
        title: const Text('Information customer'),
        centerTitle: true,
      ),
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
                      controller: controller.documentController,
                      decoration: const InputDecoration(
                        label: Text('CCCD'), 
                        prefixIcon: Icon(LineAwesomeIcons.info_circle),
                      ),
                      validator:(value) {
                        if (value!.isEmpty) {
                          return "CCCD is not empty";
                        } else if (value.length != 12 || int.tryParse(value) == null) {
                          return "Please enter 12 numbers";
                        }
                        return null;
                      },
                    ),
                    
                    const SizedBox(height: formHeight - 10),
                    
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: controller.licenseController,
                      decoration: const InputDecoration(
                        label: Text('License'), 
                        prefixIcon: Icon(Icons.document_scanner_outlined)
                      ),
                      validator:(value) => (value!.isEmpty) ? "License is not empty":null, 
                    ),
                    
                    const SizedBox(height: formHeight - 10),
                    
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (controller.formKey.currentState!.validate()) {
                            CustomerInforModel customerInfor = CustomerInforModel(
                              userDocument: controller.documentController.text, 
                              userLicense: controller.licenseController.text
                            );
                            controller.createInforCustomer(customerInfor, context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            side: BorderSide.none,
                            shape: const StadiumBorder()),
                        child: const Text('Create', style: TextStyle(color: darkColor)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
    );
  }
}