import 'package:app/constants/color.dart';
import 'package:app/features/controllers/supplier/product/supplier_home_product_controller.dart';
import 'package:app/features/models/supplier/product/product_list_model.dart';
import 'package:app/features/screens/supplier/product/add_product/add_product_screen.dart';
import 'package:app/features/screens/supplier/product/detail_product/detail_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SupplierProductScreen extends StatefulWidget {
  const SupplierProductScreen({super.key});

  @override
  State<SupplierProductScreen> createState() => _SupplierProductScreenState();
}

class _SupplierProductScreenState extends State<SupplierProductScreen> {
  final List<String> statusList = ["PENDING","AVAILABLE", "RENTING", "DISABLE", "CANCEL"];
  String selectedStatus = "";
  final controller = Get.put(SupplierHomeProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: viewBgColor,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Get.to(() => const AddProductScreen()),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: statusList
                    .map((status) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: FilterChip(
                        selected: selectedStatus == status,
                        label: Text(status), 
                        labelStyle: TextStyle(color: selectedStatus == status ? Colors.white : Colors.black,),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        selectedColor: Colors.green,
                        onSelected: (selected) {
                          setState(() {
                            selectedStatus = selected ? status : "";
                          });
                        }
                      ),
                    ),)
                    .toList(),
              ),
            ),
          ),

          FutureBuilder<List<ProductListModel>?>(
            future: controller.getListProduct(),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if(snapshot.hasError) {
                return Center(child: Text('${snapshot.error}'));
              } else if(snapshot.data == null) {
                return const Center(child: Text('No data available!'));
              } else {
                final filterListProduct = controller.listData.value.where((item) {
                  return selectedStatus.isEmpty || selectedStatus.contains(item.status!);
                }).toList();
                return Expanded(
                  child: ListView.builder(
                    itemCount: filterListProduct.length,
                    itemBuilder: (context, index) {
                      final product = filterListProduct[index];
                      return GestureDetector(
                        onTap: () => Get.to(() => const DetailProductScreen(), arguments: product),
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(17.0),
                            color: Colors.white,
                            boxShadow: [BoxShadow(
                              color:  Colors.grey.shade300,
                              blurRadius: 10, spreadRadius: 3, offset: const Offset(3, 4),
                            )],
                          ),
                          child: ListTile(
                            leading: Image.network(product.listImage[0].url, fit: BoxFit.cover, width: 90, height: 100,),
                            title: Text(product.street, style: const TextStyle(fontSize: 18),),
                            subtitle: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Price: ${product.price} \$/hour"),
                              ],
                            ),
                          ), 
                        ),
                      );
                    }
                  ),
                );
              }
            }
          ),
        ],
      ),
    );
  }
}


