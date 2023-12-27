import 'package:app/constants/color.dart';
import 'package:flutter/material.dart';

class OptionDashboardWidget extends StatelessWidget {
  const OptionDashboardWidget({
    super.key,
    required this.subTitle,
    required this.title,
    this.colorText,
    this.colorBgCard
  });

  final Color? colorBgCard;
  final Color? colorText;
  final String subTitle, title;

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width*0.4;

    return SizedBox(
      width: screenWidth,
      height: 130.0,
      child: Card(
        color: colorBgCard ?? const Color.fromRGBO(245, 221, 39, 0.486),
        elevation: 2.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0)),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: darkColor,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  subTitle,
                  style: TextStyle(
                    color: colorText ?? darkColor,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
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