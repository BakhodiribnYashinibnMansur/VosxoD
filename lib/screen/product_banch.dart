import 'dart:convert';

import 'package:VosxoD/const/const.dart';
import 'package:VosxoD/model/home_data_json.dart';
import 'package:VosxoD/provider/home_data_provider.dart';
import 'package:VosxoD/utils/my_prefs.dart';
import 'package:VosxoD/widget/footer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'product_items.dart';

class ProductBanch extends StatefulWidget {
  final String name;
  final int id;
  const ProductBanch(this.name, this.id);
  static const routeName = './productBanch';

  @override
  _ProductBanchState createState() => _ProductBanchState();
}

class _ProductBanchState extends State<ProductBanch> {
  late Future<List<HomeDataJson>> futureCard;
  late List<dynamic> cardList = [];
  Future<List<HomeDataJson>> getApiId() async {
    Map<String, dynamic> mapDataR = {
      "id": widget.id,
    };
    final jsonDataR = JsonEncoder().convert(mapDataR);
    final TOKEN = MyPref.token;
    Uri URL = Uri.parse("https://vosxod.uz/api/parent-categories");
    try {
      final response = await http.post(
        URL,
        headers: {"token": TOKEN},
        body: jsonDataR,
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> map = json.decode(response.body);
        List<dynamic> dataCard = map["category"];
        setState(() {
          cardList = dataCard;
        });
        return dataCard.map((item) => HomeDataJson.fromJson(item)).toList();
      } else {
        Map<String, dynamic> map = json.decode(response.body);
        List<HomeDataJson> dataCard = map["category"];
        return dataCard;
      }
    } catch (error) {
      throw error;
    }
  }

  @override
  void initState() {
    super.initState();
    futureCard = getApiId();
  }

  @override
  Widget build(BuildContext context) {
    final homeData = Provider.of<HomeDataProvider>(
      context,
    );
    homeData.getPageID('1');
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: cBackgroundColor,
        title: Text(widget.name.toUpperCase()),
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        color: cBackgroundColor,
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: FutureBuilder(
                    future: futureCard,
                    builder: (context, snapshot) {
                      if (cardList.length != 0) {
                        return Container(
                          color: cBackgroundColor,
                          child: ListView.builder(
                            itemCount: cardList.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    PageTransition(
                                      type: PageTransitionType.fade,
                                      child: ProductItem(
                                        cardList[index]['name'].toUpperCase(),
                                        cardList[index]['id'],
                                      ),
                                      ctx: context,
                                      alignment: Alignment.center,
                                    ),
                                  );
                                },
                                child: Column(
                                  children: [
                                    ListTile(
                                      leading: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 2.h,
                                          vertical: 1.h,
                                        ),
                                        child: Text(
                                          cardList[index]['name'].toUpperCase(),
                                          style: TextStyle(
                                            color: Color(0xFFC7C7C7),
                                            fontSize: 14.sp,
                                          ),
                                        ),
                                      ),
                                      trailing: Icon(
                                        Icons.navigate_next,
                                        color: Color(0xFFCFCFCF),
                                      ),
                                    ),
                                    Divider(
                                      endIndent: 3.h,
                                      indent: 3.h,
                                      height: 2,
                                      color: Color(0xFF9B9B9B),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Container(
                          color: cBackgroundColor,
                          child: Center(
                            child: Text(
                              "${snapshot.error}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.sp,
                              ),
                            ),
                          ),
                        );
                      }
                      return Container(
                        color: cBackgroundColor,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }),
              ),
            ),
            Spacer(),
            FootBar(),
          ],
        ),
      ),
    );
  }
}
