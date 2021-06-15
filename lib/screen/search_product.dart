import 'dart:convert';
import 'package:VosxoD/main.dart';
import 'package:VosxoD/model/redux_model.dart';
import 'package:VosxoD/provider/home_data_provider.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:VosxoD/const/const.dart';
import 'package:VosxoD/model/cart_data_json.dart';
import 'package:VosxoD/provider/cart_provider.dart';
import 'package:VosxoD/utils/my_prefs.dart';
import 'package:VosxoD/widget/footer.dart';
import 'package:VosxoD/widget/historyScreen/history_tile.dart';
import 'package:sizer/sizer.dart';

class SearchProducts extends StatefulWidget {
  static const routeName = './productItem';
  @override
  _SearchProductsState createState() => _SearchProductsState();
}

class _SearchProductsState extends State<SearchProducts> {
  late Future<void> searchApiFuture;
  List<dynamic> productOne = [];
  late String searchText = '';
  bool opacity = false;
  Future<void> searchApi() async {
    Map<String, dynamic> mapDataR = {"name": searchText};
    final jsonDataR = JsonEncoder().convert(mapDataR);
    final TOKEN = MyPref.token;
    Uri URL = Uri.parse("https://vosxod.uz/api/search-products");
    try {
      final responses = await http.post(
        URL,
        headers: {"token": TOKEN},
        body: jsonDataR,
      );
      if (responses.statusCode == 200) {
        Map<String, dynamic> map = json.decode(responses.body);
        List<dynamic> dataItem = map["products"];
        setState(() {
          productOne.clear();
          productOne = dataItem;
          opacity = true;
        });
      }
    } catch (error) {
      throw error;
    }
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
          title: Text(
            'Maxsulotalarni qidirish'.toUpperCase(),
          ),
          elevation: 0,
        ),
        body: Container(
          color: cBackgroundColor,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 1.h,
                  horizontal: 2.h,
                ),
                child: TextFormField(
                    autofocus: true,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                        borderSide: BorderSide(
                          color: Color(0xFFB3B3B3),
                        ),
                      ),
                      suffixIcon: Icon(
                        Icons.search,
                        color: Color(0xFFACACAC),
                      ),
                      hintText: 'Maxsulotlarni qidirish',
                      hintStyle: TextStyle(
                        color: Color(0xFFC2C2C2),
                      ),
                    ),
                    onChanged: (text) {
                      setState(() {
                        searchText = text;
                      });
                      if (text != '') {
                        searchApiFuture = searchApi();
                      }
                      if (searchText == '') {
                        opacity = false;
                        setState(() {
                          productOne.clear();
                        });
                      }
                    }),
              ),
              productOne.length != 0 && searchText.length != 0
                  ? ProductCart(
                      products: productOne,
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: cBackgroundColor,
                        child: Center(
                          child: Text(
                            opacity == true ? 'Maxsulot topilmadi' : '',
                            style: TextStyle(
                              color: Color(0xFFFBFBFB),
                              fontSize: 15.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ));
  }
}

class ProductCart extends StatefulWidget {
  const ProductCart({
    required this.products,
  });
  final List<dynamic>? products;
  @override
  _ProductCartState createState() => _ProductCartState();
}

class _ProductCartState extends State<ProductCart> {
  @override
  Widget build(BuildContext context) {
    final homeData = Provider.of<HomeDataProvider>(
      context,
    );
    homeData.getPageID('1');
    final cart = Provider.of<CartProviderData>(context);
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 12,
            child: ListView.builder(
              itemCount: widget.products!.length,
              itemBuilder: (context, index) {
                return widget.products![index]['warning_count'] != 0
                    ? Slidable(
                        actionPane: SlidableDrawerActionPane(),
                        actionExtentRatio: 0.25,
                        secondaryActions: <Widget>[
                          IconSlideAction(
                            caption: 'Savatchaga',
                            color: Colors.blue[700],
                            icon: CommunityMaterialIcons.basket,
                            onTap: () {
                              cart.addItems(
                                widget.products![index]['id'].toString(),
                                widget.products![index]['price'].toString(),
                                widget.products![index]['name_uz'].toString(),
                                widget.products![index]['image'].toString(),
                                widget.products![index]['warning_count']
                                    .toString(),
                                widget.products![index]['id'].toString(),
                                widget.products![index]['product_type_check']
                                    .toString(),
                                widget.products![index]['product_type']
                                    .toString(),
                              );
                              setState(() {
                                widget.products!.removeAt(index);
                              });
                            },
                          ),
                        ],
                        child: HistoryListTitle(
                            image: widget.products![index]['image'],
                            title: widget.products![index]['name_uz'],
                            personName: widget.products![index]['description'],
                            productNumber: widget.products![index]
                                    ['warning_count']
                                .toString(),
                            price: widget.products![index]['price'].toString(),
                            isCheck: widget.products![index]
                                    ['product_type_check']
                                .toString(),
                            typeOfCount: widget.products![index]
                                ['product_type']),
                      )
                    : HistoryListTitle(
                        image: widget.products![index]['image'],
                        title: widget.products![index]['name_uz'],
                        personName:
                            widget.products![index]['warning_count'].toString(),
                        productNumber:
                            widget.products![index]['warning_count'].toString(),
                        price: widget.products![index]['price'].toString(),
                        isCheck: widget.products![index]['product_type_check']
                            .toString(),
                        typeOfCount: widget.products![index]['product_type']);
              },
            ),
          ),
          Spacer(),
          FootBar(),
        ],
      ),
    );
  }
}
