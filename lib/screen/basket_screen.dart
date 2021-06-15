import 'dart:convert';

import 'package:VosxoD/utils/my_prefs.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:VosxoD/const/const.dart';
import 'package:VosxoD/provider/cart_provider.dart';
import 'package:VosxoD/provider/home_data_provider.dart';
import 'package:VosxoD/screen/payment_type_screen.dart';
import 'package:VosxoD/widget/footer.dart';
import 'package:VosxoD/widget/homeScreen/home_screen_navbar.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

class BasketScreen extends StatefulWidget {
  @override
  _BasketScreenState createState() => _BasketScreenState();
}

class _BasketScreenState extends State<BasketScreen> {
  late Future<void> futureStock;
  late int countArray = 0;
  late int? stockId = 0;
  late List<dynamic> stock = [];
  late int? percentage = 0;
  late int? num = 0;

  Future<void> getStockAPI() async {
    final TOKEN = MyPref.token;
    Uri URL = Uri.parse("https://vosxod.uz/api/stock");
    try {
      final response = await http.get(
        URL,
        headers: {"token": TOKEN},
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> map = json.decode(response.body);
        List<dynamic> dataCard = map["stock_elements"];
        stock = dataCard;
      }
    } catch (error) {
      throw error;
    }
  }

  analyzeStock() {
    for (var item in stock) {
      if (item['start_sum']! <= num! && num! <= item['end_sum']!) {
        setState(() {
          percentage = item['percent'];
          stockId = item['id'];
        });
      }
    }
  }

  var controllerArray = [];
  var itemCount;
  @override
  void initState() {
    final homeData = context.read<HomeDataProvider>();
    final cart = context.read<CartProviderData>();
    var normalPrice = cart.totalAmount;
    setState(() {
      itemCount = cart.itemCount;
      num = normalPrice.toInt();
    });
    controllerFunction();
    for (int i = 0; i < itemCount; i++) {
      controllerArray[i].text = cart.items.values.toList()[i].isCount == '1'
          ? cart.items.values.toList()[i].quantity!.toInt().toString()
          : cart.items.values.toList()[i].quantity!.toString();
    }
    super.initState();
    futureStock = getStockAPI();
    homeData.getPageID('2');
  }

  controllerFunction() {
    for (int i = 0; i < itemCount; i++) {
      controllerArray.add(new TextEditingController());
      TextEditingController controller = controllerArray[i];
    }
  }

  // bool? check = false;
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProviderData>(context, listen: true);
    final homeData = Provider.of<HomeDataProvider>(context, listen: true);
    var normalPrice = cart.totalAmount;
    var formatPrice = NumberFormat.currency(
      name: ' ',
    ).format(normalPrice);
    var checkedPrice = NumberFormat.currency(
      name: ' ',
    ).format(normalPrice * (1 - percentage! / 100));
    countArray = cart.itemCount;
    setState(() {
      num = normalPrice.toInt();
    });
    homeData.getPageID('2');

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          color: cHomePageBackgroundColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeScreenNavbar(),
              Padding(
                padding: EdgeInsets.only(
                  top: 1.h,
                  bottom: .7.h,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Tanlangan mahsulotlar',
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
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: .7.h,
                        vertical: .7.h,
                      ),
                      width: 30.w,
                      height: 4.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(27),
                          topRight: Radius.circular(27),
                          bottomLeft: Radius.circular(27),
                          bottomRight: Radius.circular(27),
                        ),
                        color: Color.fromRGBO(255, 255, 255, 1),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          if (cart.itemCount != 0) {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CupertinoAlertDialog(
                                    title: Text('O\'chirish'.toUpperCase(),
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                        )),
                                    content: Text(
                                        'Savatchadagi malumotlarni o\'chirish'),
                                    actions: <Widget>[
                                      CupertinoDialogAction(
                                        child: Text('Orqaga',
                                            style: TextStyle(
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold,
                                            )),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      CupertinoDialogAction(
                                        child: Text('O\'chirish',
                                            style: TextStyle(
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold,
                                            )),
                                        onPressed: () {
                                          cart.clearCart();
                                          setState(() {
                                            homeData.getCheck(false);
                                          });
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                });
                          }
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.delete_outlined,
                              color: Color.fromRGBO(246, 113, 98, 1),
                              size: 15.sp,
                            ),
                            Text(
                              'O’chirish',
                              style: TextStyle(
                                color: Color.fromRGBO(246, 113, 98, 1),
                                fontFamily: 'CeraPro',
                                fontSize: 12.sp,
                                letterSpacing: 0,
                                fontWeight: FontWeight.normal,
                                height: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 14,
                child: cart.itemCount != 0
                    ? ListView.builder(
                        itemCount: cart.itemCount,
                        itemBuilder: (context, index) {
                          return Slidable(
                            actionPane: SlidableDrawerActionPane(),
                            actionExtentRatio: 0.25,
                            secondaryActions: <Widget>[
                              IconSlideAction(
                                caption: 'O\'chirish',
                                color: Colors.blue[700],
                                icon: CommunityMaterialIcons.delete,
                                onTap: () {
                                  setState(() {
                                    cart.removeItem(
                                      cart.items.values
                                          .toList()[index]
                                          .id!
                                          .toString(),
                                    );
                                  });
                                },
                              ),
                            ],
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: .5.h,
                                horizontal: 1.h,
                              ),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: .5.h,
                                  horizontal: 1.h,
                                ),
                                margin: EdgeInsets.only(top: 0.7.h),
                                height: 15.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(3.h),
                                    topRight: Radius.circular(3.h),
                                    bottomLeft: Radius.circular(3.h),
                                    bottomRight: Radius.circular(3.h),
                                  ),
                                  color: Colors.white,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 2.5.h,
                                        vertical: .7.h,
                                      ),
                                      width: 9.h,
                                      height: 9.h,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            cart.items.values
                                                .toList()[index]
                                                .image!,
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 47.w,
                                          padding: EdgeInsets.symmetric(
                                            vertical: .7.h,
                                            horizontal: 1.h,
                                          ),
                                          child: Text(
                                            cart.items.values
                                                .toList()[index]
                                                .title!,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color:
                                                  Color.fromRGBO(88, 88, 88, 1),
                                              fontFamily: 'CeraProLight',
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 1.h,
                                            vertical: 2,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Narxi: ',
                                                style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      88, 88, 88, 1),
                                                  fontFamily: 'CeraProLight',
                                                  fontSize: 10.sp,
                                                  letterSpacing: 0,
                                                  fontWeight: FontWeight.w400,
                                                  height: 1.5,
                                                ),
                                              ),
                                              Text(
                                                NumberFormat.currency(
                                                      name: ' ',
                                                    )
                                                        .format(double.parse(
                                                            cart.items.values
                                                                .toList()[index]
                                                                .price!))
                                                        .substring(
                                                            0,
                                                            NumberFormat
                                                                        .currency(
                                                                  name: ' ',
                                                                )
                                                                    .format(double.parse(cart
                                                                        .items
                                                                        .values
                                                                        .toList()[
                                                                            index]
                                                                        .price!))
                                                                    .length -
                                                                3) +
                                                    '  so\'m',
                                                style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      88, 88, 88, 1),
                                                  fontFamily: 'CeraPro',
                                                  fontSize: 12.sp,
                                                  letterSpacing: 0,
                                                  fontWeight: FontWeight.w700,
                                                  height: 1.5,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: .7.h,
                                            vertical: 1.h,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Zaxirada: ',
                                                style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      88, 88, 88, 1),
                                                  fontFamily: 'CeraProLight',
                                                  fontSize: 12.sp,
                                                  letterSpacing: 0,
                                                  fontWeight: FontWeight.w200,
                                                ),
                                              ),
                                              Text(
                                                cart.items.values
                                                            .toList()[index]
                                                            .isCount ==
                                                        '1'
                                                    ? '${cart.items.values.toList()[index].count}'
                                                            .substring(
                                                                0,
                                                                cart.items
                                                                        .values
                                                                        .toList()[
                                                                            index]
                                                                        .count!
                                                                        .toString()
                                                                        .length -
                                                                    2) +
                                                        '  ' +
                                                        cart.items.values
                                                            .toList()[index]
                                                            .typeOfCount!
                                                    : '${cart.items.values.toList()[index].count}' +
                                                        '  ' +
                                                        cart.items.values
                                                            .toList()[index]
                                                            .typeOfCount!,
                                                style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      88, 88, 88, 1),
                                                  fontFamily: 'CeraPro',
                                                  fontSize: 12.sp,
                                                  letterSpacing: 0,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    cart.items.values.toList()[index].isCount !=
                                            '1'
                                        ? Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: .5.h,
                                                vertical: 3.h),
                                            child: Center(
                                              child: Container(
                                                width: 20.w,
                                                height: 20.h,
                                                child: TextField(
                                                  inputFormatters: [
                                                    LengthLimitingTextInputFormatter(
                                                      7,
                                                    ),
                                                    // FilteringTextInputFormatter
                                                    //     .allow(RegExp('[0-9]'))
                                                  ],
                                                  controller:
                                                      controllerArray[index],
                                                  onChanged: (text) {
                                                    controllerArray[index]
                                                        .addListener(() {
                                                      cart.updateValue(
                                                        cart.items.values
                                                            .toList()[index]
                                                            .id
                                                            .toString(),
                                                        controllerArray[index]
                                                                    .text
                                                                    .length ==
                                                                0
                                                            ? '0.0'
                                                            : controllerArray[
                                                                    index]
                                                                .text,
                                                      );
                                                      if (cart.items.values
                                                              .toList()[index]
                                                              .count! <
                                                          cart.items.values
                                                              .toList()[index]
                                                              .quantity!) {
                                                        cart.updateValue(
                                                            cart.items.values
                                                                .toList()[index]
                                                                .id!,
                                                            cart.items.values
                                                                .toList()[index]
                                                                .count
                                                                .toString());
                                                        setState(() {
                                                          controllerArray[index]
                                                                  .text =
                                                              '${cart.items.values.toList()[index].count}';
                                                        });
                                                      }
                                                      analyzeStock();
                                                    });
                                                  },
                                                  style: TextStyle(
                                                      fontSize: 10.sp),
                                                  keyboardType:
                                                      TextInputType.number,
                                                  decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(12),
                                                        topRight:
                                                            Radius.circular(12),
                                                        bottomLeft:
                                                            Radius.circular(12),
                                                        bottomRight:
                                                            Radius.circular(12),
                                                      ),
                                                    ),
                                                    labelText: cart.items.values
                                                        .toList()[index]
                                                        .typeOfCount,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        : Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: .5.h,
                                                vertical: 3.h),
                                            child: Center(
                                              child: Container(
                                                width: 20.w,
                                                height: 20.h,
                                                child: TextField(
                                                  inputFormatters: [
                                                    LengthLimitingTextInputFormatter(
                                                      7,
                                                    ),
                                                    FilteringTextInputFormatter
                                                        .allow(RegExp('[0-9]')),
                                                  ],
                                                  controller:
                                                      controllerArray[index],
                                                  onChanged: (text) {
                                                    controllerArray[index]
                                                        .addListener(() {
                                                      cart.updateValue(
                                                        cart.items.values
                                                            .toList()[index]
                                                            .id
                                                            .toString(),
                                                        controllerArray[index]
                                                                    .text
                                                                    .length ==
                                                                0
                                                            ? '0.0'
                                                            : controllerArray[
                                                                    index]
                                                                .text,
                                                      );
                                                      if (cart.items.values
                                                              .toList()[index]
                                                              .count! <
                                                          cart.items.values
                                                              .toList()[index]
                                                              .quantity!) {
                                                        cart.updateValue(
                                                            cart.items.values
                                                                .toList()[index]
                                                                .id!,
                                                            cart.items.values
                                                                .toList()[index]
                                                                .count
                                                                .toString());
                                                        setState(() {
                                                          controllerArray[index]
                                                                  .text =
                                                              '${cart.items.values.toList()[index].count!.toInt()}';
                                                        });
                                                      }
                                                      analyzeStock();
                                                    });
                                                  },
                                                  style: TextStyle(
                                                      fontSize: 10.sp),
                                                  keyboardType:
                                                      TextInputType.number,
                                                  decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(12),
                                                        topRight:
                                                            Radius.circular(12),
                                                        bottomLeft:
                                                            Radius.circular(12),
                                                        bottomRight:
                                                            Radius.circular(12),
                                                      ),
                                                    ),
                                                    labelText: cart.items.values
                                                        .toList()[index]
                                                        .typeOfCount,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    : Center(
                        child: Text(
                          'Savatcha bo\'sh',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.sp,
                          ),
                        ),
                      ),
              ),
              Spacer(),
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: .4.h,
                  horizontal: 1.h,
                ),
                padding: EdgeInsets.symmetric(
                  vertical: .4.h,
                  horizontal: 1.h,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  color: Color.fromRGBO(248, 248, 249, 1),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: .3.h,
                        horizontal: 2.h,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Umymiy narx : ',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Color.fromRGBO(0, 193, 112, 1),
                              fontFamily: 'CeraPro',
                              fontSize: 15.sp,
                              fontWeight: FontWeight.normal,
                              height: 1,
                            ),
                          ),
                          Text(
                            formatPrice.toString().substring(
                                0, formatPrice.toString().length - 3),
                            style: TextStyle(
                              color: homeData.returnCheck() == true
                                  ? Colors.red
                                  : Color.fromRGBO(0, 193, 112, 1),
                              decoration: homeData.returnCheck() == true
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              activeColor: Color.fromRGBO(0, 193, 112, 1),
                              value: homeData.returnCheck(),
                              onChanged: (bool? value) {
                                if (cart.itemCount != 0) {
                                  setState(() {
                                    homeData.getCheck(value!);
                                  });
                                  analyzeStock();
                                } else {
                                  setState(() {
                                    homeData.getCheck(false);
                                  });
                                }
                              },
                            ),
                            Text(
                              'Chegirma',
                              style: TextStyle(
                                color: Color.fromRGBO(0, 193, 112, 1),
                                fontFamily: 'CeraPro',
                                fontSize: 15.sp,
                                letterSpacing: 0,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 1.h,
                          ),
                          child: homeData.returnCheck() == true
                              ? Text(
                                  checkedPrice.toString().substring(0,
                                          formatPrice.toString().length - 3) +
                                      '  -($percentage)' +
                                      '%',
                                  style: TextStyle(
                                    color: Color.fromRGBO(0, 193, 112, 1),
                                    fontFamily: 'CeraPro',
                                    fontSize: 12.sp,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.normal,
                                    height: 1,
                                  ),
                                )
                              : Text(''),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (cart.itemCount != 0) {
                    Navigator.of(context).push(
                      PageTransition(
                        type: PageTransitionType.fade,
                        child: PaymentTypeScreen(
                          amount: homeData.returnCheck() == true
                              ? cart.totalAmount * (1 - percentage! / 100)
                              : cart.totalAmount,
                          stockId: stockId,
                        ),
                        ctx: context,
                        alignment: Alignment.center,
                      ),
                    );
                  }
                },
                child: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 1.h,
                    vertical: .4.h,
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 1.5.h,
                    horizontal: 1.h,
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
                      'To\'lov',
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
}
