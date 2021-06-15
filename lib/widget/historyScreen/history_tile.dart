import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class HistoryListTitle extends StatelessWidget {
  final String? image;
  final String? title;
  final String? personName;
  final String? productNumber;
  final String? price;
  final String? isCheck;
  final String? typeOfCount;
  const HistoryListTitle({
    this.image,
    this.title,
    this.personName,
    this.productNumber,
    this.price,
    this.isCheck,
    this.typeOfCount,
  });
  @override
  Widget build(BuildContext context) {
    print(image);
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            vertical: 0.4.h,
          ),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  vertical: .7.h,
                  horizontal: 2.h,
                ),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(.4.h),
                      child: image!.length != 0
                          ? CircleAvatar(
                              radius: 22.sp,
                              backgroundImage: NetworkImage(
                                image!,
                              ),
                            )
                          : CircleAvatar(
                              radius: 22.sp,
                              backgroundImage: AssetImage(
                                'asset/image/photo.png',
                              ),
                            ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: 70.w,
                            child: Text(
                              title!.toString(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              style: TextStyle(
                                height: 1,
                                color: Color.fromRGBO(255, 255, 255, 1),
                                fontFamily: 'CeraPro',
                                fontSize: 14.sp,
                                letterSpacing: 0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            width: 70.w,
                            padding: EdgeInsets.symmetric(
                              vertical: 1.h,
                              horizontal: 1.0.h,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    productNumber! + '  ' + typeOfCount!,
                                    style: TextStyle(
                                      color: Color.fromRGBO(255, 255, 255, 1),
                                      fontFamily: 'CeraProLight',
                                      fontSize: 12.sp,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    maxLines: 1,
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    '$price' + '  so\'m',
                                    style: TextStyle(
                                      color: Color.fromRGBO(255, 255, 255, 1),
                                      fontFamily: 'CeraProLight',
                                      fontSize: 14.sp,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Divider(
          color: Color(0xFF747474f),
          height: 2,
          endIndent: 3.h,
          indent: 3.h,
        )
      ],
    );
  }
}
