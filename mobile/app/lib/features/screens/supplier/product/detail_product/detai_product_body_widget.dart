
import 'package:app/constants/color.dart';
import 'package:app/features/controllers/supplier/product/supplier_home_product_controller.dart';
import 'package:app/features/models/supplier/product/product_list_model.dart';
import 'package:app/features/models/supplier/status_model.dart';
import 'package:app/features/screens/profile/menu_profile_widget.dart';
import 'package:app/features/screens/supplier/product/edit_product/edit_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class BodyDetailProduct extends StatefulWidget {
  const BodyDetailProduct({super.key, required this.product});

  final ProductListModel product;

  @override
  State<BodyDetailProduct> createState() => _BodyDetailProductState();
}

class _BodyDetailProductState extends State<BodyDetailProduct> {

  final controller = Get.put(SupplierHomeProductController());
  int selectedImage = 0;

  @override
  Widget build(BuildContext context) {
    ProductListModel dataProduct = widget.product;
    List<ProductImageModel> images = dataProduct.listImage;
    final ProductListModel productItem = widget.product;
    var height = MediaQuery.of(context).size.height;

    return Stack(
        children: [
          getImageAndInforProduct(height, images, productItem),

          (productItem.status!.contains('AVAILABLE')) ?
          Positioned(
            bottom: 15.0,
            right: 15.0,
            child: SizedBox(
              width: 135,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.edit, color: darkColor,),
                onPressed: () => EditProductScreen.showModelBottomSheetEdit(context, productItem),
                style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor, side: BorderSide.none, shape: const StadiumBorder()),
                label: const Text('Edit', style: TextStyle(color: darkColor)),
              ),
            ),
          ) : const SizedBox(),
        ],

      );
    // );
  }

  Column getImageAndInforProduct(double height, List<ProductImageModel> images, ProductListModel data) {
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
                ProfileMenuWidget(title: "Status: ${data.status}", icon: LineAwesomeIcons.info_circle, endIcon: false),
                
                (data.status!.contains('AVAILABLE')) ?
                ListTile(
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: accentColor.withOpacity(0.1),
                      ),
                      child: const Icon(Icons.switch_access_shortcut, color: accentColor),
                    ),
                    title: const Text('Disable Item', style: TextStyle(fontSize: 16.0),),
                    trailing: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 5.0), 
                        backgroundColor: Colors.red,
                      ),
                      child: const Text('Disable'), 
                      onPressed: () async {
                        setState(() {
                          StatusModel status = StatusModel(id: data.id!, status: 'DISABLE'); 
                          controller.updateStatus(status, context);
                        });
                        
                      },
                    ),
                  ) : const SizedBox(),
      
                (data.status!.contains('DISABLE')) ?
                ListTile(
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: accentColor.withOpacity(0.1),
                      ),
                      child: const Icon(Icons.switch_access_shortcut, color: accentColor),
                    ),
                    title: const Text('Available Item', style: TextStyle(fontSize: 16.0),),
                    trailing: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 5.0), 
                        backgroundColor: Colors.green,
                      ),
                      child: const Text('Avaible'), 
                      onPressed: () async {
                        setState(() {
                          StatusModel status = StatusModel(id: data.id!, status: 'AVAILABLE'); 
                          controller.updateStatus(status, context);
                        });
                        
                      },
                    ),
                  ) : const SizedBox(),
              ],
            ),
          ),
        ],
      );
 
  }
}
