import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  const BottomNavigationBarWidget(
    {super.key, required this.onTabChange, required this.listTab}
  );

  final void Function(int)? onTabChange;
  final List<GButton> listTab;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: height * 0.02),
        child: GNav(
          backgroundColor: Colors.white,
          color: Colors.black,
          activeColor: Colors.white70,
          tabBackgroundColor: Colors.grey.shade600,
          onTabChange: (value) => onTabChange!(value),
          gap: 8,
          padding: EdgeInsets.all(height * 0.02),
          tabs: listTab,
        ),
      ),
    );
  }
}
