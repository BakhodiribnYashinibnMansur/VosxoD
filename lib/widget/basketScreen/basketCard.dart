import 'dart:async';

import 'package:VosxoD/database/getx_data.dart';
import 'package:VosxoD/provider/home_data_provider.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:VosxoD/provider/cart_provider.dart';
import 'package:sizer/sizer.dart';

class BasketCard extends StatefulWidget {
  final String? image;
  final String? title;
  final String? price;
  final double? quantity;
  final String? productId;
  final double? count;
  final String? isCount;
  const BasketCard({
    this.image,
    this.title,
    this.price,
    this.quantity,
    this.productId,
    this.count,
    this.isCount,
  });

  @override
  _BasketCardState createState() => _BasketCardState();
}

TextEditingController controller = TextEditingController();
@override
late final bool maxValue;

class _BasketCardState extends State<BasketCard> {
  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<CartProviderData>(context, listen: true);
    final homeData = Provider.of<HomeDataProvider>(context, listen: true);
    final formatPrice = NumberFormat.currency(
      name: ' ',
    ).format(int.parse(widget.price!));
    return Padding(
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
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
                image: DecorationImage(
                  image: AssetImage('asset/image/photo.png'),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 47.w,
                  padding: EdgeInsets.symmetric(
                    vertical: .7.h,
                    horizontal: 1.h,
                  ),
                  child: Text(
                    widget.title!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Color.fromRGBO(88, 88, 88, 1),
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Narxi: ',
                        style: TextStyle(
                          color: Color.fromRGBO(88, 88, 88, 1),
                          fontFamily: 'CeraProLight',
                          fontSize: 10.sp,
                          letterSpacing: 0,
                          fontWeight: FontWeight.w400,
                          height: 1.5,
                        ),
                      ),
                      Text(
                        formatPrice.toString().substring(
                                0, formatPrice.toString().length - 3) +
                            '  so\'m',
                        style: TextStyle(
                          color: Color.fromRGBO(88, 88, 88, 1),
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Zaxirada: ',
                        style: TextStyle(
                          color: Color.fromRGBO(88, 88, 88, 1),
                          fontFamily: 'CeraProLight',
                          fontSize: 12.sp,
                          letterSpacing: 0,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                      Text(
                        widget.isCount == '1'
                            ? '${widget.count}'.substring(
                                    0, widget.count!.toString().length - 2) +
                                ' ta'
                            : '${widget.count}' + '  kg',
                        style: TextStyle(
                          color: Color.fromRGBO(88, 88, 88, 1),
                          fontFamily: 'CeraPro',
                          fontSize: 10.sp,
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
            widget.isCount != '1'
                ? Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 1.h,
                    ),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            cartData.increaseKG(widget.productId!);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: Color(0xFF1FBB00),
                                style: BorderStyle.solid,
                                width: 1.0,
                              ),
                            ),
                            padding: EdgeInsets.all(2),
                            child: Icon(
                              CommunityMaterialIcons.plus,
                              color: Color(0xFF1BA500),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Text(
                            widget.isCount == '1'
                                ? '${widget.quantity}'.substring(
                                        0,
                                        widget.quantity!.toString().length -
                                            2) +
                                    ' ta'
                                : '${(widget.quantity!.toStringAsFixed(1))}' +
                                    '  kg',
                            style: TextStyle(
                              color: Color.fromRGBO(88, 88, 88, 1),
                              fontFamily: 'CeraPro',
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            cartData.decreaseKG(widget.productId!);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: Color(0xFFEB0000),
                                style: BorderStyle.solid,
                                width: 1.0,
                              ),
                            ),
                            padding: EdgeInsets.all(2),
                            child: Icon(
                              CommunityMaterialIcons.minus,
                              color: Color(0xFFFF0000),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 1.h,
                    ),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            cartData.increaseCount(widget.productId!);
                            homeData.getCheck(true);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: Color(0xFF1FBB00),
                                style: BorderStyle.solid,
                                width: 1.0,
                              ),
                            ),
                            padding: EdgeInsets.all(2),
                            child: Icon(
                              CommunityMaterialIcons.plus,
                              color: Color(0xFF1BA500),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Text(
                            '${widget.quantity}'.substring(
                                0, widget.quantity!.toString().length - 2),
                            style: TextStyle(
                              color: Color.fromRGBO(88, 88, 88, 1),
                              fontFamily: 'CeraPro',
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            cartData.decreaseCount(widget.productId!);
                            homeData.getCheck(true);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: Color(0xFFEB0000),
                                style: BorderStyle.solid,
                                width: 1.0,
                              ),
                            ),
                            padding: EdgeInsets.all(2),
                            child: Icon(
                              CommunityMaterialIcons.minus,
                              color: Color(0xFFFF0000),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
