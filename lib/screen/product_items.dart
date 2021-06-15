import 'dart:convert';
import 'package:VosxoD/provider/home_data_provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:VosxoD/const/const.dart';
import 'package:VosxoD/model/cart_data_json.dart';
import 'package:VosxoD/utils/my_prefs.dart';
import 'package:VosxoD/widget/footer.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'product_one.dart';

class ProductItem extends StatefulWidget {
  final String name;
  final int id;
  const ProductItem(this.name, this.id);
  static const routeName = './productItem';

  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  late Future<List<CartDataJson>> futureItem;
  late List<dynamic> cardItem = [];
  Future<List<CartDataJson>> getApiItemId() async {
    Map<String, dynamic> mapDataR = {
      "id": widget.id,
    };
    final jsonDataR = JsonEncoder().convert(mapDataR);
    final TOKEN = MyPref.token;
    Uri URL = Uri.parse("https://vosxod.uz/api/child-categories");
    try {
      final response = await http.post(
        URL,
        headers: {"token": TOKEN},
        body: jsonDataR,
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> map = json.decode(response.body);
        List<dynamic> dataItem = map["categories"];
        setState(() {
          cardItem = dataItem;
        });
        return dataItem.map((item) => CartDataJson.fromJson(item)).toList();
      } else {
        Map<String, dynamic> map = json.decode(response.body);
        List<CartDataJson> dataItem = map["categories"];
        return dataItem;
      }
    } catch (error) {
      throw error;
    }
  }

  @override
  void initState() {
    super.initState();
    futureItem = getApiItemId();
  }

  @override
  Widget build(BuildContext context) {
    final homeData = Provider.of<HomeDataProvider>(
      context,
    );
    homeData.getPageID('1');
    return Scaffold(
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
            cardItem.length != 0
                ? Expanded(
                    flex: 14,
                    child: Container(
                      color: cBackgroundColor,
                      child: ListView.builder(
                        itemCount: cardItem.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    PageTransition(
                                      type: PageTransitionType.fade,
                                      child: ProductOne(
                                        cardItem[index]['name'],
                                        cardItem[index]['id'],
                                      ),
                                      ctx: context,
                                      alignment: Alignment.center,
                                    ),
                                  );
                                },
                                child: ListTile(
                                  leading: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 1.h,
                                      vertical: .7.h,
                                    ),
                                    child: Text(
                                      cardItem[index]['name'].toUpperCase(),
                                      style: TextStyle(
                                        color: Color(0xFFC7C7C7),
                                        fontSize: 17,
                                      ),
                                    ),
                                  ),
                                  trailing: Icon(
                                    Icons.navigate_next,
                                    color: Color(0xFFCFCFCF),
                                  ),
                                ),
                              ),
                              Divider(
                                endIndent: 3.h,
                                indent: 3.h,
                                height: 2,
                                color: Color(0xFF9B9B9B),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  )
                : Container(
                    color: cBackgroundColor,
                    child: Center(
                      child: CircularProgressIndicator(),
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
