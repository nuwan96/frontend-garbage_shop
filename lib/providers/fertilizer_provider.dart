import 'dart:io';
import 'package:flutter/foundation.dart';
import '../helpers/db_helper.dart';
import '../models/fertilizer.dart';

class FertilizerProvider with ChangeNotifier {
  List<Fertilizer> _fertilizerList = [
    // Fertilizer(
    // name: "T200",
    // type: "Liqued",
    // unitPrice: 23.00,
    // storeAmount: 500.00,
    // image: File(''),
    // ),
  ];
  List<Fertilizer> get fertilizerList {
    return [..._fertilizerList];
  }

  // ignore: non_constant_identifier_names
  Future<void> AddFertilizer(
    String name,
    String type,
    double unitPrice,
    double storeAmount,
    File image,
  ) async {
    final newFertilizer = Fertilizer(
      name: name,
      type: type,
      unitPrice: unitPrice,
      storeAmount: storeAmount,
      image: image,
    );
    _fertilizerList.add(newFertilizer);
    notifyListeners();
    // 'CREATE TABLE fertilizer
    // (name TEXT PRIMARY KEY,type TEXT,unitprice REAL,storeamount REAL,image TEXT)');

    DBHelper.insert('fertilizer', {
      'name': newFertilizer.name,
      'type': newFertilizer.type,
      'unitprice': newFertilizer.unitPrice,
      'storeamount': newFertilizer.storeAmount,
      'image': newFertilizer.image.path,
    });
  }

  Future<void> fetchFertilizer() async {
    final dataList = await DBHelper.getData('fertilizer');
    _fertilizerList = dataList
        .map((e) => Fertilizer(
              name: e['name'],
              type: e['type'],
              unitPrice: e['unitprice'],
              storeAmount: e['storeamount'],
              image: File(e['image']),
            ))
        .toList();
    notifyListeners();
  }

  fetchFertilizerFromDatabase() async {
    final dataList = await DBHelper.getData('fertilizer');
    _fertilizerList = dataList
        .map((e) => Fertilizer(
              name: e['name'],
              type: e['type'],
              unitPrice: e['unitprice'],
              storeAmount: e['storeamount'],
              image: File(e['image']),
            ))
        .toList();
    notifyListeners();
    return _fertilizerList;
  }
}
