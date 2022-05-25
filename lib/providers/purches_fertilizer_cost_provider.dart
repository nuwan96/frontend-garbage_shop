import 'package:flutter/cupertino.dart';
import '../helpers/db_helper.dart';
import '../models/purches_fertilizer_cost.dart';

class PurchesFertilzerCostProvider with ChangeNotifier {
  List<PurchedFertilizerCost> _purchedFertilizerCostList = [];
  List<PurchedFertilizerCost> get purchedFertilizerCost {
    return [..._purchedFertilizerCostList];
  }

  List<PurchedFertilizerCost> _purchedFertilizerCostListForSelectedCustomer =
      [];
  List<PurchedFertilizerCost> get purchedFertilizerCostForSelectedCustomer {
    return [..._purchedFertilizerCostListForSelectedCustomer];
  }

  // ignore: non_constant_identifier_names
  Future<void> AddPurchedFertilizerCost(
    String customerId,
    DateTime date,
    DateTime time,
    String fertilizerType,
    double amount,
    double price,
  ) async {
    final newPurchedFertilizerCost = PurchedFertilizerCost(
      id: DateTime.now().toString(),
      customerId: customerId,
      date: date,
      time: time,
      ferilizerType: fertilizerType,
      amount: amount,
      price: price,
    );
    _purchedFertilizerCostList.add(newPurchedFertilizerCost);
    notifyListeners();
    DBHelper.insert('purchesfertilizercost', {
      'id': DateTime.now().toString(),
      'customerid': newPurchedFertilizerCost.customerId,
      'date': newPurchedFertilizerCost.date.toIso8601String(),
      'time': newPurchedFertilizerCost.time.toIso8601String(),
      'fertilizertype': newPurchedFertilizerCost.ferilizerType,
      'amount': newPurchedFertilizerCost.amount,
      'price': newPurchedFertilizerCost.price,
    });
  }

  //           'CREATE TABLE purchesfertilizercost(
  //             customerid TEXT PRIMARY KEY,
  //             date TEXT,
  //             time TEXT,
  //             fertilizertype TEXT,
  //             amount REAL,
  //             price REAL)');
  //  ofbages REAL)');
  Future<void> fetchPurchedFertilizerCost() async {
    final dataList = await DBHelper.getData('purchesfertilizercost');
    _purchedFertilizerCostList = dataList
        .map((e) => PurchedFertilizerCost(
              id: e['id'],
              customerId: e['customerid'],
              date: DateTime.parse(e['date']),
              time: DateTime.parse(e['time']),
              ferilizerType: e['fertilizertype'],
              amount: e['amount'],
              price: e['price'],
            ))
        .toList();
    notifyListeners();
  }

  Future<void> fetchPurchedFertilizerCostForSpecificCustomer(
      String cusId) async {
    final dataList = await DBHelper.getFettilizerCostForSpecifivPerson(cusId);
    _purchedFertilizerCostList = dataList
        .map((e) => PurchedFertilizerCost(
              id: e['id'],
              customerId: e['customerid'],
              date: DateTime.parse(e['date']),
              time: DateTime.parse(e['time']),
              ferilizerType: e['fertilizertype'],
              amount: e['amount'],
              price: e['price'],
            ))
        .toList();
    _purchedFertilizerCostListForSelectedCustomer = _purchedFertilizerCostList;
    notifyListeners();
  }

  Future<void> deleOneFetrilizerCosrTransaction(
      String id, String customerId) async {
    try {
      await DBHelper.delete('purchesfertilizercost', id, customerId);
      _purchedFertilizerCostListForSelectedCustomer.removeWhere(
          (element) => element.id == id && element.customerId == customerId);
      _purchedFertilizerCostList.removeWhere(
          (element) => element.id == id && element.customerId == customerId);
      notifyListeners();
    } catch (error) {
      // ignore: use_rethrow_when_possible
      throw error;
    }
  }
}
