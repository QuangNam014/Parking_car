
import 'package:app/constants/text.dart';
import 'package:app/widgets/card_payment/back_credit_card/back_credit_card_widget.dart';
import 'package:app/widgets/card_payment/form_credit_card/form_credit_card_widget.dart';
import 'package:app/widgets/card_payment/front_credit_card/front_credit_card_widget.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';


class CardPaymentScreen extends StatefulWidget {
  const CardPaymentScreen({super.key});

  @override
  State<CardPaymentScreen> createState() => _CardPaymentScreenState();
}

class _CardPaymentScreenState extends State<CardPaymentScreen> {

  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController cardHolderNameController = TextEditingController();
  final TextEditingController cardExpiriedDateController = TextEditingController();
  final TextEditingController cardCvvController = TextEditingController();
  final FlipCardController flipCardController = FlipCardController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  onChangedCardNumber(value) {
    var text = value.replaceAll(RegExp(r'\s+\b|\b\s'), ' ');
    setState(() {
        cardNumberController.value = cardNumberController.value
        .copyWith(
          text: text,
          selection: TextSelection.collapsed(offset: text.length),
          composing: TextRange.empty
        );
      }
    );
  }

  onChangedcardHolderName(value) {
    setState(() {
        cardHolderNameController.value = cardHolderNameController.value
        .copyWith(
            text: value,
            selection: TextSelection.collapsed(offset: value.length),
            composing: TextRange.empty
        );
      }
    );
  }

  onChangedCardExpiriedDate(value) {
    var text = value.replaceAll(RegExp(r'\s+\b|\b\s'), ' ');
      setState(() {
        cardExpiriedDateController.value = cardExpiriedDateController.value
        .copyWith(
          text: text,
          selection: TextSelection.collapsed(offset: text.length),
          composing: TextRange.empty
        );
      }
    );
  }

  onChangedcardCvv(value) {
      setState(() {
        cardCvvController.text = value;
      }
    );  
  }

  onTapcardCvv() {
      setState(() {
        Future.delayed(const Duration(milliseconds: 300), () {
          flipCardController.toggleCard();
        });
      }
    );
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(onPressed: () => Get.back(), icon: const Icon(LineAwesomeIcons.angle_left)),
        title: const Text(textCreditCard, style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.normal)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              FlipCard(
                  fill: Fill.fillFront,
                  direction: FlipDirection.HORIZONTAL,
                  controller: flipCardController,
                  flipOnTouch: true,
                  front: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: FrontCreditCardWidget(
                      cardExpiration: cardExpiriedDateController.text.isEmpty ? "XX/XXXX" : cardExpiriedDateController.text,
                      cardHolder: cardHolderNameController.text.isEmpty ? "Card Holder" : cardHolderNameController.text.toUpperCase(),
                      cardNumber: cardNumberController.text.isEmpty ? "XXXX XXXX XXXX XXXX" : cardNumberController.text,
                    ),
                  ),
                  back: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: BackCreditCardWidget(cardCvv: cardCvvController.text.isEmpty ? "XXX" : cardCvvController.text),
                  ),
                ),
              
              const SizedBox(height: 40),


              FormCreditCardWidget.formCreditCard(
                context, formKey,
                cardNumberController, onChangedCardNumber,
                cardHolderNameController, onChangedcardHolderName,
                cardExpiriedDateController, onChangedCardExpiriedDate,
                cardCvvController, onChangedcardCvv, onTapcardCvv
              ),
            ],
          ),
        ),
      ),
    );
  }

  
}
