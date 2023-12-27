import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreditInputFieldWidget extends StatelessWidget {
  const CreditInputFieldWidget({
    super.key,
    required this.widthSize,
    required this.nameController,
    required this.hintText,
    required this.icon,
    required this.onChanged,
    this.type,
    this.listFormat,
    this.onTap,
  });

  final double widthSize;
  final TextEditingController nameController;
  final String hintText;
  final IconData icon;
  final Function(String) onChanged;
  final TextInputType? type;
  final List<TextInputFormatter>? listFormat;
  final Function()? onTap;


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: MediaQuery.of(context).size.width / widthSize,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: nameController,
        keyboardType: type,
        decoration:  InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey,fontSize: 16),
          prefixIcon: Icon(icon,color: Colors.grey),
        ),
        inputFormatters: listFormat,
        onTap: onTap,
        onChanged: (value) => onChanged(value),
      ),
    );
  }
}