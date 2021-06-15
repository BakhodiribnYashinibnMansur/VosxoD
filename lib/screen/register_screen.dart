import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:VosxoD/const/const.dart';
import 'package:http/http.dart' as http;
import 'package:VosxoD/screen/home_screen.dart';
import 'package:VosxoD/utils/my_prefs.dart';
import 'package:VosxoD/widget/registerScreen/label_and_textField.dart';
import 'package:VosxoD/widget/registerScreen/register_screen_navbar.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  _valEmailFunctions(val) {
    // return val.isEmpty || !val.contains("@.") ? "enter a valid email" : null;
  }

  _valParolFunctions(val) {
    // return val.isEmpty ? "enter a valid parol" : null;
  }
  bool isLoading = false;
  final url = Uri.parse("https://vosxod.uz/api/login");

  signIn(email, password, context) async {
    Map<String, dynamic> mapDataR = {
      "login": email,
      "parol": password,
    };
    final jsonDataR = JsonEncoder().convert(mapDataR);
    var response = await http.post(url, body: jsonDataR);
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      MyPref.token = jsonResponse['user']['token'];
      AccountImage.image = jsonResponse['user']['image'];
      PassCode.passcode = jsonResponse['user']['parol'].toString();
      Navigator.of(context).pushReplacement(
        PageTransition(
          type: PageTransitionType.fade,
          child: HomeScreen(),
          ctx: context,
          alignment: Alignment.center,
        ),
      );
      setState(
        () {
          isLoading = false;
        },
      );
    } else {
      showError();
      setState(
        () {
          isLoading = false;
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: isLoading
            ? Container(
                color: cBackgroundColor,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Container(
                color: cBackgroundColor,
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 7.h,
                      child: RegisterScreenNavbar(),
                    ),
                    Spacer(),
                    Center(
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(0),
                          ),
                          color: Color.fromRGBO(247, 247, 249, 1),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 15,
                                left: 25,
                              ),
                              child: Text(
                                'Kirish',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                  fontFamily: 'CeraPro',
                                  fontSize: 22.sp,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.normal,
                                  height: 1,
                                ),
                              ),
                            ),
                            Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  LabelTextAndTextField(
                                    labelText: 'Login',
                                    hintText: 'Login',
                                    controller: emailController,
                                    icon: Icon(Icons.account_circle_rounded),
                                    valEmail: _valEmailFunctions,
                                  ),
                                  LabelTextAndTextField(
                                    labelText: 'Parol',
                                    hintText: 'parol',
                                    controller: passwordController,
                                    icon: Icon(Icons.security_outlined),
                                    valEmail: _valParolFunctions,
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                signIn(
                                  emailController.text.toString(),
                                  passwordController.text.toString(),
                                  context,
                                );
                                setState(() {
                                  isLoading = true;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 30,
                                ),
                                child: Container(
                                  height: 7.h,
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
                                      'Kirish',
                                      style: TextStyle(
                                        color: Color.fromRGBO(255, 255, 255, 1),
                                        fontFamily: 'CeraPro',
                                        fontSize: 20.sp,
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.normal,
                                        height: 1,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  showError() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Text(
              "Kirishdagi Xatolik",
              style: TextStyle(
                color: Colors.red,
                fontSize: 17.sp,
              ),
            ),
          ),
          content: Padding(
            padding: const EdgeInsets.all(4.0),
            child: new Text(
                "Login yoki parolda xatolik mavjud.Iltimos qayta urinib ko'ring."),
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text("ok"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
