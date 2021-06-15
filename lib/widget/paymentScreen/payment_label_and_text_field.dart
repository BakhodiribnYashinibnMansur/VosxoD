import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class PaymentLabelTextField extends StatelessWidget {
  final textInputFormatter;
  final String? text;
  final String? hintText;
  final TextEditingController? controller;
  final bool? keyboardType;
  const PaymentLabelTextField(
      {this.text,
      this.hintText,
      this.controller,
      this.keyboardType,
      this.textInputFormatter});

  @override
  Widget build(BuildContext context) {
    // controller.value = textInputFormatter.updateMask(
    //   mask: '+998 (##) ###-##-##',
    // );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Row(
        children: [
          Text(
            text!,
            textAlign: TextAlign.right,
            style: TextStyle(
                color: Color.fromRGBO(37, 40, 55, 1),
                fontFamily: 'CeraPro',
                fontSize: 22,
                letterSpacing: 0,
                fontWeight: FontWeight.normal,
                height: 1),
          ),
          SizedBox(
            width: 45,
          ),
          Expanded(
            child: TextField(
              inputFormatters: keyboardType! ? [textInputFormatter] : null,
              controller: controller,
              // autofocus: true,
              keyboardType:
                  keyboardType! ? TextInputType.phone : TextInputType.text,
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                fillColor: Colors.white,
                contentPadding: EdgeInsets.only(
                  top: 7,
                  left: 15,
                  right: 5,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                  borderSide: const BorderSide(
                    color: Color(0xFFA5A5A5),
                    width: 1.0,
                  ),
                ),
                hintText: hintText,
                hintStyle: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
