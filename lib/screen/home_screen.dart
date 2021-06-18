import 'dart:convert';

import 'package:VosxoD/const/const.dart';
import 'package:VosxoD/main.dart';
import 'package:VosxoD/model/home_data_json.dart';
import 'package:VosxoD/model/redux_model.dart';
import 'package:VosxoD/provider/home_data_provider.dart';
import 'package:VosxoD/screen/product_banch.dart';
import 'package:VosxoD/screen/search_person.dart';
import 'package:VosxoD/service/get_home_api.dart';
import 'package:VosxoD/utils/my_prefs.dart';
import 'package:VosxoD/widget/footer.dart';
import 'package:VosxoD/widget/homeScreen/home_screen_card.dart';
import 'package:VosxoD/widget/homeScreen/home_screen_navbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'search_product.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<void> futureData;

  final GetHomeData getHomeData = GetHomeData();
  late List<dynamic> homeJson = [];
  late PageController _pageController;

  Future<void> getApis() async {
    final TOKEN = MyPref.token;
    Uri URL = Uri.parse("https://vosxod.uz/api/big-categories");
    try {
      final response = await http.get(
        URL,
        headers: {"token": TOKEN},
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> map = json.decode(response.body);
        List<dynamic> data = map['categories'];
        setState(() {
          homeJson = data;
        });
        // for (int x = 0; x < data.length; x++) {
        //   context
        //       .read<FutureHomeData>()
        //       .addItems(data[x]['name'], data[x]['id']);
        // }
        // data.forEach((item) {
        //   context.read<FutureHomeData>().addItems(item['name'], item['id']);
        //   print(item);
        // });
        // data.map((item) => HomeDataJson.fromJson(item)).toList();
      } else {
        Map<String, dynamic> map = json.decode(response.body);
        List<HomeDataJson> data = map['categories'];
      }
    } catch (error) {
      throw error;
    }
  }

  @override
  void initState() {
    super.initState();
    futureData = getApis();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // final model = ViewModel();
  String nameK = 'null';
  @override
  Widget build(BuildContext context) {
    final homeData = Provider.of<HomeDataProvider>(context, listen: true);
    returnName() {
      if (nameK == 'null' && homeData.returnPersonName() == 'null') {
        return 'Kontragent Tanlash';
      }
      if (nameK != 'null' || homeData.returnPersonName() == 'null') {
        return nameK;
      }
      if (nameK == 'null' || homeData.returnPersonName() != 'null') {
        return homeData.returnPersonName();
      }
    }

    // final store = save.returnLength();
    // print(store.length == 0 ? "0" : store.length.toString());
    String kontragentText = returnName();
    // model.onAddItem!(
    //   CartItems(
    //     count: 54,
    //     id: 'kk',
    //     idOfProducts: 'kskd',
    //     image: 'kdsfj',
    //     isCount: 'kdnf',
    //     price: 'dwd',
    //     quantity: 1,
    //     title: 'dededk',
    //   ),
    // );   // print(model.items);
    homeData.getPageID('1');
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: cHomePageBackgroundColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeScreenNavbar(),
              GestureDetector(
                onTap: () {
                  _navigatorSearchPerson(context);
                },
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(
                    horizontal: 2.h,
                    vertical: 1.h,
                  ),
                  height: 5.5.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 39.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                            bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12),
                          ),
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 2.h,
                          vertical: 1.4.h,
                        ),
                        child: Text(
                          kontragentText,
                          style: TextStyle(
                            fontSize: 13.sp,
                          ),
                          maxLines: 1,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          homeData.givePersonID('null');
                          homeData.givePersonPhone('null');
                          homeData.givePersonAddress('null');
                          homeData.givePersonName('null');
                          setState(() {
                            nameK = 'null';
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                              bottomLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12),
                            ),
                            color: Colors.white,
                          ),
                          margin: EdgeInsets.symmetric(
                            horizontal: .4.h,
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 1.h,
                            vertical: .7.h,
                          ),
                          child: Icon(
                            Icons.close,
                            size: 25.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    PageTransition(
                      type: PageTransitionType.fade,
                      child: SearchProducts(),
                      ctx: context,
                      alignment: Alignment.center,
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 2.h,
                    vertical: 1.h,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 2.h,
                    vertical: 1.h,
                  ),
                  height: 5.5.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Maxsulotlarni qidirish',
                        style: TextStyle(
                          fontSize: 13.sp,
                        ),
                      ),
                      Spacer(),
                      Icon(Icons.search_outlined, size: 25.sp),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 1.h,
                  left: 2.h,
                  bottom: 2.h,
                ),
                child: Text(
                  'Kategoriyalar',
                  style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontFamily: 'CeraPro',
                    fontSize: 19.sp,
                    letterSpacing: 0,
                    fontWeight: FontWeight.normal,
                    height: 1,
                  ),
                ),
              ),
              Expanded(flex:12,
                child: homeJson.length != 0
                    ? Container(
                        padding: EdgeInsets.only(
                          left: 2.h,
                          right: 2.h,
                        ),
                        child: GridView.builder(
                          itemCount: homeJson.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  PageTransition(
                                    type: PageTransitionType.fade,
                                    child: ProductBanch(
                                      homeJson[index]['name']!,
                                      homeJson[index]['id']!,
                                    ),
                                    ctx: context,
                                    alignment: Alignment.center,
                                  ),
                                );
                              },
                              child: HomeScreenCard(
                                Color(0xFF2529F8f),
                                Icon(Icons.bug_report_outlined),
                                homeJson[index]['name']!,
                              ),
                            );
                          },
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 1.4.h,
                            crossAxisSpacing: 1.4.h,
                            childAspectRatio: 7 / 7,
                          ),
                        ),
                      )
                    : Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
              ),
              Spacer(),
              FootBar(),
            ],
          ),
        ),
      ),
    );
  }

  void _navigatorSearchPerson(BuildContext context) async {
    final result = await Navigator.of(context).push(
      PageTransition(
        type: PageTransitionType.fade,
        child: SearchPersn(),
        ctx: context,
        alignment: Alignment.center,
      ),
    );
    setState(() {
      nameK = result;
    });
  }
}
