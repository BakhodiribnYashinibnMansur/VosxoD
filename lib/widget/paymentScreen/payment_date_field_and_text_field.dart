import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';

class PaymentDateFieldAndTextField extends StatefulWidget {
  @override
  _PaymentDateFieldAndTextFieldState createState() =>
      _PaymentDateFieldAndTextFieldState();
}

class _PaymentDateFieldAndTextFieldState
    extends State<PaymentDateFieldAndTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Row(
        children: [
          Container(
            width: 150,
            child: DateTimeFormField(
              decoration: const InputDecoration(
                hintStyle: TextStyle(color: Colors.black45),
                errorStyle: TextStyle(color: Colors.redAccent),
                suffixIcon: Icon(Icons.event_note),
                hintText: 'dd/mm/yyyy',
              ),
              mode: DateTimeFieldPickerMode.date,
              autovalidateMode: AutovalidateMode.always,
              validator: (e) {},
              // (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
              onDateSelected: (DateTime value) {},
            ),
          ),
          // SizedBox(
          //   width: 45,
          // ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
            width: 212,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
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
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  'so‘m',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      color: Color.fromRGBO(37, 40, 55, 1),
                      fontFamily: 'CeraPro',
                      fontSize: 18.5,
                      letterSpacing: 0,
                      fontWeight: FontWeight.normal,
                      height: 1),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
