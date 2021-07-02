import 'dart:convert';

import 'package:VosxoD/const/const.dart';
import 'package:VosxoD/provider/home_data_provider.dart';
import 'package:VosxoD/utils/my_prefs.dart';
import 'package:VosxoD/widget/footer.dart';
import 'package:VosxoD/widget/historyScreen/history_items.dart';
import 'package:VosxoD/widget/homeScreen/home_screen_navbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late Future<void> futureCard;
  late List<dynamic> historyProducts = [];
  Future<void> getHistoryAPI() async {
    final TOKEN = MyPref.token;
    Uri URL = Uri.parse("https://vosxod.uz/api/history");
    try {
      final response = await http.get(
        URL,
        headers: {"token": TOKEN},
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> map = json.decode(response.body);
        List<dynamic> dataCard = map["orders"];

        setState(() {
          loading = true;
          historyProducts = dataCard;
        });
      }
    } catch (error) {
      throw error;
    }
  }

  Map<String, dynamic> alertMap = {};
  Future<void> postAlertAPI(int id) async {
    Map<String, dynamic> mapDataR = {
      "id": id,
    };
    final jsonDataR = JsonEncoder().convert(mapDataR);
    final TOKEN = MyPref.token;
    Uri URL = Uri.parse("https://vosxod.uz/api/order-one");
    try {
      final response = await http.post(
        URL,
        headers: {"token": TOKEN},
        body: jsonDataR,
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> map = json.decode(response.body);
        setState(() {
          alertMap = map;
        });
        _showModalBottomSheet(historyProducts, context);
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> postSelectedHistory(startDataJson, endDataJson) async {
    Map<String, dynamic> mapDataR = {
      "begin": startDataJson,
      "end": endDataJson,
    };
    final jsonDataR = JsonEncoder().convert(mapDataR);
    final TOKEN = MyPref.token;
    Uri URL = Uri.parse("https://vosxod.uz/api/history");
    try {
      final response = await http.post(
        URL,
        headers: {"token": TOKEN},
        body: jsonDataR,
      );
      print(response.body);
      if (response.statusCode == 200) {
        Map<String, dynamic> map = json.decode(response.body);
        List<dynamic> dataCard = map["orders"];
        setState(() {
          loading = true;
          historyProducts = dataCard;
        });
      }
    } catch (error) {
      throw error;
    }
  }

  String? startData = '';
  String? endData = '';
  String? startDataJson = '';
  String? endDataJson = '';
  var dataPicker;
  @override
  void initState() {
    super.initState();

    futureCard = getHistoryAPI();
  }

  bool loading = false;
  @override
  Widget build(BuildContext context) {
    final homeData = Provider.of<HomeDataProvider>(
      context,
    );
    homeData.getPageID('3');
    var now = new DateTime.now();
    var formatter = new DateFormat('dd-MM-yyyy');
    String formattedDate = formatter.format(now);

    return SafeArea(
      child: Scaffold(
        body: Container(
          color: cHomePageBackgroundColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeScreenNavbar(),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 7,
                            horizontal: 15,
                          ),
                          child: Text(
                            'Savdo Tarixi',
                            style: TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 1),
                                fontFamily: 'CeraPro',
                                fontSize: 18,
                                letterSpacing: 0,
                                fontWeight: FontWeight.normal,
                                height: 1),
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  elevation: 0,
                                  backgroundColor: Colors.white,
                                  child: Container(
                                    height: 50.h,
                                    child: Column(
                                      children: [
                                        SfDateRangePicker(
                                          onSelectionChanged:
                                              (DateRangePickerSelectionChangedArgs
                                                  args) {
                                            setState(() {
                                              dataPicker = args.value;
                                            });
                                          },
                                          selectionMode:
                                              DateRangePickerSelectionMode
                                                  .range,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: RaisedButton(
                                            color: Colors.blueAccent,
                                            onPressed: () {
                                              startData = DateFormat(
                                                      'dd-MM-yyyy')
                                                  .format(dataPicker.startDate);
                                              startDataJson = DateFormat(
                                                      'yyyy-MM-dd')
                                                  .format(dataPicker.startDate);
                                              endData = DateFormat('dd-MM-yyyy')
                                                  .format(dataPicker.endDate);
                                              endDataJson = DateFormat(
                                                      'yyyy-MM-dd')
                                                  .format(dataPicker.endDate);
                                              postSelectedHistory(
                                                  startDataJson, endDataJson);
                                              Navigator.of(context)
                                                  .pop(context);
                                            },
                                            child: Text('Malumotlarni Olish'),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Icon(Icons.date_range,
                                      color: Colors.white, size: 22.sp),
                                ),
                                Text(
                                  startData!.length == 0 && endData!.length == 0
                                      ? formattedDate
                                      : startData!.substring(0, 5) +
                                          ' / ' +
                                          endData!,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    loading
                        ? Container(
                            child: Expanded(
                              flex: 14,
                              child: historyProducts.length != 0
                                  ? ListView.builder(
                                      itemCount: historyProducts.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            postAlertAPI(
                                                historyProducts[index]['id']);
                                          },
                                          child: HistoryItems(
                                            image: 'asset/image/photo.png',
                                            title: historyProducts[index]
                                                ['nomer'],
                                            personName: historyProducts[index]
                                                ['kontragent'],
                                            productNumber:
                                                historyProducts[index]['summa'],
                                            price: historyProducts[index]
                                                ['date'],
                                          ),
                                        );
                                      },
                                    )
                                  : Container(
                                      color: cHomePageBackgroundColor,
                                      child: Center(
                                        child: Text(
                                          ' Savdo Tarixlar bo\'sh',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 22),
                                        ),
                                      ),
                                    ),
                            ),
                          )
                        : Container(
                            color: cHomePageBackgroundColor,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                    Spacer(),
                    FootBar(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showModalBottomSheet(List<dynamic> AboutArray, context) {
    List<dynamic> AboutArray;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Color(0x00A0A0A0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      builder: (BuildContext context) {
        return Container(
          height: 700,
          child: DraggableScrollableSheet(
            expand: false,
            builder: (context, scrollController) => SafeArea(
              child: Container(
                margin: EdgeInsets.only(top: 25),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0),
                  ),
                  color: Colors.white,
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                      top: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: Container(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 10,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  'Savdo ma’lumotlari',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      color: Color.fromRGBO(37, 40, 55, 1),
                                      fontFamily: 'CeraPro',
                                      fontSize: 22,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.normal,
                                      height: 1),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Icon(Icons.close),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 10,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  alertMap['order_data']['summa'],
                                  style: TextStyle(
                                      color: Color.fromRGBO(37, 40, 55, 1),
                                      fontFamily: 'CeraPro',
                                      fontSize: 20,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.normal,
                                      height: 1),
                                ),
                                Text(
                                  alertMap['order_data']['nomer'],
                                  style: TextStyle(
                                      color: Color.fromRGBO(37, 40, 55, 1),
                                      fontFamily: 'CeraPro',
                                      fontSize: 20,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.normal,
                                      height: 1),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            indent: 45,
                            endIndent: 45,
                            height: 2,
                            color: Colors.black,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 45,
                            ),
                            child: Text(
                              'Operator',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: 'CeraPro',
                                  fontSize: 16,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.normal,
                                  height: 1),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 45,
                            ),
                            child: Text(
                              alertMap['order_data']['operator'],
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'CeraPro',
                                  fontSize: 14,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.normal,
                                  height: 1),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 45,
                            ),
                            child: Text(
                              'Kontragent',
                              style: TextStyle(
                                  color: Color.fromRGBO(146, 146, 146, 1),
                                  fontFamily: 'CeraPro',
                                  fontSize: 16,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.normal,
                                  height: 1),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 45,
                            ),
                            child: Text(
                              alertMap['order_data']['kontragent'],
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'CeraPro',
                                  fontSize: 14,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.normal,
                                  height: 1),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 45,
                            ),
                            child: Text(
                              'Maxsulot',
                              style: TextStyle(
                                  color: Color.fromRGBO(146, 146, 146, 1),
                                  fontFamily: 'CeraPro',
                                  fontSize: 16,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.normal,
                                  height: 1),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 7,
                            ),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: DataTable(
                                columnSpacing: 25,
                                headingTextStyle: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'CeraPro',
                                    height: 1),
                                dataTextStyle: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'CeraPro',
                                    height: 1),
                                columns: const <DataColumn>[
                                  DataColumn(
                                    label: Text(
                                      'Maxsulot',
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'Miqdori',
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'Narxi',
                                    ),
                                  ),
                                ],
                                rows: <DataRow>[
                                  for (var map in alertMap['products_data'])
                                    DataRow(
                                      cells: <DataCell>[
                                        DataCell(
                                          Text(
                                            map['product_name'].toString(),
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            map['type'] == 'dona'
                                                ? map['count'].toString() +
                                                    ' ta'
                                                : map['count'].toString() +
                                                    '  kg',
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            map['price'].toString() +
                                                ' ' +
                                                'so\'m',
                                          ),
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 45,
                            ),
                            child: Text(
                              'To\'lov',
                              style: TextStyle(
                                  color: Color.fromRGBO(146, 146, 146, 1),
                                  fontFamily: 'CeraPro',
                                  fontSize: 16,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.normal,
                                  height: 1),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 7,
                            ),
                            child: Container(
                              child: DataTable(
                                columnSpacing: 30,
                                headingTextStyle: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'CeraPro',
                                    height: 1),
                                dataTextStyle: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'CeraPro',
                                    height: 1),
                                columns: <DataColumn>[
                                  DataColumn(
                                    label: Text(
                                      'To\'lov turi',
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text('Narxi'),
                                  ),
                                ],
                                rows: <DataRow>[
                                  for (var map in alertMap['payment_data'])
                                    DataRow(
                                      cells: <DataCell>[
                                        DataCell(
                                          Text(
                                            map['name'].toString(),
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            map['amount'].toString(),
                                          ),
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 45,
                            ),
                            child: Text(
                              'Sana',
                              style: TextStyle(
                                  color: Color.fromRGBO(146, 146, 146, 1),
                                  fontFamily: 'CeraPro',
                                  fontSize: 16,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.normal,
                                  height: 1),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 45,
                            ),
                            child: Text(
                              alertMap['order_data']['date'],
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'CeraPro',
                                  fontSize: 16,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.normal,
                                  height: 1),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
