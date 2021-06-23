import 'package:VosxoD/widget/basketScreen/image_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'dart:math' as math;

class HistoryItems extends StatelessWidget {
  final String? image;
  final String? title;
  final String? personName;
  final String? productNumber;
  final String? price;

  const HistoryItems({
    this.image,
    this.title,
    this.personName,
    this.productNumber,
    this.price,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            vertical: 10,
          ),
          child: ListTile(
            leading: Container(
              padding: EdgeInsets.all(8),
              decoration: new BoxDecoration(
                color: Colors.white10,
                shape: BoxShape.circle,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(31.0),
                child: Text(
                  personName!.toUpperCase().substring(0, 1),
                  style: TextStyle(
                      color:
                          Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                              .withOpacity(1.0),
                      fontSize: 35,
                      fontFamily: 'Sans Serif'),
                ),
              ),
            ),
            title: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text(
                title!,
                textAlign: TextAlign.left,
                style: TextStyle(
                  height: 1,
                  color: Color.fromRGBO(255, 255, 255, 1),
                  fontFamily: 'CeraPro',
                  fontSize: 14,
                  letterSpacing: 0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            subtitle: Text(
              personName!,
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 1),
                fontFamily: 'CeraProLight',
                fontSize: 12,
                letterSpacing: 0,
                fontWeight: FontWeight.normal,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Column(
              children: [
                Text(
                  '  ${productNumber}',
                  style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontFamily: 'CeraPro',
                    fontSize: 16,
                    letterSpacing: 0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(
                  height: 14,
                ),
                Text(
                  '$price',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontFamily: 'CeraProLight',
                    fontSize: 13,
                    letterSpacing: 0,
                    fontWeight: FontWeight.normal,
                  ),
                )
              ],
            ),
          ),
        ),
        Divider(
          color: Color(0xFF747474f),
          height: 2,
          endIndent: 20,
          indent: 20,
        )
      ],
    );
  }
}
