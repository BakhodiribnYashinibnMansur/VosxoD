import 'package:flutter/material.dart';
import 'package:VosxoD/const/const.dart';

class RegisterScreenNavbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 15,
            left: 15,
          ),
          child: Icon(
            Icons.account_circle_outlined,
            color: cRegisterTitleColor,
            size: 45,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 100,
            top: 25,
          ),
          child: Text(
            'VOSXOD',
            style: TextStyle(
              color: cRegisterTitleColor,
              fontFamily: 'CeraPro',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              height: 1,
            ),
          ),
        ),
      ],
    );
  }
}
