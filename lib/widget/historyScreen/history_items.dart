import 'package:VosxoD/widget/basketScreen/image_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

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
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(31.0),
              child: Image.asset(
                image!,
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
