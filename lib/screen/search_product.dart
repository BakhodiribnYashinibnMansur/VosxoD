import 'dart:convert';

import 'package:VosxoD/const/const.dart';
import 'package:VosxoD/provider/cart_provider.dart';
import 'package:VosxoD/provider/home_data_provider.dart';
import 'package:VosxoD/utils/my_prefs.dart';
import 'package:VosxoD/widget/footer.dart';
import 'package:VosxoD/widget/historyScreen/history_tile.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
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
                      lengthOfArray: productOne.length,
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
  const ProductCart({required this.products, required this.lengthOfArray});
  final List<dynamic>? products;
  final int lengthOfArray;
  @override
  _ProductCartState createState() => _ProductCartState();
}

class _ProductCartState extends State<ProductCart> {
  var controllerArray = [];
  @override
  void initState() {
    super.initState();
    controllerFunction();
    // final cart = context.read<CartProviderData>();
  }

  controllerFunction() {
    for (int i = 0; i < widget.lengthOfArray; i++) {
      controllerArray.add(new TextEditingController());
      TextEditingController controller = controllerArray[i];
    }
  }

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
                          IconSlideAction(
                            caption: 'Teskor qo\'shish',
                            color: Colors.blueAccent,
                            icon: CommunityMaterialIcons.basket_plus,
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
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Dialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(35),
                                    ),
                                    elevation: 0,
                                    backgroundColor: Colors.white,
                                    child: Container(
                                      width: double.infinity,
                                      height: 36.h,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 4.h, vertical: 3.h),
                                      child: Column(
                                        children: [
                                          Text(
                                            widget.products![index]['name_uz']!,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Text('Zaxirada: '),
                                                Text(widget.products![index][
                                                            'product_type_check'] ==
                                                        1
                                                    ? widget.products![index]['warning_count']
                                                            .toString() +
                                                        "  " +
                                                        widget.products![index][
                                                                'product_type']!
                                                            .toString()
                                                    : widget.products![index][
                                                                'warning_count']
                                                            .toString() +
                                                        "  " +
                                                        widget.products![index]
                                                                ['product_type']!
                                                            .toString()),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Text('Narxi: '),
                                                Text(
                                                  widget.products![index]
                                                              ['price']!
                                                          .toString() +
                                                      ' sum',
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(left: 7.w),
                                            child: widget.products![index][
                                                            'product_type_check']!
                                                        .toString() !=
                                                    '1'
                                                ? Container(
                                                    width: 70.w,
                                                    height: 10.h,
                                                    child: TextField(
                                                      inputFormatters: [
                                                        LengthLimitingTextInputFormatter(
                                                          7,
                                                        ),
                                                      ],
                                                      controller:
                                                          controllerArray[
                                                              index],
                                                      onChanged: (text) {
                                                        controllerArray[index]
                                                            .addListener(() {
                                                          if (widget.products![
                                                                      index][
                                                                  'warning_count']! <
                                                              double.parse(
                                                                  controllerArray[
                                                                          index]
                                                                      .text!)) {
                                                            setState(() {
                                                              controllerArray[
                                                                          index]
                                                                      .text =
                                                                  '${widget.products![index]['warning_count']!.toString()}';
                                                            });
                                                          }
                                                        });
                                                      },
                                                      style: TextStyle(
                                                          fontSize: 10.sp),
                                                      keyboardType:
                                                          TextInputType.number,
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    12),
                                                            topRight:
                                                                Radius.circular(
                                                                    12),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    12),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    12),
                                                          ),
                                                        ),
                                                        labelText: widget
                                                            .products![index][
                                                                'product_type']!
                                                            .toString()
                                                            .toString(),
                                                      ),
                                                    ),
                                                  )
                                                : Container(
                                                    width: 70.w,
                                                    height: 10.h,
                                                    child: TextField(
                                                      inputFormatters: [
                                                        LengthLimitingTextInputFormatter(
                                                          7,
                                                        ),
                                                        FilteringTextInputFormatter
                                                            .allow(RegExp(
                                                                '[0-9]')),
                                                      ],
                                                      controller:
                                                          controllerArray[
                                                              index],
                                                      onChanged: (text) {
                                                        controllerArray[index]
                                                            .addListener(() {
                                                          if (widget.products![
                                                                      index][
                                                                  'warning_count']! <
                                                              double.parse(
                                                                  controllerArray[
                                                                          index]
                                                                      .text!)) {
                                                            setState(() {
                                                              controllerArray[
                                                                          index]
                                                                      .text =
                                                                  '${widget.products![index]['warning_count']!.toInt()}';
                                                            });
                                                          }
                                                        });
                                                      },
                                                      style: TextStyle(
                                                          fontSize: 10.sp),
                                                      keyboardType:
                                                          TextInputType.number,
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    12),
                                                            topRight:
                                                                Radius.circular(
                                                                    12),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    12),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    12),
                                                          ),
                                                        ),
                                                        labelText: widget
                                                            .products![index][
                                                                'product_type']!
                                                            .toString(),
                                                      ),
                                                    ),
                                                  ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              RaisedButton(
                                                onPressed: () {
                                                  cart.updateValue(
                                                      widget.products![index]
                                                              ['id']!
                                                          .toString(),
                                                      controllerArray[index]
                                                          .text
                                                          .toString());
                                                  setState(() {
                                                    widget.products!
                                                        .removeAt(index);
                                                  });
                                                  Navigator.of(context)
                                                      .pop(context);
                                                },
                                                color: Colors.greenAccent,
                                                child: Text('Saqlash'),
                                              ),
                                              RaisedButton(
                                                onPressed: () {
                                                  cart.removeItem(widget
                                                      .products![index]['id']!
                                                      .toString());
                                                  controllerArray[index]
                                                      .clear();
                                                  Navigator.of(context)
                                                      .pop(context);
                                                },
                                                color: Colors.redAccent,
                                                child: Text('Bekor qilish'),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ],
                        child: HistoryListTitle(
                            image: widget.products![index]['image'],
                            title: widget.products![index]['name_uz'],
                            personName: widget.products![index]['description'],
                            productNumber: widget.products![index]
                                    ['warning_count']
                                .toDouble(),
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
                            widget.products![index]['warning_count'].toDouble(),
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
