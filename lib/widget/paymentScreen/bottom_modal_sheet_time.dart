import 'package:flutter/material.dart';
import 'package:VosxoD/widget/paymentScreen/payment_date_field_and_text_field.dart';

class BottomModalSheetDoubleTime extends StatefulWidget {
  @override
  _BottomModalSheetDoubleTimeState createState() =>
      _BottomModalSheetDoubleTimeState();
}

class _BottomModalSheetDoubleTimeState
    extends State<BottomModalSheetDoubleTime> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 90),
        height: 400,
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
                    'Qarzdorlik Vaqtini Taqsimlash',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        color: Color.fromRGBO(37, 40, 55, 1),
                        fontFamily: 'CeraPro',
                        fontSize: 18,
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
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Summa',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                color: Color.fromRGBO(37, 40, 55, 1),
                                fontFamily: 'CeraPro',
                                fontSize: 20,
                                letterSpacing: 0,
                                fontWeight: FontWeight.normal,
                                height: 1),
                          ),
                          SizedBox(
                            width: 90,
                          ),
                          Text(
                            '570 000 000 so‘m',
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
                    PaymentDateFieldAndTextField(),
                    PaymentDateFieldAndTextField(),
                    Icon(Icons.add_box_outlined,
                        size: 30, color: Colors.green[400]),
                    Row(
                      children: [
                        SizedBox(width: 170),
                        FlatButton(
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
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 5,
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
                      ],
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
}
