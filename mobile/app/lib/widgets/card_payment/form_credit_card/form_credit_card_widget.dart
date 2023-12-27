import 'package:app/constants/color.dart';
import 'package:app/constants/size.dart';
import 'package:app/constants/text.dart';
import 'package:app/widgets/card_payment/form_credit_card/credit_input_field_widget.dart';
import 'package:app/widgets/card_payment/form_credit_card/form_credit_date_format.dart';
import 'package:app/widgets/card_payment/form_credit_card/form_credit_input_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormCreditCardWidget  {
  
    static formCreditCard(
      BuildContext context, GlobalKey<FormState> formKey,
      TextEditingController cardNumber, Function(String) onChangedCardNumber,
      TextEditingController cardHolderName, Function(String) onChangedcardHolderName,
      TextEditingController cardExpiriedDate, Function(String) onChangedCardExpiriedDate,
      TextEditingController cardCvv, Function(String) onChangedcardCvv, Function() onTapcardCvv

    ) {

      return Form(
        key: formKey,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: formHeight - 10),
          child: Column(
            children: [
              CreditInputFieldWidget(
                hintText: textFormCreditCardNumber,
                icon: Icons.credit_card,
                nameController: cardNumber,
                widthSize: 1.12,
                onChanged: onChangedCardNumber,
                type: TextInputType.number,
                listFormat: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(16),
                  FormInputCreditFormatter(),
                ],
              ),

              const SizedBox(height: 12),
              
              CreditInputFieldWidget(
                hintText: textFullName,
                icon: Icons.person,
                nameController: cardHolderName,
                widthSize: 1.12,
                onChanged: onChangedcardHolderName,
                type: TextInputType.name,
              ),
              
              const SizedBox(height: 12),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CreditInputFieldWidget(
                    hintText: textFormCreditCardExpiriedDate,
                    icon: Icons.calendar_today,
                    nameController: cardExpiriedDate,
                    widthSize: 2.4,
                    onChanged: onChangedCardExpiriedDate,
                    type: TextInputType.number,
                    listFormat: [
                       FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(4),
                        FormDateCreditFormatter(),
                    ],
                  ),
                  
                  const SizedBox(width: 14),
                  
                  CreditInputFieldWidget(
                    hintText: textFormCreditCardCvv,
                    icon: Icons.lock,
                    nameController: cardCvv,
                    widthSize: 2.4,
                    onChanged: onChangedcardCvv,
                    type: TextInputType.number,
                    onTap: onTapcardCvv,
                    listFormat: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(3),
                    ],
                  ),
                ],
              ),
              
              const SizedBox(height: 20 * 3),

              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    print("number: ${cardNumber.text} --- name: ${cardHolderName.text} --- date: ${cardExpiriedDate.text} --- cvv: ${cardCvv.text}");
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor, side: BorderSide.none, shape: const StadiumBorder()),
                  child: const Text(textUpdate, style: TextStyle(color: darkColor)),
                ),
              ),

            ],
          ),
        ),
      );
    }
}


