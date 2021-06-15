// import 'package:flutter/foundation.dart';
// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
// import 'dart:io' as io;

// class DataSqlite {
//   dynamic id;
//   dynamic name;
//   dynamic price;
//   dynamic quantity;
//   dynamic image;
//   dynamic productID;
//   static const String TABLE_NAME = "Products_data";
//   DataSqlite([
//     this.id,
//     this.name,
//     this.price,
//     this.quantity,
//     this.image,
//     this.productID,
//   ]);
//   DataSqlite.fromJson(Map<String, dynamic> json)
//       : this.id = json['id'],
//         this.name = json['name'],
//         this.price = json['price'],
//         this.quantity = json['quantity'],
//         this.image = json['image'],
//         this.productID = json['productID'];

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "price": price,
//         "quantity": quantity,
//         "image": image,
//         "productID": productID
//       };
// }

// //   Message.fromJson(Map<String, dynamic> json)
// //       : this.id = json['id'],
// //         this.title = json['title'],
// //         this.body = json['body'];
// //   Map<String, dynamic> toJson() => {
// //         'id': id,
// //         'title': title,
// //         'body': body,
// //       };
// // }
//   // DataSqlite.fromMap(Map<String, dynamic> map) {
//   //   DataSqlite(
//   //     id: map["id"],
//   //     name: map["name"],
//   //     price: map["price"],
//   //     quantity: map["quantity"],
//   //     image: map["image"],
//   //     productID: map["productID"],
//   //   );
//   // }
// // }

// // class DataBaseHelperProducts {
// //   static const String ID = 'id';
// //   static const String NAME = 'name';
// //   static const String PRICE = 'price';
// //   static const String QUANTITY = 'quantity';
// //   static const String IMAGE = 'image';
// //   static const String PRODUCTID = 'productID';
// //   static const DATABASE_NAME = "productDB.db";
// //   static final DataBaseHelperProducts db = DataBaseHelperProducts();
// //   static Database _database;

// //   Future<Database> get database async {
// //     if (_database == null) {
// //       return await initializeDatabase();
// //     }
// //     return _database;
// //   }

// //   initializeDatabase() async {
// //     io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
// //     String path = join(documentsDirectory.path, DATABASE_NAME);
// //     var db = await openDatabase(path, version: 1,
// //         onCreate: (Database db, int version) async {
// //       await db.execute(
// //         "CREATE TABLE ${DataSqlite.TABLE_NAME} ($ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL UNIQUE,$NAME TEXT , $PRICE TEXT ,$QUANTITY TEXT , $IMAGE TEXT ,$PRODUCTID TEXT )",
// //       );
// //     });
// //     return db;
// //   }

// //   Future<DataSqlite> saveProduct(DataSqlite product) async {
// //     final db = await database;
// //     product.id = db.insert(
// //       DataSqlite.TABLE_NAME,
// //       product.toMap(),
// //       conflictAlgorithm: ConflictAlgorithm.replace,
// //     );
// //     return product;
// //   }

// //   Future<List<DataSqlite>> getProducts() async {
// //     final db = await database;
// //     List<Map> maps = await db.query(DataSqlite.TABLE_NAME,
// //         columns: [ID, NAME, PRICE, QUANTITY, IMAGE, PRODUCTID]);
// //     List<DataSqlite> list = [];
// //     if (maps.length > 0) {
// //       for (int i = 0; i < maps.length; i++) {
// //         list.add(DataSqlite.fromMap(maps[i]));
// //       }
// //     }
// //     return list;
// //   }

// //   Future<int> update(DataSqlite product) async {
// //     final db = await database;
// //     return await db.update(DataSqlite.TABLE_NAME, product.toMap(),
// //         where: '$ID = ?', whereArgs: [product.id]);
// //   }

// //   Future<int> delete(int id) async {
// //     final db = await database;
// //     return await db
// //         .delete(DataSqlite.TABLE_NAME, where: '$ID = ?', whereArgs: [id]);
// //   }

// //   Future close() async {
// //     final db = await database;
// //     db.close();
// //   }
// //   // Future<List<DataSqlite>> getAllProducts() async {
// //   //   final db = await database;
// //   //   final List<Map<String, dynamic>> maps =
// //   //       await db.query(DataSqlite.TABLE_NAME);
// //   //   return List.generate(
// //   //     maps.length,
// //   //     (index) {
// //   //       return DataSqlite(
// //   //         id: maps[index]["id"],
// //   //         name: maps[index]["name"],
// //   //         price: maps[index]["price"],
// //   //         quantity: maps[index]["quantity"],
// //   //         image: maps[index]["image"],
// //   //         productID: maps[index]["productID"],
// //   //       );
// //   //     },
// //   //   );
// //   // }

// //   // Future<int> updateProduct(DataSqlite product) async {
// //   //   final db = await database;
// //   //   return db.update(DataSqlite.TABLE_NAME, product.toJson(),
// //   //       where: 'id = ?',
// //   //       conflictAlgorithm: ConflictAlgorithm.replace,
// //   //       whereArgs: [product.id]);
// //   // }

// //   // Future<int> deleteProduct(int id) async {
// //   //   final db = await database;
// //   //   return db.delete(DataSqlite.TABLE_NAME, where: 'id = ?', whereArgs: [id]);
// //   // }
// // }
