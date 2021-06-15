import 'package:flutter/material.dart';

class PaymentTypeCard extends StatelessWidget {
  final String? text;
  final Color? color;

  const PaymentTypeCard({this.text, this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: 40,
      margin: EdgeInsets.symmetric(
        vertical: 2,
        horizontal: 4,
      ),
      padding: EdgeInsets.symmetric(
        vertical: 4,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(33),
          topRight: Radius.circular(33),
          bottomLeft: Radius.circular(33),
          bottomRight: Radius.circular(33),
        ),
        color: color,
      ),
      child: Center(
        child: Text(
          text!,
          textAlign: TextAlign.left,
          style: TextStyle(
              color: Color.fromRGBO(37, 40, 55, 1),
              fontFamily: 'CeraPro',
              fontSize: 14,
              letterSpacing: 0,
              fontWeight: FontWeight.normal,
              height: 1),
        ),
      ),
    );
  }
}
