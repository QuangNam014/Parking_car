// ignore_for_file: use_build_context_synchronously

import 'package:app/constants/color.dart';
import 'package:app/features/controllers/supplier/product/supplier_add_product_controller.dart';
import 'package:app/features/models/supplier/infor_image_model.dart';
import 'package:app/features/models/supplier/product/produc_model.dart';
import 'package:app/features/screens/supplier/product/add_product/add_product_address_screen.dart';
import 'package:app/features/screens/supplier/product/add_product/add_product_confirm_screen.dart';
import 'package:app/features/screens/supplier/product/add_product/add_product_image_screen.dart';
import 'package:app/features/screens/supplier/product/add_product/add_product_infor_screen.dart';
import 'package:app/widgets/loading/loading_options_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickalert/quickalert.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  late int currentStep;
  late PageController _pageController;
  final controller = Get.put(SupplierAddProductController());

  @override
  void initState() {
    super.initState();
    currentStep = 0;
    _pageController = PageController(initialPage: currentStep);

  }
  
  void onStepContinue() {
    if(controller.selectedFileCount.value == 0) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        text: 'Vui lòng chọn ít nhất 1 hình',
      );
    } else if(controller.isValidInfor == false && currentStep == 1) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        text: 'Vui lòng nhập chính xác và đầy đủ thông tin liên quan',
      );
    } else if(currentStep == 2) {
      if(controller.district.isEmpty && controller.ward.isEmpty && controller.addressController.text.isEmpty) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          text: 'Vui lòng nhập địa chỉ',
        );
      } 
      else {
        String address = "${controller.addressController.text}, ${controller.wardValue.value}, ${controller.districtValue.value}";
        Future.delayed(Duration.zero, () async {
          LoadingOptions.showLoading();
          bool value = await controller.getCoordinates(address, context);
          if(value) {
            LoadingOptions.hideLoading();
            setState(() {
              currentStep++;
              _pageController.animateToPage(currentStep, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
            });
          }
        });
      }
    } else {
      setState(() {
        currentStep++;
        _pageController.animateToPage(currentStep, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
      });
    }
  }


  void onStepCancel() {
    if (currentStep > 0) {
      setState(() {
        currentStep--;
        _pageController.animateToPage(currentStep, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
      });
    }
  }

  List<Step> steps = const [
    Step(title: Text('Image'), content: AddProductImageScreen() ),
    Step(title: Text('Infor'), content: AddProductInforScreen() ),
    Step(title: Text('Address'), content: AddProductAddressScreen()),
    Step(title: Text('Confirm'), content: AddProductConfirmScreen()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            title: const Text("New Parking"),
            centerTitle: true,
          ),
          body: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: steps
                        .asMap()
                        .entries
                        .map(
                          (entry) => GestureDetector(
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: getBubbleColor(entry.key),
                              ),
                              child: Center(
                                child: Text(
                                  '${entry.key + 1}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),

                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: steps.length,
                    itemBuilder: (context, index) => steps[index].content,
                  ),
                ),

                Container(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (currentStep != 0)
                      SizedBox(
                          width: 150,
                          child: ElevatedButton.icon(
                            onPressed: onStepCancel,
                            icon: const Icon(Icons.arrow_circle_left_outlined, color: darkColor),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor, side: BorderSide.none, shape: const StadiumBorder()),
                            label: const Text('Back', style: TextStyle(color: darkColor)),
                          ),
                        ),


                      SizedBox(
                        width: 150,
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: (currentStep != steps.length - 1) ?  ElevatedButton.icon(
                            onPressed: onStepContinue,
                            icon: const Icon(Icons.arrow_circle_right_outlined, color: darkColor),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor, side: BorderSide.none, shape: const StadiumBorder()),
                            label: const Text('Next', 
                              style: TextStyle(color: darkColor),
                            ),
                          ) : ElevatedButton.icon(
                            onPressed: () async {
                              // upload image 
                              List<String> listPathImage = controller.imagePathList;
                              List<InforImageModel> listImageInfor = await controller.uploadMultiImage(listPathImage); 
                              if(listImageInfor.isEmpty) {
                                QuickAlert.show(
                                  context: context,
                                  type: QuickAlertType.error,
                                  text: 'An error occurred, please try again',
                                );
                              } else {
                                ProductModel productModel = ProductModel(
                                  price: double.parse(controller.priceController.text), 
                                  totalSlot: int.parse(controller.totalSlotController.text), 
                                  city: "Thành phố Hồ Chí Minh", 
                                  district: controller.district, 
                                  ward: controller.ward, 
                                  street: controller.street, 
                                  longitude: controller.longitude.toString(), 
                                  latitude: controller.latitude.toString(), 
                                  listImage: listImageInfor
                                );
                                controller.createProduct(productModel, context);
                              }
                            },
                            icon: const Icon(Icons.arrow_circle_right_outlined, color: darkColor),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor, side: BorderSide.none, shape: const StadiumBorder()),
                            label: const Text('Confirm', 
                              style: TextStyle(color: darkColor),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
        );
  }

  Color getBubbleColor(int index) {
    if (index < currentStep) {
      StepState.complete;
      return Colors.green; // Completed
    } else if (index == currentStep) {
      return Colors.blue; // Active
    } else {
      return Colors.grey; // Inactive
    }
  }
}


