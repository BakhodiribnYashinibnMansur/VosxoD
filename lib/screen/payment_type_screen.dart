import 'dart:async';
import 'dart:convert';

import 'package:VosxoD/const/const.dart';
import 'package:VosxoD/provider/cart_provider.dart';
import 'package:VosxoD/provider/home_data_provider.dart';
import 'package:VosxoD/screen/history_screen.dart';
import 'package:VosxoD/screen/home_screen.dart';
import 'package:VosxoD/utils/my_prefs.dart';
import 'package:VosxoD/widget/footer.dart';
import 'package:VosxoD/widget/homeScreen/home_screen_navbar.dart';
import 'package:VosxoD/widget/paymentScreen/bottom_modal_sheet_create.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:passcode_screen/circle.dart';
import 'package:passcode_screen/keyboard.dart';
import 'package:passcode_screen/passcode_screen.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class PaymentTypeScreen extends StatefulWidget {
  static const routeName = '/paymentTypeScreen';
  final double? amount;
  final int? stockId;
  const PaymentTypeScreen({
    this.amount,
    this.stockId,
  });
  @override
  _PaymentTypeScreenState createState() => _PaymentTypeScreenState();
}

class _PaymentTypeScreenState extends State<PaymentTypeScreen> {
  late Future<void> futurePayment;
  late Future<void> futurePost;
  late List<dynamic> paymentList = [];
  int? lengthOfArray = 0;
  bool? isAuthenticated = false;
  Future<void> getPayment() async {
    final TOKEN = MyPref.token;
    Uri URL = Uri.parse("https://vosxod.uz/api/all-payment-types");
    try {
      final response = await http.get(
        URL,
        headers: {"token": TOKEN},
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> map = json.decode(response.body);
        List<dynamic> dataItem = map["payment_type"];
        setState(() {
          paymentList = dataItem;
          lengthOfArray = paymentList.length;
          _selected[lengthOfArray! - 1] = true;
        });
        addPaymentInfo();
        setState(() {
          paymentInfo[lengthOfArray! - 1]['controller'].text =
              widget.amount!.toInt().toString();
        });
        // return dataItem.map((item) => Payment.fromJson(item)).toList();
      } else {
        throw Exception('Malumotlarni yuklashda omadsizlikkga uchradi .');
      }
    } catch (error) {
      throw error;
    }
  }

  var sellDetails = {
    "payment": [],
    "person": [],
    "products": [],
    "stock": [],
  };

  void addPayment() {
    if (lengthOfArray! == 3) {
      sellDetails['payment']!.add({
        "id": paymentInfo[0]['paymentID'],
        "payment": int.parse(paymentInfo[0]['controller'].text != ''
            ? paymentInfo[0]['controller'].text
            : '0'),
      });
      sellDetails['payment']!.add({
        "id": paymentInfo[1]['paymentID'],
        "payment": int.parse(paymentInfo[1]['controller'].text != ''
            ? paymentInfo[1]['controller'].text
            : '0'),
      });
      sellDetails['payment']!.add({
        "id": paymentInfo[2]['paymentID'],
        "payment": int.parse(paymentInfo[2]['controller'].text != ''
            ? paymentInfo[2]['controller'].text
            : '0'),
      });
    }
    if (lengthOfArray! == 4) {
      sellDetails['payment']!.add({
        "id": paymentInfo[0]['paymentID'],
        "payment": int.parse(paymentInfo[0]['controller'].text != ''
            ? paymentInfo[0]['controller'].text
            : '0'),
      });
      sellDetails['payment']!.add({
        "id": paymentInfo[1]['paymentID'],
        "payment": int.parse(paymentInfo[1]['controller'].text != ''
            ? paymentInfo[1]['controller'].text
            : '0'),
      });
      sellDetails['payment']!.add({
        "id": paymentInfo[2]['paymentID'],
        "payment": int.parse(paymentInfo[2]['controller'].text != ''
            ? paymentInfo[2]['controller'].text
            : '0'),
      });
      sellDetails['payment']!.add({
        "id": paymentInfo[3]['paymentID'],
        "payment": int.parse(paymentInfo[3]['controller'].text != ''
            ? paymentInfo[3]['controller'].text
            : '0'),
      });
    }
    if (lengthOfArray! == 5) {
      sellDetails['payment']!.add({
        "id": paymentInfo[0]['paymentID'],
        "payment": int.parse(paymentInfo[0]['controller'].text != ''
            ? paymentInfo[0]['controller'].text
            : '0'),
      });
      sellDetails['payment']!.add({
        "id": paymentInfo[1]['paymentID'],
        "payment": int.parse(paymentInfo[1]['controller'].text != ''
            ? paymentInfo[1]['controller'].text
            : '0'),
      });
      sellDetails['payment']!.add({
        "id": paymentInfo[2]['paymentID'],
        "payment": int.parse(paymentInfo[2]['controller'].text != ''
            ? paymentInfo[2]['controller'].text
            : '0'),
      });
      sellDetails['payment']!.add({
        "id": paymentInfo[3]['paymentID'],
        "payment": int.parse(paymentInfo[3]['controller'].text != ''
            ? paymentInfo[3]['controller'].text
            : '0'),
      });
      sellDetails['payment']!.add({
        "id": paymentInfo[4]['paymentID'],
        "payment": int.parse(paymentInfo[4]['controller'].text != ''
            ? paymentInfo[4]['controller'].text
            : '0'),
      });
    }
    if (lengthOfArray! == 6) {
      sellDetails['payment']!.add({
        "id": paymentInfo[0]['paymentID'],
        "payment": int.parse(paymentInfo[0]['controller'].text != ''
            ? paymentInfo[0]['controller'].text
            : '0'),
      });
      sellDetails['payment']!.add({
        "id": paymentInfo[1]['paymentID'],
        "payment": int.parse(paymentInfo[1]['controller'].text != ''
            ? paymentInfo[1]['controller'].text
            : '0'),
      });
      sellDetails['payment']!.add({
        "id": paymentInfo[2]['paymentID'],
        "payment": int.parse(paymentInfo[2]['controller'].text != ''
            ? paymentInfo[2]['controller'].text
            : '0'),
      });
      sellDetails['payment']!.add({
        "id": paymentInfo[3]['paymentID'],
        "payment": int.parse(paymentInfo[3]['controller'].text != ''
            ? paymentInfo[3]['controller'].text
            : '0'),
      });
      sellDetails['payment']!.add({
        "id": paymentInfo[4]['paymentID'],
        "payment": int.parse(paymentInfo[4]['controller'].text != ''
            ? paymentInfo[4]['controller'].text
            : '0'),
      });
      sellDetails['payment']!.add({
        "id": paymentInfo[5]['paymentID'],
        "payment": int.parse(paymentInfo[5]['controller'].text != ''
            ? paymentInfo[5]['controller'].text
            : '0'),
      });
    }
    final jsonDataR = JsonEncoder().convert(sellDetails);
  }

  addPersonDetails(String id, String name, String phone, String address) {
    sellDetails['person']!.add({
      "id": id,

      "name": name,
      "phone": phone,
      "address": address,
    });
    final jsonDataR = JsonEncoder().convert(sellDetails);
  }

  String message = '';
  int? lengthOfMap = 0;
  Future<String> postDetails() async {
    final jsonDataR = JsonEncoder().convert(sellDetails);
    final TOKEN = MyPref.token;
    Uri URL = Uri.parse("https://vosxod.uz/api/buy");
    try {
      final responses = await http.post(
        URL,
        headers: {"token": TOKEN},
        body: jsonDataR,
      );
      if (responses.statusCode == 200) {
        setState(() {
          message = json.decode(responses.body)['message'];
          lengthOfMap = json.decode(responses.body).length;
          isAuthenticated = false;
          context.read<HomeDataProvider>().getCheck(false);
          context.read<CartProviderData>().clearCart();
        });
        showSucceedMessage();
        return message;
      } else {
        message = json.decode(responses.body)['message'];
        if (isAuthenticated == true) {
          showErrorMessage();
        }
        setState(() {
          isAuthenticated = false;
        });
        return message;
      }
    } catch (error) {
      throw error;
    }
  }

  TextEditingController payment0 = TextEditingController();
  TextEditingController payment1 = TextEditingController();
  TextEditingController payment2 = TextEditingController();
  TextEditingController payment3 = TextEditingController();
  TextEditingController payment4 = TextEditingController();
  TextEditingController payment5 = TextEditingController();

  addPaymentInfo() {
    if (lengthOfArray! == 3) {
      paymentInfo.add({
        'paymentType': paymentList[0]['name'],
        'paymentID': paymentList[0]['id'],
        'price': paymentList[0]['price'],
        'controller': payment0
      });
      paymentInfo.add({
        'paymentType': paymentList[1]['name'],
        'paymentID': paymentList[1]['id'],
        'price': paymentList[1]['price'],
        'controller': payment1
      });
      paymentInfo.add({
        'paymentType': paymentList[2]['name'],
        'paymentID': paymentList[2]['id'],
        'price': paymentList[2]['price'],
        'controller': payment2
      });
    }
    if (lengthOfArray! == 4) {
      paymentInfo.add({
        'paymentType': paymentList[0]['name'],
        'paymentID': paymentList[0]['id'],
        'price': paymentList[0]['price'],
        'controller': payment0
      });
      paymentInfo.add({
        'paymentType': paymentList[1]['name'],
        'paymentID': paymentList[1]['id'],
        'price': paymentList[1]['price'],
        'controller': payment1
      });
      paymentInfo.add({
        'paymentType': paymentList[2]['name'],
        'paymentID': paymentList[2]['id'],
        'price': paymentList[2]['price'],
        'controller': payment2
      });
      paymentInfo.add({
        'paymentType': paymentList[3]['name'],
        'paymentID': paymentList[3]['id'],
        'price': paymentList[3]['price'],
        'controller': payment3
      });
    }
    if (lengthOfArray! == 5) {
      paymentInfo.add({
        'paymentType': paymentList[0]['name'],
        'paymentID': paymentList[0]['id'],
        'price': paymentList[0]['price'],
        'controller': payment0
      });
      paymentInfo.add({
        'paymentType': paymentList[1]['name'],
        'paymentID': paymentList[1]['id'],
        'price': paymentList[1]['price'],
        'controller': payment1
      });
      paymentInfo.add({
        'paymentType': paymentList[2]['name'],
        'paymentID': paymentList[2]['id'],
        'price': paymentList[2]['price'],
        'controller': payment2
      });
      paymentInfo.add({
        'paymentType': paymentList[3]['name'],
        'paymentID': paymentList[3]['id'],
        'price': paymentList[3]['price'],
        'controller': payment3
      });
      paymentInfo.add({
        'paymentType': paymentList[4]['name'],
        'paymentID': paymentList[4]['id'],
        'price': paymentList[4]['price'],
        'controller': payment4
      });
    }
    if (lengthOfArray! == 6) {
      paymentInfo.add({
        'paymentType': paymentList[0]['name'],
        'paymentID': paymentList[0]['id'],
        'price': paymentList[0]['price'],
        'controller': payment0
      });
      paymentInfo.add({
        'paymentType': paymentList[1]['name'],
        'paymentID': paymentList[1]['id'],
        'price': paymentList[1]['price'],
        'controller': payment1
      });
      paymentInfo.add({
        'paymentType': paymentList[2]['name'],
        'paymentID': paymentList[2]['id'],
        'price': paymentList[2]['price'],
        'controller': payment2
      });
      paymentInfo.add({
        'paymentType': paymentList[3]['name'],
        'paymentID': paymentList[3]['id'],
        'price': paymentList[3]['price'],
        'controller': payment3
      });
      paymentInfo.add({
        'paymentType': paymentList[4]['name'],
        'paymentID': paymentList[4]['id'],
        'price': paymentList[4]['price'],
        'controller': payment4
      });
      paymentInfo.add({
        'paymentType': paymentList[5]['name'],
        'paymentID': paymentList[5]['id'],
        'price': paymentList[5]['price'],
        'controller': payment5
      });
    }
  }

  var paymentInfo = [];
  List<bool> _selected = [
    false,
    false,
    false,
    false,
    false,
    false,
  ];
  returnDoubte() {
    num summa = (widget.amount!.toInt() -
            int.parse(
                payment0.text.length != 0 ? payment0.text.toString() : '0') -
            (payment1.text.length != 0
                ? int.parse(payment1.text) * paymentInfo[1]['price']
                : 0) -
            (payment2.text.length != 0
                ? int.parse(payment2.text) * paymentInfo[2]['price']
                : 0) -
            (payment3.text.length != 0
                ? int.parse(payment3.text) * paymentInfo[3]['price']
                : 0) -
            (payment4.text.length != 0
                ? int.parse(payment4.text) * paymentInfo[4]['price']
                : 0) -
            (payment5.text.length != 0
                ? int.parse(payment5.text) * paymentInfo[5]['price']
                : 0)) +
        int.parse(paymentInfo[lengthOfArray! - 1]['controller'].text.length != 0
            ? paymentInfo[lengthOfArray! - 1]['controller'].text
            : 0);
    return summa;
  }

  @override
  void initState() {
    super.initState();
    futurePayment = getPayment();
    futurePost = postDetails();
    payment0.addListener(() {
      int summa1 = returnDoubte();
      paymentInfo[lengthOfArray! - 1]['controller'].text = summa1.toString();
    });
    payment1.addListener(() {
      int summa2 = returnDoubte();
      paymentInfo[lengthOfArray! - 1]['controller'].text = summa2.toString();
    });
    payment2.addListener(() {
      int summa3 = returnDoubte();
      paymentInfo[lengthOfArray! - 1]['controller'].text = summa3.toString();
    });
    payment3.addListener(() {
      int summa4 = returnDoubte();
      paymentInfo[lengthOfArray! - 1]['controller'].text = summa4.toString();
    });
    payment4.addListener(() {
      int summa5 = returnDoubte();
      paymentInfo[lengthOfArray! - 1]['controller'].text = summa5.toString();
    });
    payment5.addListener(() {
      int summa6 = returnDoubte();
      paymentInfo[lengthOfArray! - 1]['controller'].text = summa6.toString();
    });
    context.read<HomeDataProvider>().getPageID('2');
  }

  final StreamController<bool> _verificationNotifier =
      StreamController<bool>.broadcast();
  String storedPasscode = PassCode.passcode;
  @override
  Widget build(BuildContext context) {
    final personData = Provider.of<HomeDataProvider>(context);
    final cartData = Provider.of<CartProviderData>(context);
    final normalPrice = widget.amount;
    final formatPrice = NumberFormat.currency(
      name: ' ',
    ).format(normalPrice);
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          color: cHomePageBackgroundColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeScreenNavbar(),
              paymentList.length != 0 && isAuthenticated == false
                  ? Expanded(
                      flex: 25,
                      child: SingleChildScrollView(
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: 1.h,
                                  horizontal: 1.5.h,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Umumiy summa :',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Color.fromRGBO(255, 255, 255, 1),
                                        fontFamily: 'CeraPro',
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.normal,
                                        height: 1,
                                      ),
                                    ),
                                    Text(
                                      formatPrice.toString().substring(
                                          0, formatPrice.toString().length - 3),
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Color.fromRGBO(255, 255, 255, 1),
                                        fontFamily: 'CeraPro',
                                        fontSize: 15.sp,
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.normal,
                                        height: 1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 15.h,
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                  vertical: 1,
                                  horizontal: 1.h,
                                ),
                                child: GridView.builder(
                                  itemCount: paymentList.length,
                                  itemBuilder: (context, index) {
                                    return FilterChip(
                                      selected: _selected[index],
                                      label: Text(paymentList[index]['name'],
                                          style:
                                              TextStyle(color: Colors.white)),
                                      // avatar:,
                                      elevation: 10,
                                      pressElevation: 5,
                                      shadowColor: Colors.teal,
                                      backgroundColor: Colors.black54,
                                      selectedColor: Colors.blue,
                                      onSelected: (bool selected) {
                                        // findPersonUsingIndexWhere();
                                        // addPaymentInfo();
                                        setState(() {
                                          _selected[index] = selected;
                                        });
                                      },
                                    );
                                  },
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10,
                                    childAspectRatio: 7 / 3,
                                  ),
                                ),
                              ),
                              _selected[0] == true
                                  ? SimplePaymentCart(
                                      title: paymentInfo[0]['paymentType']
                                          .toString(),
                                      amount: paymentInfo[0]['controller'],
                                    )
                                  : Container(),
                              _selected[1] == true
                                  ? paymentList[1]['id'] == 0
                                      ? HardPaymentCart(
                                          title: paymentInfo[1]['paymentType']
                                              .toString(),
                                          amount: paymentInfo[1]['controller'],
                                        )
                                      : SimplePaymentCart(
                                          title: paymentInfo[1]['paymentType']
                                              .toString(),
                                          amount: paymentInfo[1]['controller'],
                                        )
                                  : Container(),
                              _selected[2] == true
                                  ? paymentList[2]['id'] == 0
                                      ? HardPaymentCart(
                                          title: paymentInfo[2]['paymentType']
                                              .toString(),
                                          amount: paymentInfo[2]['controller'],
                                        )
                                      : SimplePaymentCart(
                                          title: paymentInfo[2]['paymentType']
                                              .toString(),
                                          amount: paymentInfo[2]['controller'],
                                        )
                                  : Container(),
                              _selected[3] == true
                                  ? paymentList[3]['id'] == 0
                                      ? HardPaymentCart(
                                          title: paymentInfo[3]['paymentType']
                                              .toString(),
                                          amount: paymentInfo[3]['controller'],
                                        )
                                      : SimplePaymentCart(
                                          title: paymentInfo[3]['paymentType']
                                              .toString(),
                                          amount: paymentInfo[3]['controller'],
                                        )
                                  : Container(),
                              _selected[4] == true
                                  ? paymentList[4]['id'] == 0
                                      ? HardPaymentCart(
                                          title: paymentInfo[4]['paymentType']
                                              .toString(),
                                          amount: paymentInfo[4]['controller'],
                                        )
                                      : SimplePaymentCart(
                                          title: paymentInfo[4]['paymentType']
                                              .toString(),
                                          amount: paymentInfo[4]['controller'],
                                        )
                                  : Container(),
                              _selected[5] == true
                                  ? paymentList[5]['id'] == 0
                                      ? HardPaymentCart(
                                          title: paymentInfo[5]['paymentType']
                                              .toString(),
                                          amount: paymentInfo[5]['controller'],
                                        )
                                      : SimplePaymentCart(
                                          title: paymentInfo[5]['paymentType']
                                              .toString(),
                                          amount: paymentInfo[5]['controller'],
                                        )
                                  : Container(),
                              // HardPaymentCart(),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  int qarzdorlik = returnDoubte();
                  if (widget.amount!.toInt() < qarzdorlik ||
                      qarzdorlik < 0 ||
                      personData.returnPersonName() == 'null' ||
                      personData.returnPersonAddress() == 'null' ||
                      personData.returnPersonPhone() == 'null') {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CupertinoAlertDialog(
                            title: Text('Ogohlantirish'.toUpperCase(),
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                )),
                            content: Text(
                                'Hisob kitoblarda xatolik mavjud yoki Kontrogent tanlanmagan . Iltimos to\'g\'irlab qayta harakat qilib ko\'ring !'),
                            actions: <Widget>[
                              CupertinoDialogAction(
                                child: Text(
                                  'ok',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        });
                  } else {
                    sellDetails['products']?.clear();
                    sellDetails['stock']?.clear();
                    sellDetails['payment']?.clear();
                    sellDetails['person']?.clear();
                    cartData.items.values.toList().forEach((cart) {
                      sellDetails['products']?.add({
                        "id": cart.id,
                        "price": cart.price,
                        "count": cart.quantity,
                      });
                    });
                    sellDetails['stock']!.add({"id": widget.stockId});
                    addPayment();
                    addPersonDetails(
                        personData.returnPersonID() == 'null'
                            ? '-100'
                            : personData.returnPersonID(),
                        personData.returnPersonName(),
                        personData.returnPersonPhone(),
                        personData.returnPersonAddress());
                    final jsonDataR = JsonEncoder().convert(sellDetails);
                    _showLockScreen(context,
                        opaque: false,
                        circleUIConfig: CircleUIConfig(
                            borderColor: Colors.blue,
                            fillColor: Colors.blue,
                            circleSize: 30),
                        keyboardUIConfig: KeyboardUIConfig(
                            digitBorderWidth: 2, primaryColor: Colors.blue),
                        cancelButton: Icon(
                          Icons.arrow_back,
                          color: Colors.blue,
                        ),
                        digits: [
                          '1',
                          '2',
                          '3',
                          '4',
                          '5',
                          '6',
                          '7',
                          '8',
                          '9',
                          '0'
                        ]);
                  }
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: .5.h,
                    horizontal: 2.h,
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 1.4.h,
                      horizontal: 2.h,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(38),
                        topRight: Radius.circular(38),
                        bottomLeft: Radius.circular(38),
                        bottomRight: Radius.circular(38),
                      ),
                      color: Color.fromRGBO(0, 193, 112, 1),
                    ),
                    child: Center(
                      child: Text(
                        'Sotish',
                        style: TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 1),
                            fontFamily: 'CeraPro',
                            fontSize: 20,
                            letterSpacing: 0,
                            fontWeight: FontWeight.normal,
                            height: 1),
                      ),
                    ),
                  ),
                ),
              ),
              FootBar(),
            ],
          ),
        ),
      ),
    );
  }

  _showLockScreen(
    BuildContext context, {
    required bool opaque,
    CircleUIConfig? circleUIConfig,
    KeyboardUIConfig? keyboardUIConfig,
    required Widget cancelButton,
    List<String>? digits,
  }) {
    Navigator.push(
      context,
      PageRouteBuilder(
        opaque: opaque,
        pageBuilder: (context, animation, secondaryAnimation) => PasscodeScreen(
          title: Text(
            'Shaxsiy parolizni kiriting',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 28),
          ),
          circleUIConfig: circleUIConfig,
          keyboardUIConfig: keyboardUIConfig,
          passwordEnteredCallback: _onPasscodeEntered,
          cancelButton: cancelButton,
          deleteButton: Text(
            'O\'chirish',
            style: const TextStyle(fontSize: 16, color: Colors.white),
            semanticsLabel: 'O\'chirish',
          ),
          shouldTriggerVerification: _verificationNotifier.stream,
          backgroundColor: Colors.black.withOpacity(0.8),
          cancelCallback: _onPasscodeCancelled,
          digits: digits,
          passwordDigits: 4,
        ),
      ),
    );
  }

  _onPasscodeEntered(String enteredPasscode) {
    bool isValid = storedPasscode == enteredPasscode;
    _verificationNotifier.add(isValid);
    if (isValid) {
      setState(() {
        this.isAuthenticated = isValid;
      });
      postDetails();
    }
  }

  showSucceedMessage() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('Muvofiqiyatli',
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              )),
          content: Text(
            'Xarid Muvofiqiyatli Yakunlandi',
          ),
          actions: <Widget>[
            CupertinoDialogAction(
                child: Icon(Icons.home),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    PageTransition(
                      type: PageTransitionType.fade,
                      child: HomeScreen(),
                      ctx: context,
                      alignment: Alignment.center,
                    ),
                  );
                }),
            CupertinoDialogAction(
                child: Icon(Icons.history_outlined),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    PageTransition(
                      type: PageTransitionType.fade,
                      child: HistoryScreen(),
                      ctx: context,
                      alignment: Alignment.center,
                    ),
                  );
                }),
          ],
        );
      },
    );
  }

  showErrorMessage() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('Xatolik',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              )),
          content: Text(
            'Malumotlarda xatolik mavjudi.',
          ),
          actions: <Widget>[
            CupertinoDialogAction(
                child: Text('ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
          ],
        );
      },
    );
  }

  _onPasscodeCancelled() {
    Navigator.maybePop(context);
  }

  @override
  void dispose() {
    _verificationNotifier.close();
    super.dispose();
  }
}

class Price {
  final int? id;
  final int? price;
  Price({this.id, this.price});
}

class SimplePaymentCart extends StatefulWidget {
  final String? title;
  final TextEditingController? amount;
  const SimplePaymentCart({
    this.title,
    this.amount,
  });

  @override
  _SimplePaymentCartState createState() => _SimplePaymentCartState();
}

class _SimplePaymentCartState extends State<SimplePaymentCart> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Container(
        height: 55,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
          color: Color.fromRGBO(255, 255, 255, 1),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  widget.title!,
                  style: TextStyle(
                    color: Color.fromRGBO(37, 40, 55, 1),
                    fontFamily: 'CeraPro',
                    fontSize: 14,
                    letterSpacing: 0,
                    fontWeight: FontWeight.normal,
                    height: 1,
                  ),
                ),
              ),
              SizedBox(
                width: 55,
              ),
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.right,
                  controller: widget.amount,
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
                    hintText: '0',
                    hintStyle: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HardPaymentCart extends StatelessWidget {
  final String? title;
  final TextEditingController? amount;
  const HardPaymentCart({Key? key, this.title, this.amount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Container(
        width: double.infinity,
        height: 55,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
          color: Color.fromRGBO(255, 255, 255, 1),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 7),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  title!,
                  style: TextStyle(
                    color: Color.fromRGBO(37, 40, 55, 1),
                    fontFamily: 'CeraPro',
                    fontSize: 14,
                    letterSpacing: 0,
                    fontWeight: FontWeight.normal,
                    height: 1,
                  ),
                ),
              ),
              SizedBox(
                width: 25,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Color(0xFFFB7878),
                    style: BorderStyle.solid,
                    width: 2.0,
                  ),
                ),
                padding: EdgeInsets.all(2),
                child: GestureDetector(
                  onTap: () => _showModalBottomSheetDoubteCreate(context),
                  child: Icon(
                    Icons.add,
                    color: Color(0xFFFF5656),
                  ),
                ),
              ),
              SizedBox(
                width: 7,
              ),
              Expanded(
                child: TextField(
                  controller: amount,
                  keyboardType: TextInputType.number,
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
                    hintText: '0',
                    hintStyle: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _showModalBottomSheetDoubteCreate(context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Color(0x00A0A0A0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
    builder: (BuildContext context) {
      return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: BottomModalSheetDoubleCreate());
    },
  );
}

void OpenDialogtFalse(context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('Ogohlantirish'.toUpperCase(),
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              )),
          content: Text(
              'Hisob kitoblarda xatolik mavjud. Iltimos to\'g\'irlab qayta harakat qilib ko\'ring !'),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text('ok',
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  )),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
}

// void _showModalBottomSheetDoubteTime(context) {
//   showModalBottomSheet(
//     context: context,
//     backgroundColor: Color(0x00A0A0A0),
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(8.0),
//     ),
//     isScrollControlled: true,
//     builder: (BuildContext context) {
//       return SafeArea(child: BottomModalSheetDoubleTime());
//     },
//   );
// }
