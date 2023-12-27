import 'package:app/constants/color.dart';
import 'package:flutter/material.dart';

class DrawerItemBtnWidget extends StatelessWidget {
  const DrawerItemBtnWidget({
    super.key,
    required this.onTap,
    required this.title,
    required this.icon,
    this.colorIcon
  });

  final VoidCallback onTap;
  final IconData icon;
  final String title;
  final Color? colorIcon;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25),
      child: ListTile(
        onTap: onTap,
        leading: Icon(
          icon,
          color: colorIcon ?? Colors.grey[700],
        ),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, color: colorIcon ?? darkColor),
        ),
      ),
    );
  }
}