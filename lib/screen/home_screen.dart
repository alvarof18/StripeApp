import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:stripe_app/data/tarjetas.dart';
import 'package:stripe_app/helpers/helpers.dart';
import 'package:stripe_app/screen/screen.dart';
import 'package:stripe_app/widgets/total_pay_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Pay'),
        actions: [
          IconButton(
              onPressed: () async {
                mostrarLoading(context);
                await Future.delayed(const Duration(seconds: 1));
                Navigator.pop(context);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: Stack(children: [
        Positioned(
          top: 150,
          height: size.height,
          width: size.width,
          child: PageView.builder(
              controller: PageController(viewportFraction: 0.9),
              physics: const BouncingScrollPhysics(),
              itemCount: tarjetas.length,
              itemBuilder: (_, i) {
                final tarjeta = tarjetas[i];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context, navegarFadeIn(context, const CardScreen()));
                  },
                  child: Hero(
                    tag: tarjeta.cardNumber,
                    child: CreditCardWidget(
                        cardNumber: tarjeta.cardNumber,
                        expiryDate: tarjeta.expiracyDate,
                        cardHolderName: tarjeta.cardHolderName,
                        cvvCode: tarjeta.cvv,
                        showBackView: false,
                        onCreditCardWidgetChange:
                            (CreditCardBrand creditCardBrand) {}),
                  ),
                );
              }),
        ),
        Positioned(
          bottom: 0,
          child: TotalPayButton(),
        )
      ]),
    );
  }
}
