import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:VosxoD/screen/register_screen.dart';
import 'package:VosxoD/utils/my_prefs.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';

class HomeScreenNavbar extends StatefulWidget {
  @override
  _HomeScreenNavbarState createState() => _HomeScreenNavbarState();
}

class _HomeScreenNavbarState extends State<HomeScreenNavbar> {
  var image = AccountImage.image;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 2.h,
            vertical: 2.h,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              image.length != 0
                  ? CircleAvatar(
                      radius: 3.h,
                      backgroundImage: NetworkImage(
                        'https://vosxod.uz/uploads/users/$image',
                      ),
                    )
                  : Icon(
                      Icons.account_circle_outlined,
                      color: Colors.white,
                      size: 30.sp,
                    ),
              Text(
                'VOSXOD',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'CeraPro',
                  fontSize: 17.sp,
                  fontWeight: FontWeight.normal,
                  height: 1,
                ),
              ),
              GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CupertinoAlertDialog(
                          title: Text(
                            'Log Out'.toUpperCase(),
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          content: Text('Profildan chiqish'),
                          actions: <Widget>[
                            CupertinoDialogAction(
                              child: Text('Bekor qilish'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            CupertinoDialogAction(
                                child: Icon(CommunityMaterialIcons.logout),
                                onPressed: () {
                                  MyPref.token = '';
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                        builder: (context) => RegisterScreen(),
                                      ),
                                      (Route<dynamic> route) => false);
                                }),
                          ],
                        );
                      });
                },
                child: Icon(
                  Icons.login_rounded,
                  size: 25.sp,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
