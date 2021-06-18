import 'dart:convert';

import 'package:VosxoD/const/const.dart';
import 'package:VosxoD/model/product_model.dart';
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

class ProductOne extends StatefulWidget {
  final String name;
  final int id;
  const ProductOne(this.name, this.id);
  static const routeName = './productItem';

  @override
  _ProductOneState createState() => _ProductOneState();
}

class _ProductOneState extends State<ProductOne> {
  late Future<ProductModel> futureItem;
  late Future<ProductModel> searchApiFuture;
  // late List<dynamic> productOne = [];
  // late List<dynamic> productSearch;
  late String searchText = '';
  Future<ProductModel> getApiOneId() async {
    Map<String, dynamic> mapDataR = {
      "id": widget.id,
    };
    final jsonDataR = JsonEncoder().convert(mapDataR);
    final TOKEN = MyPref.token;
    Uri URL = Uri.parse("https://vosxod.uz/api/category-product");
    try {
      final response = await http.post(
        URL,
        headers: {"token": TOKEN},
        body: jsonDataR,
      );
      if (response.statusCode == 200) {
        final productsModelOne = ProductModel.fromRawJson(response.body);
        return productsModelOne;
        // Map<String, dynamic> map = json.decode(response.body);
        // List<dynamic> dataItem = map["products"];
        // setState(() {
        //   productOne = dataItem;
        // });
        // return dataItem.map((item) => CartItemJson.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load album');
      }
    } catch (error) {
      throw error;
    }
  }

  Future<ProductModel> searchApi() async {
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
        final productsModelSearch = ProductModel.fromRawJson(responses.body);
        return productsModelSearch;
        // Map<String, dynamic> map = json.decode(responses.body);
        // List<dynamic> dataItem = map["products"];
        // setState(() {
        //   productOne.clear();
        //   productOne = dataItem;
        // });
        // return dataItem.map((item) => CartItemJson.fromJson(item)).toList();
      } else {
        throw Exception('Malumotlarni yuklashda omadsizlikkga uchradi .');
      }
    } catch (error) {
      throw error;
    }
  }

  final TextEditingController controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    futureItem = getApiOneId();
    // searchApiFuture = searchApi();
    searchText = "";
    controller.addListener(() {
      setState(() {
        searchText = controller.text;
      });
      if (controller.text != '') {
        searchApiFuture = searchApi();
      }
      if (searchText == '') {
        futureItem = getApiOneId();
      }
    });
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
      body: FutureBuilder(
        future: searchText == '' ? futureItem : searchApiFuture,
        builder: (context, AsyncSnapshot<ProductModel> snapshot) {
          if (snapshot.hasData) {
            return Container(
              color: cBackgroundColor,
              child: Column(
                children: [
                  Expanded(
                    flex: 14,
                    child: Container(
                      color: cBackgroundColor,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 1.h,
                              horizontal: 2.h,
                            ),
                            child: TextFormField(
                              controller: controller,
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
                                hintText: 'maxsulotlarni qidirish',
                                hintStyle: TextStyle(
                                  color: Color(0xFFC2C2C2),
                                ),
                              ),
                            ),
                          ),
                          ProductCart(
                              snapshot.data!, snapshot.data!.products!.length),
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                  FootBar(),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return Container(
            color: cBackgroundColor,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}

class ProductCart extends StatefulWidget {
  const ProductCart(
    this.products,
    this.lengthOfArray,
  );
  final int lengthOfArray;
  final ProductModel products;
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
    final cart = Provider.of<CartProviderData>(context);
    return Expanded(
      child: ListView.builder(
        physics: ScrollPhysics(),
        itemCount: widget.products.products!.length,
        itemBuilder: (context, index) {
          return widget.products.products![index].warningCount != 0
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
                          widget.products.products![index].id.toString(),
                          widget.products.products![index].price.toString(),
                          widget.products.products![index].nameUz.toString(),
                          widget.products.products![index].image.toString(),
                          widget.products.products![index].warningCount
                              .toString(),
                          widget.products.products![index].id.toString(),
                          widget.products.products![index].productTypeCheck
                              .toString(),
                          widget.products.products![index].productType
                              .toString(),
                        );
                        setState(() {
                          widget.products.products!.removeAt(index);
                        });
                      },
                    ),
                    IconSlideAction(
                      caption: 'Teskor qo\'shish',
                      color: Colors.blueAccent,
                      icon: CommunityMaterialIcons.basket_plus,
                      onTap: () {
                        cart.addItems(
                          widget.products.products![index].id.toString(),
                          widget.products.products![index].price.toString(),
                          widget.products.products![index].nameUz.toString(),
                          widget.products.products![index].image.toString(),
                          widget.products.products![index].warningCount
                              .toString(),
                          widget.products.products![index].id.toString(),
                          widget.products.products![index].productTypeCheck
                              .toString(),
                          widget.products.products![index].productType
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
                                      widget.products.products![index].nameUz!,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text('Zaxirada: '),
                                          Text(widget.products.products![index]
                                                      .productTypeCheck! ==
                                                  1
                                              ? widget.products.products![index]
                                                      .warningCount!
                                                      .toInt()
                                                      .toString() +
                                                  "  " +
                                                  widget
                                                      .products
                                                      .products![index]
                                                      .productType!
                                                      .toString()
                                              : widget.products.products![index]
                                                      .warningCount!
                                                      .toString() +
                                                  "  " +
                                                  widget
                                                      .products
                                                      .products![index]
                                                      .productType!
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
                                            widget.products.products![index]
                                                    .price!
                                                    .toString() +
                                                ' sum',
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left: 7.w),
                                      child: widget.products.products![index]
                                                  .productTypeCheck !=
                                              1
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
                                                    controllerArray[index],
                                                onChanged: (text) {
                                                  controllerArray[index]
                                                      .addListener(() {
                                                    if (widget
                                                            .products
                                                            .products![index]
                                                            .warningCount! <
                                                        double.parse(
                                                            controllerArray[
                                                                    index]
                                                                .text!)) {
                                                      setState(() {
                                                        controllerArray[index]
                                                                .text =
                                                            '${widget.products.products![index].warningCount}';
                                                      });
                                                    }
                                                  });
                                                },
                                                style:
                                                    TextStyle(fontSize: 10.sp),
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
                                                  labelText: widget
                                                      .products
                                                      .products![index]
                                                      .productType
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
                                                      .allow(RegExp('[0-9]')),
                                                ],
                                                controller:
                                                    controllerArray[index],
                                                onChanged: (text) {
                                                  controllerArray[index]
                                                      .addListener(() {
                                                    if (widget
                                                            .products
                                                            .products![index]
                                                            .warningCount! <
                                                        double.parse(
                                                            controllerArray[
                                                                    index]
                                                                .text!)) {
                                                      setState(() {
                                                        controllerArray[index]
                                                                .text =
                                                            '${widget.products.products![index].warningCount!.toInt()}';
                                                      });
                                                    }
                                                  });
                                                },
                                                style:
                                                    TextStyle(fontSize: 10.sp),
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
                                                  labelText: widget
                                                      .products
                                                      .products![index]
                                                      .productType
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
                                                widget.products.products![index]
                                                    .id!
                                                    .toString(),
                                                controllerArray[index]
                                                    .text
                                                    .toString());
                                            setState(() {
                                              widget.products.products!
                                                  .removeAt(index);
                                            });
                                            Navigator.of(context).pop(context);
                                          },
                                          color: Colors.greenAccent,
                                          child: Text('Saqlash'),
                                        ),
                                        RaisedButton(
                                          onPressed: () {
                                            cart.removeItem(widget
                                                .products.products![index].id
                                                .toString());
                                            controllerArray[index].clear();
                                            Navigator.of(context).pop(context);
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
                    image: widget.products.products![index].image,
                    title: widget.products.products![index].nameUz,
                    personName: widget.products.products![index].description,
                    productNumber:
                        widget.products.products![index].warningCount!,
                    price: widget.products.products![index].price.toString(),
                    isCheck: widget.products.products![index].productTypeCheck
                        .toString(),
                    typeOfCount:
                        widget.products.products![index].productType.toString(),
                  ),
                )
              : HistoryListTitle(
                  image: widget.products.products![index].image,
                  title: widget.products.products![index].nameUz,
                  personName: widget.products.products![index].description,
                  productNumber: widget.products.products![index].warningCount!,
                  price: widget.products.products![index].price.toString(),
                  isCheck: widget.products.products![index].productTypeCheck
                      .toString(),
                  typeOfCount:
                      widget.products.products![index].productType.toString(),
                );
        },
      ),
    );
  }
}

// class ProductCart extends StatefulWidget {
//   const ProductCart(
//     this.products,
//   );
//   final ProductModel products;

//   @override
//   _ProductCartState createState() => _ProductCartState();
// }

// class _ProductCartState extends State<ProductCart> {
//   late final CartItems cartModel;
//   @override
//   Widget build(BuildContext context) {
//     final product = Provider.of<CartProviderData>(context);
//     return ListView.builder(
//       physics: ScrollPhysics(),
//       itemCount: widget.products.products!.length,
//       itemBuilder: (context, index) {
//         return widget.products.products![index].warningCount != 0
//             ? Dismissible(
//                 child: HistoryListTitle(
//                   image: 'asset/image/photo.png',
//                   title: widget.products.products![index].nameUz,
//                   personName: widget.products.products![index].description,
//                   productNumber:
//                       widget.products.products![index].warningCount.toString(),
//                   price: widget.products.products![index].price.toString(),
//                   isCheck: widget.products.products![index].productTypeCheck
//                       .toString(),
//                 ),
//                 background: Container(
//                   padding: EdgeInsets.only(left: 300),
//                   color: Color(0xFF000000ff),
//                   child: Icon(
//                     Icons.shopping_bag,
//                     color: Color(0xFFBBBBBB),
//                     size: 45,
//                   ),
//                 ),
//                 direction: (DismissDirection.endToStart),
//                 key: UniqueKey(),
//                 onDismissed: (direction) {
//                   CartItems cart = CartItems(
//                     id: widget.products.products![index].id.toString(),
//                     title: widget.products.products![index].nameUz.toString(),
//                     price: widget.products.products![index].price.toString(),
//                     image: widget.products.products![index].image.toString(),
//                     count: widget.products.products![index].warningCount,
//                     idOfProducts:
//                         widget.products.products![index].id.toString(),
//                     isCount: widget.products.products![index].productTypeCheck
//                         .toString(),
//                     quantity: 1,
//                   );
//                   // save.addAndSave(ProductItems(
//                   //   id: widget.products.products![index].nameUz.toString(),
//                   //   title: widget.products.products![index].nameUz.toString(),
//                   //   price: widget.products.products![index].price.toString(),
//                   //   image: widget.products.products![index].image.toString(),
//                   //   count: widget.products.products![index].warningCount,
//                   //   idOfProducts:
//                   //       widget.products.products![index].id.toString(),
//                   //   isCount: widget.products.products![index].productTypeCheck
//                   //       .toString(),
//                   //   quantity: 1,
//                   // ));
//                   // product.addItems(
//                   //   widget.products.products![index].id.toString(),
//                   //   widget.products.products![index].nameUz.toString(),
//                   //   widget.products.products![index].price.toString(),
//                   //   widget.products.products![index].image.toString(),
//                   //   widget.products.products![index].warningCount.toString(),
//                   //   widget.products.products![index].id.toString(),
//                   //   widget.products.products![index].productTypeCheck
//                   //       .toString(),
//                   // );
//                   // print(cart);
//                   setState(() {
//                     widget.products.products!.removeAt(index);
//                   });
//                 })
//             : HistoryListTitle(
//                 image: 'asset/image/photo.png',
//                 title: widget.products.products![index].nameUz,
//                 personName: widget.products.products![index].description,
//                 productNumber:
//                     widget.products.products![index].warningCount.toString(),
//                 price: widget.products.products![index].price.toString(),
//                 isCheck: widget.products.products![index].productTypeCheck
//                     .toString(),
//               );
//       },
//     );
//   }
// }
