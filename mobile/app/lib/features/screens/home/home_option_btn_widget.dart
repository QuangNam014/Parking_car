import 'package:app/constants/color.dart';
import 'package:flutter/material.dart';

class OptionHomeBtnWidget extends StatelessWidget {
  const OptionHomeBtnWidget({
    super.key,
    required this.onTap,
    required this.image,
    required this.title,
    this.colorText,
    this.colorBgCard
  });

  final VoidCallback onTap;
  final Color? colorBgCard;
  final Color? colorText;
  final String image, title;

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width*0.4;

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: screenWidth,
        height: 160.0,
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
                children: [
                  Image(
                    image: AssetImage(image),
                    width: 64.0,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    title,
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
      ),
    );
  }
}