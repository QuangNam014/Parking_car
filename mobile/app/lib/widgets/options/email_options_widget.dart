import 'package:app/constants/color.dart';
import 'package:app/constants/image.dart';
import 'package:app/constants/size.dart';
import 'package:app/constants/text.dart';
import 'package:app/features/controllers/widget/option_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmailOptionWidget extends StatelessWidget {
  EmailOptionWidget({super.key, required this.nextView});

  final String nextView;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.of(context).size.height;
    final optionViewController = Get.put(OptionWidgetController());
    optionViewController.nextView.value = nextView;
    
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: lightBlueColor,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(defaultSize),
            child: Column(
                children: [

                  const SizedBox(height: defaultSize),

                  SizedBox(
                    child: Image(
                        image: const AssetImage(logoEmail),
                        height: height * 0.1,
                        width: 200,
                      ),
                  ),

                  Form(
                    key: formKey,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: formHeight - 10),
                      child: Column(
                        children: [
                          TextFormField(
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            controller: optionViewController.emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.email_outlined),
                              labelText: textEmail,
                              hintText: textEmail,
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if(value!.isEmpty) {
                                return "Email is required";
                              } else if(!RegExp(r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$").hasMatch(value)) {
                                return "Enter a valid email address";
                              } return null;
                            },
                          ),


                          const SizedBox(height: formHeight),
            
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: () {
                                  if(formKey.currentState!.validate()) {
                                    optionViewController.sendEmail(context);
                                  }
                                }, 
                                child: Text(textNext.toUpperCase())
                            )
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
            ),
          ),
        ),
      ),
    );
  }
}