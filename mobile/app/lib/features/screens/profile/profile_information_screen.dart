import 'package:app/constants/size.dart';
import 'package:app/constants/text.dart';
import 'package:app/constants/image.dart';
import 'package:app/features/models/profile/profile_user.dart';
import 'package:app/features/screens/profile/menu_profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:intl/intl.dart';


class ProfileInformationScreen extends StatelessWidget {
  const ProfileInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final ProfileUser arguments = Get.arguments;
    DateTime createdAt = DateTime.parse(arguments.createdAt!);
    String formattedCreatedAt = DateFormat('dd MMMM yyyy').format(createdAt);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(onPressed: () => Get.back(), icon: const Icon(LineAwesomeIcons.angle_left)),
        title: const Text(textProfileInformation, style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.normal)),
      ),
      body: SingleChildScrollView(
        child: Container(
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
                        borderRadius: BorderRadius.circular(100), child: (arguments.imageUrl!.isEmpty) ? const Image(image: AssetImage(tProfileImage)) : Image(image: NetworkImage(arguments.imageUrl!))),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(arguments.fullname!, style: const TextStyle(fontSize: 28.0, fontWeight: FontWeight.normal)),


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
              const Divider(),
              const SizedBox(height: 10),

              // /// -- MENU
              ProfileMenuWidget(title: arguments.fullname!, icon: LineAwesomeIcons.check, endIcon: false),
              ProfileMenuWidget(title: arguments.phone!, icon: LineAwesomeIcons.check, endIcon: false),
              ProfileMenuWidget(title: arguments.email!, icon: LineAwesomeIcons.check, endIcon: false),
              (arguments.userDocument!.isNotEmpty) ? ProfileMenuWidget(title: arguments.userDocument!, icon: LineAwesomeIcons.check, endIcon: false) : const SizedBox(),
              (arguments.userLicense!.isNotEmpty) ? ProfileMenuWidget(title: arguments.userLicense!, icon: LineAwesomeIcons.check, endIcon: false) : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}