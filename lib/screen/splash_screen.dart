import 'package:VosxoD/model/redux_model.dart';
import 'package:VosxoD/screen/home_screen.dart';
import 'package:VosxoD/screen/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    //set time to load the new page
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          child: HomeScreen(),
          ctx: context,
          alignment: Alignment.topRight,
          duration: Duration(seconds: 2),
        ),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        color: Colors.white,
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 35.h,
              width: 35.h,
              child: Image.asset('asset/logo/logo.png'),
            ),
            SizedBox(height: 7.h),
            Text(
              "VosxoD",
              style: TextStyle(
                fontSize: 30.sp,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0D8A72),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
