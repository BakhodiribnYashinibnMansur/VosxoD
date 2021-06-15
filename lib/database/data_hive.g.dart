// // GENERATED CODE - DO NOT MODIFY BY HAND

// part of 'data_hive.dart';

// // **************************************************************************
// // TypeAdapterGenerator
// // **************************************************************************

// class SaveListAdapter extends TypeAdapter<SaveList> {
//   @override
//   final int typeId = 0;

//   @override
//   SaveList read(BinaryReader reader) {
//     final numOfFields = reader.readByte();
//     final fields = <int, dynamic>{
//       for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
//     };
//     return SaveList()
//       ..id = fields[0] as dynamic
//       ..name = fields[1] as dynamic
//       ..price = fields[2] as dynamic
//       ..quantity = fields[3] as dynamic
//       ..image = fields[4] as dynamic
//       ..productID = fields[5] as dynamic;
//   }

//   @override
//   void write(BinaryWriter writer, SaveList obj) {
//     writer
//       ..writeByte(6)
//       ..writeByte(0)
//       ..write(obj.id)
//       ..writeByte(1)
//       ..write(obj.name)
//       ..writeByte(2)
//       ..write(obj.price)
//       ..writeByte(3)
//       ..write(obj.quantity)
//       ..writeByte(4)
//       ..write(obj.image)
//       ..writeByte(5)
//       ..write(obj.productID);
//   }

//   @override
//   int get hashCode => typeId.hashCode;

//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is SaveListAdapter &&
//           runtimeType == other.runtimeType &&
//           typeId == other.typeId;
// }
