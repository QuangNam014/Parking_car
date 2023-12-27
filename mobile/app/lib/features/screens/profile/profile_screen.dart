import 'package:app/features/controllers/profile/update_infor_controller.dart';
import 'package:intl/intl.dart';
import 'package:app/constants/color.dart';
import 'package:app/constants/size.dart';
import 'package:app/constants/text.dart';
import 'package:app/constants/image.dart';
import 'package:app/features/models/profile/profile_user.dart';
import 'package:app/features/screens/profile/menu_profile_widget.dart';
import 'package:app/features/screens/profile/profile_information_screen.dart';
import 'package:app/features/screens/profile/profile_modal_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isLoading = false;
  final controller = Get.put(UpdateInforController());

  @override
  void initState() {
    super.initState();
    controller.futureProfileUser.value = controller.getProfileUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(onPressed: () => Get.back(), icon: const Icon(LineAwesomeIcons.angle_left)),
        title: const Text(textProfile, style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.normal)),
      ),
      body: SingleChildScrollView(
        child: Obx(() => FutureBuilder<ProfileUser>(
            future: controller.futureProfileUser.value,
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if(snapshot.hasError) {
                return Center(child: Text('${snapshot.error}'));
              } else if(snapshot.data == null) {
                return const Center(child: Text('No data available!'));
              } else {
                DateTime createdAt = DateTime.parse(snapshot.data!.createdAt!);
                String formattedCreatedAt = DateFormat('dd MMMM yyyy').format(createdAt);
                return Container(
                  padding: const EdgeInsets.all(defaultSize),
                  child: Column(
                    children: [
                
                      /// -- IMAGE
                      Stack(
                        children: [
                          SizedBox(
                            width: 120,
                            height: 120,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(100), child: (snapshot.data!.imageUrl!.isEmpty) ? const Image(image: AssetImage(tProfileImage)) : Image(image: NetworkImage(snapshot.data!.imageUrl!))),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(snapshot.data!.fullname!, style: const TextStyle(fontSize: 28.0, fontWeight: FontWeight.normal)),
                
                
                      Text.rich(
                            TextSpan(
                              text: 'Joined: ',
                              style: const TextStyle(fontSize: 14),
                              children: [
                                TextSpan(
                                  text: formattedCreatedAt,
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                
                      const SizedBox(height: 20),
                
                      /// -- BUTTON
                      SizedBox(
                        width: 200,
                        child: ElevatedButton(
                          onPressed: () => ProfileModalScreen.showModelBottomSheetProfile(context, snapshot.data!),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor, side: BorderSide.none, shape: const StadiumBorder()),
                          child: const Text(textEditProfile, style: TextStyle(color: darkColor)),
                        ),
                      ),
                      const SizedBox(height: 30),
                      const Divider(),
          
                      ProfileMenuWidget(title: "Wallet:  ${snapshot.data!.wallet} \$", icon: LineAwesomeIcons.wallet, endIcon: false,),
                
                      ProfileMenuWidget(title: "Information", icon: LineAwesomeIcons.info, onPress: () {
                        Get.to(() => const ProfileInformationScreen(), arguments: snapshot.data!);
                      }),
                      const SizedBox(height: 10),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}