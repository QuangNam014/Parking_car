import 'package:flutter/material.dart';

class DetailItemWidget extends StatelessWidget {
  const DetailItemWidget({
    super.key,
    required this.title, required this.subtitle
    // this.onPressed
  });

  final String title, subtitle;
  // final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(17.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 10,
            spreadRadius: 3,
            offset: const Offset(3, 4),
          )
        ],
      ),
      child:  Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        child: Row(
          children:  [
            Expanded(
              flex: 1,
              child: Text(
                title,
                style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
              ),
            ),
        
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Text(
                  subtitle,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}