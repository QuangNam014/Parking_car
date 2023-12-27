
import 'package:app/constants/image.dart';
import 'package:app/features/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentSuccessScreen extends StatelessWidget {
  const PaymentSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Image.asset(logoPaymentSuccess, height: 200,),
              const Text("Success!", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, letterSpacing: 1),),
              const SizedBox(height: 10,),
              const Text("Thank you! for using app", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500,),),
            ],
          ),
          const SizedBox(height: 40,),

          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
              onPressed: () => Get.offAll(() => const HomeScreen()),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFDB3022),
                minimumSize: const Size(400, 50),
              ),
              child: const Text("Back to home", style: TextStyle(color: Colors.white),),
            ),
          )
        ],
      ),
    );
  }
}