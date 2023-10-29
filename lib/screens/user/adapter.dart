import 'package:hive/hive.dart';

import 'package:flutter/material.dart';
import 'package:offerapp/screens/user/shoppingitem.dart';


class ShoppingItemAdapter extends TypeAdapter<ShoppingItem> {
  @override
  final int typeId = 0;

  @override
  ShoppingItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ShoppingItem(

        name: fields[0] as String,
        price: fields[1] as double,
        id: fields[2] as String,

      storeid: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ShoppingItem obj) {
    print(obj.id);
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.price)
      ..writeByte(2)
      ..write(obj.id)

      ..writeByte(3)
      ..write(obj.storeid);


  }
}
