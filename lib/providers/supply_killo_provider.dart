import 'package:flutter/foundation.dart';
import '../helpers/db_helper.dart';
import '../models/suppli_tea.dart';

class SuppliKilloProvider with ChangeNotifier {
  List<SuppliTea> _suppliKiloList = [];
  List<SuppliTea> get suppliKiloList {
    return [..._suppliKiloList];
  }

  List<SuppliTea> _suppliKiloListForSepcificCustomer = [];
  List<SuppliTea> get suppliKiloListForSepcificCustomer {
    return [..._suppliKiloListForSepcificCustomer];
  }

  // ignore: non_constant_identifier_names
  Future<void> AddSupplieKilos(
    String customerId,
    DateTime date,
    DateTime time,
    double amount,
    double numberOfBages,
  ) async {
    final newSupplyKilo = SuppliTea(
      id: DateTime.now().toString(),
      customerId: customerId,
      date: date,
      time: time,
      amount: amount,
      numberOfBages: numberOfBages,
    );
    _suppliKiloList.add(newSupplyKilo);
    notifyListeners();
    DBHelper.insert('supplykillo', {
      'id': DateTime.now().toString(),
      'customerid': newSupplyKilo.customerId,
      'date': newSupplyKilo.date.toIso8601String(),
      'time': newSupplyKilo.time.toIso8601String(),
      'amount': newSupplyKilo.amount,
      'numberofbages': newSupplyKilo.numberOfBages,
    });
  }

  // 'CREATE TABLE supplyki
  //llo(customerid TEXT
  //PRIMARY KEY,date
  // TEXT,time TEXT,amount REAL,numberofbages REAL)');
  Future<void> fetchSupplyKilo() async {
    final dataList = await DBHelper.getData('supplykillo');
    _suppliKiloList = dataList
        .map((e) => SuppliTea(
              id: e['id'],
              customerId: e['customerid'],
              date: DateTime.parse(e['date']),
              time: DateTime.parse(e['time']),
              amount: e['amount'],
              numberOfBages: e['numberofbages'],
            ))
        .toList();
    notifyListeners();
  }

  Future<void> fetchSupplyKiloForSpecificCustomer(String cusId) async {
    final dataList = await DBHelper.getSuppliedKilosForSpecifivPerson(cusId);
    _suppliKiloList = dataList
        .map((e) => SuppliTea(
              id: e['id'],
              customerId: e['customerid'],
              date: DateTime.parse(e['date']),
              time: DateTime.parse(e['time']),
              amount: e['amount'],
              numberOfBages: e['numberofbages'],
            ))
        .toList();
    _suppliKiloListForSepcificCustomer = _suppliKiloList;
    notifyListeners();
  }

  Future<void> deleOneSuppledTransaction(String id, String customerId) async {
    try {
      await DBHelper.delete('supplykillo', id, customerId);
      _suppliKiloListForSepcificCustomer.removeWhere(
          (element) => element.id == id && element.customerId == customerId);
      _suppliKiloList.removeWhere(
          (element) => element.id == id && element.customerId == customerId);
      notifyListeners();
    } catch (error) {
      // ignore: use_rethrow_when_possible
      throw error;
    }
  }
}
