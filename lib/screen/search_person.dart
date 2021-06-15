import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:VosxoD/const/const.dart';
import 'package:VosxoD/model/cart_data_json.dart';
import 'package:VosxoD/provider/home_data_provider.dart';
import 'package:VosxoD/utils/my_prefs.dart';
import 'package:sizer/sizer.dart';

class SearchPersn extends StatefulWidget {
  // static const routeName = './productItem';

  @override
  _SearchPersnState createState() => _SearchPersnState();
}

class _SearchPersnState extends State<SearchPersn> {
  late Future<List<CartDataJson>> futureItem;
  late Future<List<CartDataJson>> searchApiFuture;
  late List<dynamic> productOne = [];
  late List<dynamic> productSearch;
  late String searchText = '';
  Future<List<CartDataJson>> getApiOneId() async {
    final TOKEN = MyPref.token;
    Uri URL = Uri.parse("https://vosxod.uz/api/kontragents-all");
    try {
      final response = await http.get(
        URL,
        headers: {"token": TOKEN},
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> map = json.decode(response.body);
        List<dynamic> dataItem = map["kontragents"];
        setState(() {
          productOne = dataItem;
        });
        return dataItem.map((item) => CartDataJson.fromJson(item)).toList();
      } else {
        Map<String, dynamic> map = json.decode(response.body);
        List<CartDataJson> dataItem = map["kontragents"];
        return dataItem;
      }
    } catch (error) {
      throw error;
    }
  }

  Future<List<CartDataJson>> searchApi() async {
    Map<String, dynamic> mapDataR = {"name": searchText};
    final jsonDataR = JsonEncoder().convert(mapDataR);
    final TOKEN = MyPref.token;
    Uri URL = Uri.parse("https://vosxod.uz/api/search-kontragents");
    try {
      final responses = await http.post(
        URL,
        headers: {"token": TOKEN},
        body: jsonDataR,
      );
      if (responses.statusCode == 200) {
        Map<String, dynamic> map = json.decode(responses.body);
        List<dynamic> dataItem = map["kontragents"];
        setState(() {
          productOne.clear();
          productOne = dataItem;
        });
        return dataItem.map((item) => CartDataJson.fromJson(item)).toList();
      } else {
        Map<String, dynamic> map = json.decode(responses.body);
        List<CartDataJson> dataItem = map["kontragents"];
        return dataItem;
      }
    } catch (error) {
      throw error;
    }
  }

  @override
  void initState() {
    super.initState();
    futureItem = getApiOneId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: cBackgroundColor,
        title: Text(' Kontragent Qidirish'),
        elevation: 0,
        centerTitle: true,
      ),
      body: productOne.length != 0
          ? Container(
              color: cBackgroundColor,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 2.h,
                      horizontal: 1.h,
                    ),
                    child: TextFormField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
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
                        hintText: 'Kontrogentlar qidirish',
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
                          productOne.clear();
                          futureItem = getApiOneId();
                        }
                      },
                    ),
                  ),
                  ProductCart(
                    products: productOne,
                  ),
                ],
              ),
            )
          : Container(
              color: cBackgroundColor,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
    );
  }
}

class ProductCart extends StatefulWidget {
  final List<dynamic> products;
  const ProductCart({
    required this.products,
  });

  @override
  _ProductCartState createState() => _ProductCartState();
}

class _ProductCartState extends State<ProductCart> {
  @override
  Widget build(BuildContext context) {
    final person = Provider.of<HomeDataProvider>(context);
    return widget.products.length != 0
        ? Expanded(
            child: Container(
              height: MediaQuery.of(context).size.height,
              color: cBackgroundColor,
              child: ListView.builder(
                itemCount: widget.products.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        person.givePersonID(
                            widget.products[index]['id'].toString());
                        person.givePersonPhone(
                          widget.products[index]['tel_number'],
                        );
                        person.givePersonAddress(
                          widget.products[index]['address'],
                        );
                        person.givePersonName(
                            widget.products[index]['full_name']);
                      });
                      Navigator.of(context).pop(
                        widget.products[index]['full_name'].toString(),
                      );
                    },
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: ListTile(
                            title: Text(
                              widget.products[index]['full_name'],
                              style: TextStyle(
                                color: Color(0xFFC2C2C2),
                              ),
                            ),
                          ),
                        ),
                        Divider(
                          indent: 25,
                          endIndent: 25,
                          height: 2,
                          color: Colors.white,
                        ),
                      ],
                    ),
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
          );
  }
}
