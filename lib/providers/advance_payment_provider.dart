import 'package:flutter/cupertino.dart';
import '../helpers/db_helper.dart';
import '../models/advance_payment.dart';

class AdvancePaymentProvider with ChangeNotifier {
  List<AdvancePayment> _advancePaymentListAll = [];
  List<AdvancePayment> _selectedCustomerAdvancePaymentList = [];
  List<AdvancePayment> get advancePaymentListForPartiluclarCustomer {
    return [..._selectedCustomerAdvancePaymentList];
  }

  List<AdvancePayment> get addvancePaymetListAll {
    return [..._advancePaymentListAll];
  }

  // ignore: non_constant_identifier_names
  Future<void> AddAdvancePayment(
    String customerId,
    DateTime date,
    DateTime time,
    double amount,
    String description,
  ) async {
    final newAdvancePayment = AdvancePayment(
      id: DateTime.now().toString(),
      customerId: customerId,
      date: date,
      time: time,
      amount: amount,
      description: description,
    );
    _advancePaymentListAll.add(newAdvancePayment);
    notifyListeners();
    DBHelper.insert('advancepayment', {
      'id': DateTime.now().toString(),
      'customerid': newAdvancePayment.customerId,
      'date': newAdvancePayment.date.toIso8601String(),
      'time': newAdvancePayment.time.toIso8601String(),
      'amount': newAdvancePayment.amount,
      'description': newAdvancePayment.description,
    });
  }
  // 'CREATE TABLE advancepayment(
  //   customerid TEXT PRIMARY
  //    KEY,date TEXT,time TEXT,
  //    amount REAL,description TEXT)');

  Future<void> fetchAdvancePayment() async {
    final dataList = await DBHelper.getData('advancepayment');
    _advancePaymentListAll = dataList
        .map((e) => AdvancePayment(
              id: e['id'],
              customerId: e['customerid'],
              date: DateTime.parse(e['date']),
              time: DateTime.parse(e['time']),
              amount: e['amount'],
              description: e['description'],
            ))
        .toList();
    notifyListeners();
  }

  Future<void> fetchAdvancePaymentForPaticulaerCuetomer(
      String customerid) async {
    final dataList =
        await DBHelper.getAdvancePaymentForSpecifivPerson(customerid);
    _advancePaymentListAll = dataList
        .map((e) => AdvancePayment(
              id: e['id'],
              customerId: e['customerid'],
              date: DateTime.parse(e['date']),
              time: DateTime.parse(e['time']),
              amount: e['amount'],
              description: e['description'],
            ))
        .toList();
    _selectedCustomerAdvancePaymentList = _advancePaymentListAll;
    notifyListeners();
  }

  Future<void> deleOneAdvancePaymentTransaction(
      String id, String customerId) async {
    try {
      await DBHelper.delete('advancepayment', id, customerId);
      _selectedCustomerAdvancePaymentList.removeWhere(
          (element) => element.id == id && element.customerId == customerId);
      _advancePaymentListAll.removeWhere(
          (element) => element.id == id && element.customerId == customerId);
      notifyListeners();
    } catch (error) {
      // ignore: use_rethrow_when_possible
      throw error;
    }
  }
}
