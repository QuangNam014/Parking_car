// ignore_for_file: unnecessary_null_comparison

import 'dart:async';
import 'dart:convert';

import 'package:app/constants/color.dart';
import 'package:app/constants/image.dart';
import 'package:app/constants/text.dart';
import 'package:app/features/controllers/customer/customer_map_controller.dart';
import 'package:app/features/models/customer/product/get_list_product_available_model.dart';
import 'package:app/features/models/customer/product/product_detail_customer_model.dart';
import 'package:app/features/screens/customer/detail/customer_show_infor_detail_screen.dart';
import 'package:app/widgets/drawer/drawer_options_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;



import 'package:custom_info_window/custom_info_window.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomerMapScreen extends StatefulWidget {
  const CustomerMapScreen({super.key});

  @override
  State<CustomerMapScreen> createState() => _CustomerMapScreenState();
}

class _CustomerMapScreenState extends State<CustomerMapScreen> {

  // gg map
  CustomInfoWindowController customInfoWindowController = CustomInfoWindowController();
  Completer<GoogleMapController>? controllerGoogleMap;
  final controller = Get.put(CustomerMapController());
  final List<Marker> myMarker = [];
  bool markersInitialized = false;
  bool isSearching = false;

  // search place
  TextEditingController searchFieldController = TextEditingController();
  List<dynamic> listForPlace = [];
  Timer? debound;
  List<Location>? searchLocation;
  late FocusNode searchFocus;

  
  Future<void> addMarkers() async {
    if(!markersInitialized) {
      List<GetListProductAvaiLableModel> listData = await controller.getListProductAvailable();
      for (var i = 0; i < listData.length; i++) {
        final Uint8List iconMarker = await controller.getImageFromMarker(logoOptionParkingLot, 120);
          myMarker.add(
            Marker(
              markerId: MarkerId(i.toString()),
              position: LatLng(double.parse(listData[i].latitude), double.parse(listData[i].longitude)),
              icon: BitmapDescriptor.fromBytes(iconMarker),
              onTap: () {
                customInfoWindowController.addInfoWindow!(
                  customWindowShow(listData[i]), 
                  LatLng(double.parse(listData[i].latitude), double.parse(listData[i].longitude))
                );
              }
            ),
          );
        setState(() {}); 
      }
      markersInitialized = true;
    }
  }

  Container customWindowShow(GetListProductAvaiLableModel data) {
    return Container(
      height: 300,
      width: 200,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.red),
          borderRadius: BorderRadius.circular(10.0)),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 300,
              height: 90,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(data.image.url),
                    fit: BoxFit.fitWidth,
                    filterQuality: FilterQuality.high),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Text(
                  "Address: ${data.street}, ${data.ward}, ${data.district}, ${data.city}",overflow: TextOverflow.ellipsis,
                  maxLines: 2),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Price: ${data.price} \$', maxLines: 1),
                ElevatedButton(
                  onPressed: () async {
                    ProductDetailModel productDetail = await controller.getDetailProduct(data.id!);
                    Get.to(() => const CustomerShowInforDetailScreen(), arguments: productDetail);
                  },
                  style: ElevatedButton.styleFrom(
                    side: BorderSide.none,
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    backgroundColor: const Color.fromARGB(255, 146, 245, 147),
                    minimumSize: const Size(50.0, 10.0)),
                  child:  const Text('show'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<GoogleMapController> getMapController(GoogleMapController controller) async {
    if (controllerGoogleMap == null || controllerGoogleMap!.isCompleted) {
      controllerGoogleMap = Completer<GoogleMapController>();
      controllerGoogleMap!.complete(controller);
    }
    return controllerGoogleMap!.future;
  }

  CameraPosition moveCamera() {
    isSearching = true;
    return CameraPosition(
      target: LatLng(controller.latSearch, controller.longSearch), 
      zoom: 14
    );
  }
  
  void makeSuggestion(String text) async {
    String request = "$URL_GOOGLE_PLACE?input=$text&key=$API_KEY";
    var response = await http.get(Uri.parse(request));
    var result = response.body.toString();
    print("result: ${result}");
    if(response.statusCode == 200) {
      setState(() {
        listForPlace = jsonDecode(response.body.toString())['predictions'];
      });
    } else {
      throw Exception('Show data fail');
    }
  }
  
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      myMarker.add(
          Marker(
            markerId: const MarkerId('avatar-marker'),
            position: LatLng(controller.lat.value, controller.long.value),
            icon: BitmapDescriptor.defaultMarker,
            infoWindow: const InfoWindow(title: "Your location"),
          ),
        );
    });

    searchFocus = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    searchFocus.dispose();
  }

  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: lightBlueColor,
          elevation: 0,
          centerTitle: true,
          leading: Builder(
            builder: (context) => IconButton(
              icon: const Icon(
                Icons.menu_rounded,
                color: Colors.black,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
        ),
        drawer: const DrawerOptionWidget(),
        body: Stack(
          children: [
            FutureBuilder<List<GetListProductAvaiLableModel>>(
              future: controller.getListProductAvailable(),
              builder: (context, snapshot)  {
                if(snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if(snapshot.hasError) {
                  return Center(child: Text('${snapshot.error}'));
                } else if(snapshot.data == null) {
                  return const Center(child: Text('No data available!'));
                } else {
                  addMarkers();
                  return GoogleMap(
                    initialCameraPosition: isSearching ? moveCamera() : CameraPosition(
                      target: LatLng(controller.lat.value, controller.long.value), 
                      zoom: 17
                    ),
                    markers: Set<Marker>.of(myMarker),
                    onMapCreated: (GoogleMapController controller) async {
                      await getMapController(controller);
                      customInfoWindowController.googleMapController = controller;
                    },
                    onTap: (position) {
                      customInfoWindowController.hideInfoWindow!();
                    },
                    onCameraMove: (position) {
                      customInfoWindowController.onCameraMove!();
                    },
                  );
                }
              },
            ),
            CustomInfoWindow(
              controller: customInfoWindowController,
              // height: 205,
              height: 180,
              width: 200,
              offset: 40,
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
                child: Column(
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: TextFormField(
                        focusNode: searchFocus,
                        controller: searchFieldController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.location_on_outlined),
                          suffixIcon: searchFieldController.text.isNotEmpty ? IconButton(onPressed: () {
                            setState(() {
                              listForPlace = [];
                              searchFieldController.clear();
                            });
                          }, icon: const Icon(Icons.clear_outlined)):null,
                          hintText: 'Search for location',
                          contentPadding: const EdgeInsets.all(16.0),
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          if (debound?.isActive ?? false) debound!.cancel();
                          debound = Timer(const Duration(milliseconds: 1000), () { 
                            if(value.isNotEmpty) {
                              makeSuggestion(value);
                            } else {
                              setState(() {
                                listForPlace = [];
                                searchLocation = null;
                              });
                            }
                          });
                        },
                      ),
                    ),
              
                    (listForPlace.isNotEmpty) ?
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white
                      ),
                      child: Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: listForPlace.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: const CircleAvatar(
                                  child: Icon(Icons.location_on_outlined),
                                ),
                                onTap: () async {
                                  List<Location> locations = await locationFromAddress(listForPlace[index]['description']); 
                                  if(locations != null) {
                                    if(searchFocus.hasFocus) {
                                      controller.latSearch = locations.last.latitude;
                                      controller.longSearch = locations.last.longitude;
                                      moveCamera();
                                      setState(() {
                                        searchLocation = locations;
                                        searchFieldController.text = listForPlace[index]['description'];
                                        listForPlace = [];
                                      });
                                    }
                                  }
                                },
                                title: Text(listForPlace[index]['description']),
                              );
                            }
                          ),
                        ),
                      ),
                    ) : const SizedBox(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
