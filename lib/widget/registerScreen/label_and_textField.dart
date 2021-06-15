import 'package:flutter/material.dart';

class LabelTextAndTextField extends StatefulWidget {
  final String? hintText;
  final String? labelText;
  final TextEditingController? controller;
  // final Function submit;
  final Icon? icon;
  final Function? valEmail;

  const LabelTextAndTextField(
      {this.hintText,
      this.labelText,
      this.controller,
      // this.submit,
      this.icon,
      this.valEmail});

  @override
  _LabelTextAndTextFieldState createState() => _LabelTextAndTextFieldState();
}

class _LabelTextAndTextFieldState extends State<LabelTextAndTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 13,
            left: 35,
            right: 30,
          ),
          child: Text(
            widget.labelText!,
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Color.fromRGBO(0, 0, 0, 1),
                fontFamily: 'CeraPro',
                fontSize: 16,
                letterSpacing: 0,
                fontWeight: FontWeight.normal,
                height: 1),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, top: 8),
          child: TextFormField(
            controller: widget.controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              suffixIcon: widget.icon,
              hintText: widget.hintText,
            ),
            validator: (val) => widget.valEmail!(val),
          ),
        ),
      ],
    );
  }
}
