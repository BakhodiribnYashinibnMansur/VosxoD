// import 'package:hive/hive.dart';
// import 'package:VosxoD/model/boxes.dart';

// part "data_hive.g.dart";

// @HiveType(typeId: 0)
// class SaveList extends HiveObject {
//   @HiveField(0)
//   dynamic id;
//   @HiveField(1)
//   dynamic name;
//   @HiveField(2)
//   dynamic price;
//   @HiveField(3)
//   dynamic quantity;
//   @HiveField(4)
//   dynamic image;
//   @HiveField(5)
//   dynamic productID;
// }

// void editTransaction(
//   SaveList list,
//   String name,
//   double amount,
//   bool isExpense,
// ) {
//   list.name = name;
//   list.amount = amount;
//   list.isExpense = isExpense;

//   // final box = Boxes.getlists();
//   // box.put(list.key, list);

//   list.save();
// }

// void deleteTransaction(SaveList transaction) {
//   // final box = Boxes.getTransactions();
//   // box.delete(transaction.key);

//   transaction.delete();


// // Future<void> addProduct(
// //     {@required String boxName, @required List<DataSqlite> product}) async {
// //   var box = await Hive.openBox(boxName);
// //   box.put(boxName, product);
// //   print(" ADICIONADO NO HIVE!");
// // }

// // Future<List<DataSqlite>> getProduct({@required String boxName}) async {
// //   var box = await Hive.openBox(boxName);
// //   List<DataSqlite> wallpapers = box.get("latest");
// //   return wallpapers;
// // }
