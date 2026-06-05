import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:project_1/features/home/presentation/view/home_screen.dart';

class CustomMasterCard extends StatefulWidget {
  const CustomMasterCard({super.key});

  @override
  State<CustomMasterCard> createState() => _CustomMasterCardState();
}

class _CustomMasterCardState extends State<CustomMasterCard> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextStyle textStyle = const TextStyle(color: Colors.black);
  final OutlineInputBorder border = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
    borderRadius: const BorderRadius.all(Radius.circular(10)),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [Icon(Icons.payment), const Text('Payment Details')],
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            CreditCardWidget(
              cardNumber: cardNumber,
              expiryDate: expiryDate,
              cardHolderName: cardHolderName,
              cvvCode: cvvCode,
              showBackView: isCvvFocused,
              bankName: 'My Bank',
              cardBgColor: Colors.black87,
              obscureCardNumber: true,
              obscureCardCvv: true,
              isHolderNameVisible: true,
              onCreditCardWidgetChange: (CreditCardBrand creditCardBrand) {},
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CreditCardForm(
                      formKey: formKey,
                      cardNumber: cardNumber,
                      cvvCode: cvvCode,
                      cardHolderName: cardHolderName,
                      expiryDate: expiryDate,
                      onCreditCardModelChange: onCreditCardModelChange,

                      inputConfiguration: InputConfiguration(
                        cardNumberDecoration: InputDecoration(
                          labelText: 'Card Number',
                          labelStyle: textStyle,
                          focusedBorder: border,
                          enabledBorder: border,
                        ),
                        expiryDateDecoration: InputDecoration(
                          labelText: 'Expiry Date',
                          labelStyle: textStyle,
                          focusedBorder: border,
                          enabledBorder: border,
                        ),
                        cvvCodeDecoration: InputDecoration(
                          labelText: 'CVV',
                          labelStyle: textStyle,
                          focusedBorder: border,
                          enabledBorder: border,
                        ),
                        cardHolderDecoration: InputDecoration(
                          labelText: 'Card Holder',
                          labelStyle: textStyle,
                          focusedBorder: border,
                          enabledBorder: border,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          print('Valid!');

                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const HomeScreen();
                              },
                            ),
                            (route) => false,
                          );
                        }
                      },
                      child: const Text(
                        'Save',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    if (creditCardModel == null) return;
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}
