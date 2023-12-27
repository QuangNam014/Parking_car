
import 'package:app/constants/color.dart';
import 'package:app/features/controllers/supplier/product/supplier_home_product_controller.dart';
import 'package:app/features/models/customer/product/product_detail_customer_model.dart';
import 'package:app/features/models/supplier/product/product_list_model.dart';
import 'package:app/features/screens/customer/renting/customer_renting_screen.dart';
import 'package:app/features/screens/profile/menu_profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class CustomerBodyDetailInforWidget extends StatefulWidget {
  const CustomerBodyDetailInforWidget({super.key, required this.product});

  final ProductDetailModel product;

  @override
  State<CustomerBodyDetailInforWidget> createState() => _CustomerBodyDetailInforWidgetState();
}

class _CustomerBodyDetailInforWidgetState extends State<CustomerBodyDetailInforWidget> {

  final controller = Get.put(SupplierHomeProductController());
  int selectedImage = 0;

  @override
  Widget build(BuildContext context) {
    ProductDetailModel dataProduct = widget.product;
    List<ProductImageModel> images = widget.product.listImage;
    var height = MediaQuery.of(context).size.height;

    return Stack(
        children: [
          getImageAndInforProduct(height, images, dataProduct),

          Positioned(
            bottom: 15.0,
            right: 15.0,
            child: SizedBox(
              width: 135,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.car_rental_rounded, color: darkColor,),
                onPressed: (){
                  Get.to(() => const CustomerRentScreen(), arguments: dataProduct);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor, side: BorderSide.none, shape: const StadiumBorder()),
                label: const Text('Rent', style: TextStyle(color: darkColor)),
              ),
            ),
          )
        ],

      );
    // );
  }

  Column getImageAndInforProduct(double height, List<ProductImageModel> images, ProductDetailModel data) {
    return  Column(
        children: [
          // product image slider
          SizedBox(
            height: height * 0.43,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                InstaImageViewer(
                  child: SizedBox(
                    height: height * 0.3,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Center(
                        child: Image.network(images[selectedImage].url),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 30,
                  left: 24,
                  child: SizedBox(
                    height: 80.0,
                    child: ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: images.length,
                      separatorBuilder: (_, __) => const SizedBox(
                        width: 16.0,
                      ),
                      itemBuilder: (_, index) => GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedImage = index;
                          });
                        },
                        child: Container(
                          width: 80,
                          // height: ,
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: selectedImage == index ?Colors.red : Colors.transparent),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: ClipRRect(
                            child: Image.network(
                              images[index].url,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          Container(
            height: 1.0, 
            margin: const EdgeInsets.symmetric(horizontal: 20.0), 
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.3),
            ),
          ),
      
          const SizedBox(height: 5.0,),
      
          // product detail
          Padding(
            padding: const EdgeInsets.only(right: 24.0, left: 24.0, bottom: 24.0),
            child: Column(
              children: [
                ProfileMenuWidget(title: "Price: ${data.price} \$/hour ", icon: LineAwesomeIcons.info_circle, endIcon: false),
                ProfileMenuWidget(title: "Address: ${data.street}, ${data.ward}, ${data.district}, ${data.city}", icon: LineAwesomeIcons.info_circle, endIcon: false),
              ],
            ),
          ),
        ],
      );
 
  }
}
