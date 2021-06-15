import 'dart:ui';
import 'package:VosxoD/database/getx_data.dart';
import 'package:VosxoD/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:VosxoD/const/const.dart';
import 'package:VosxoD/provider/home_data_provider.dart';
import 'package:VosxoD/screen/basket_screen.dart';
import 'package:VosxoD/screen/history_screen.dart';
import 'package:VosxoD/screen/home_screen.dart';
import 'package:community_material_icon/community_material_icon.dart';

class FootBar extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    final homeData = Provider.of<HomeDataProvider>(
      context,
    );
    final cartData = Provider.of<CartProviderData>(context, listen: true);
    String pageID = homeData.returnPageID();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Container(
        height: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(46),
            topRight: Radius.circular(46),
            bottomLeft: Radius.circular(46),
            bottomRight: Radius.circular(46),
          ),
          color: Color.fromRGBO(255, 255, 255, 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                homeData.getPageID('1');
                if (homeData.returnPageID() == '1') {
                  Navigator.of(context).push(
                    PageTransition(
                      type: PageTransitionType.fade,
                      child: HomeScreen(),
                      ctx: context,
                      alignment: Alignment.center,
                    ),
                  );
                }
              },
              child: Container(
                height: 35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(46),
                    topRight: Radius.circular(46),
                    bottomLeft: Radius.circular(46),
                    bottomRight: Radius.circular(46),
                  ),
                  color:
                      pageID == '1' ? cHomePageBackgroundColor : Colors.white,
                ),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  children: [
                    Icon(
                      CommunityMaterialIcons.home_outline,
                      color: pageID == '1' ? Colors.white : Colors.black,
                    ),
                    Text(
                      pageID == '1' ? '  Bosh Sahifa' : '         ',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                homeData.getPageID('2');
                if (homeData.returnPageID() == '2') {
                  Navigator.of(context).push(
                    PageTransition(
                      type: PageTransitionType.fade,
                      child: BasketScreen(),
                      ctx: context,
                      alignment: Alignment.center,
                    ),
                  );
                }
              },
              child: Container(
                height: 35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(46),
                    topRight: Radius.circular(46),
                    bottomLeft: Radius.circular(46),
                    bottomRight: Radius.circular(46),
                  ),
                  color:
                      pageID == '2' ? cHomePageBackgroundColor : Colors.white,
                ),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  children: [
                    Icon(
                      CommunityMaterialIcons.cart_outline,
                      color: pageID == '2' ? Colors.white : Colors.black,
                    ),
                    Text(
                      pageID == '2' ? '  Xaridlar  ' : ' ',
                      style: TextStyle(color: Colors.white),
                    ),
                    CircleAvatar(
                      radius: 10,
                      child: Text(cartData.itemCount.toString()),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                homeData.getPageID('3');
                if (homeData.returnPageID() == '3') {
                  Navigator.of(context).push(
                    PageTransition(
                      type: PageTransitionType.fade,
                      child: HistoryScreen(),
                      ctx: context,
                      alignment: Alignment.center,
                    ),
                  );
                }
              },
              child: Container(
                height: 35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(46),
                    topRight: Radius.circular(46),
                    bottomLeft: Radius.circular(46),
                    bottomRight: Radius.circular(46),
                  ),
                  color:
                      pageID == '3' ? cHomePageBackgroundColor : Colors.white,
                ),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  children: [
                    Icon(
                      Icons.history_rounded,
                      color: pageID == '3' ? Colors.white : Colors.black,
                    ),
                    Text(
                      pageID == '3' ? '     Tarix        ' : '         ',
                      style: TextStyle(color: Colors.white),
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
