import 'package:flutter/material.dart';

class FrontCreditTextWidget extends StatelessWidget {
  const FrontCreditTextWidget({
    super.key, 
    required this.label, 
    required this.value
  });

  final String label, value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.bold),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w600,
            letterSpacing: .5,
          ),
        )
      ],
    );
  }
}