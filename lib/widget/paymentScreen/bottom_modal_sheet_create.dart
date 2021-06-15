import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:VosxoD/provider/home_data_provider.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'payment_label_and_text_field.dart';

class BottomModalSheetDoubleCreate extends StatefulWidget {
  @override
  _BottomModalSheetDoubleCreateState createState() =>
      _BottomModalSheetDoubleCreateState();
}

class _BottomModalSheetDoubleCreateState
    extends State<BottomModalSheetDoubleCreate> {
  TextEditingController personName = TextEditingController();
  TextEditingController personPhone = TextEditingController();
  TextEditingController personAddress = TextEditingController();
  var maskFormatterPhone = MaskTextInputFormatter(
      mask: '+998(##)###-##-##', filter: {"#": RegExp(r'[0-9]')});
  var maskFormatterString = MaskTextInputFormatter();

  @override
  Widget build(BuildContext context) {
    final personData = Provider.of<HomeDataProvider>(context);
    personName.text = personData.returnPersonName() != 'null'
        ? personData.returnPersonName()
        : '';
    personPhone.text = personData.returnPersonPhone() != 'null'
        ? personData.returnPersonPhone()
        : '';
    personAddress.text = personData.returnPersonAddress() != 'null'
        ? personData.returnPersonAddress()
        : '';
    return Container(
      height: 325,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(0),
        ),
        color: Color.fromRGBO(248, 248, 249, 1),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 15,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Qarzdorlik yaratish',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      color: Color.fromRGBO(37, 40, 55, 1),
                      fontFamily: 'CeraPro',
                      fontSize: 22,
                      letterSpacing: 0,
                      fontWeight: FontWeight.normal,
                      height: 1),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    Icons.close,
                    size: 25,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                PaymentLabelTextField(
                  text: 'Ism',
                  hintText: ' ',
                  controller: personName,
                  keyboardType: false,
                  textInputFormatter: maskFormatterString,
                ),
                PaymentLabelTextField(
                  text: 'Tel.',
                  hintText: '+998 (_ _) _ _ _   _ _  _ _   ',
                  controller: personPhone,
                  keyboardType: true,
                  textInputFormatter: maskFormatterPhone,
                ),
                PaymentLabelTextField(
                  text: 'Manzil',
                  hintText: ' ',
                  controller: personAddress,
                  keyboardType: false,
                  textInputFormatter: maskFormatterString,
                ),
                Row(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 170),
                    RaisedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Bekor qilish',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Color.fromRGBO(146, 146, 146, 1),
                          fontFamily: 'Cera Pro',
                          fontSize: 12,
                          letterSpacing: 0,
                          fontWeight: FontWeight.normal,
                          height: 1,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        personData.givePersonName(personName.text);
                        personData.givePersonPhone(personPhone.text);
                        personData.givePersonAddress(personAddress.text);
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 15,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(26),
                            topRight: Radius.circular(26),
                            bottomLeft: Radius.circular(26),
                            bottomRight: Radius.circular(26),
                          ),
                          color: Color.fromRGBO(0, 193, 112, 1),
                        ),
                        child: Center(
                          child: Text(
                            'Saqlash',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 1),
                                fontFamily: 'Cera Pro',
                                fontSize: 12,
                                letterSpacing: 0,
                                fontWeight: FontWeight.normal,
                                height: 1),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
