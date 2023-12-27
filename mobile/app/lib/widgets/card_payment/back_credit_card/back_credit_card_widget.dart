import 'package:app/constants/color.dart';
import 'package:app/constants/text.dart';
import 'package:app/widgets/card_payment/back_credit_card/back_painter_widget.dart';
import 'package:flutter/material.dart';

class BackCreditCardWidget extends StatelessWidget {
  const BackCreditCardWidget({super.key, required this.cardCvv});

  final String cardCvv;

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
          children: [
            const SizedBox(height: 0),
            const Text(
              textCreditCardLink,
              style: TextStyle(color: Colors.white54, fontSize: 11),
            ),
            Container(
              height: 45,
              width: MediaQuery.of(context).size.width / 1.2,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            CustomPaint(
              painter: BackPainterWidget(),
              child: SizedBox(
                height: 42,
                width: MediaQuery.of(context).size.width / 1.2,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(left:8.0, right: 8.0, top: 8.0, bottom: 8.0),
                    child: Text(
                      cardCvv,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 21,
                        fontStyle: FontStyle.italic
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              textCreditCardDescription,
              style: TextStyle(color: Colors.white54, fontSize: 11),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}