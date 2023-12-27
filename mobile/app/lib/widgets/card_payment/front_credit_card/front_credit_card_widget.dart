import 'package:app/constants/color.dart';
import 'package:app/constants/image.dart';
import 'package:app/constants/text.dart';
import 'package:app/widgets/card_payment/front_credit_card/front_credit_card_text_widget.dart';
import 'package:flutter/material.dart';

class FrontCreditCardWidget extends StatelessWidget {
  const FrontCreditCardWidget({
    super.key, 
    required this.cardNumber, 
    required this.cardHolder, 
    required this.cardExpiration
  });

  final String cardNumber, cardHolder, cardExpiration;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      color: creditBgColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Container(
        height: 230,
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  textCreditCardBrand,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1,
                  ),
                ),
                Image.asset(logoCreditMasterCard,height: 60,width: 60),
              ],
            ),
            Row(
              children: [
                Image.asset(logoCreditChip,height: 50,width: 60),
                const SizedBox(width: 8),
                Image.asset(logoCreditSound,height: 50,width: 60),
              ],
            ),
            Text(
              cardNumber,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 21,
                letterSpacing: 4,
                fontWeight: FontWeight.w500,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FrontCreditTextWidget(label: 'CARDHOLDER', value: cardHolder),
                FrontCreditTextWidget(label: 'VALID THRU', value: cardExpiration),
              ],
            ),
          ],
        ),
      ),
    );
  }
}