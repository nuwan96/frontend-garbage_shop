import 'package:flutter/cupertino.dart';
import '../helpers/db_helper.dart';
import '../models/business.dart';

class TeaBuyer with ChangeNotifier {
  List<Buisnees> _buisnesList = [];
  List<Buisnees> get businessList {
    return [..._buisnesList];
  }

  Future<void> addBusiness(
    String name,
    String address,
    String contact,
    String email,
    String password,
  ) async {
    final newBusiness = Buisnees(
      name: name,
      address: address,
      contact: contact,
      email: email,
      password: password,
    );
    _buisnesList.add(newBusiness);
    notifyListeners();
    DBHelper.insert('business', {
      'name': newBusiness.name,
      'address': newBusiness.address,
      'contact': newBusiness.contact,
      'email': newBusiness.email,
      'password': newBusiness.password,
    });
  }

  Future<void> fetchBuisness() async {
    final dataList = await DBHelper.getData('business');
    _buisnesList = dataList
        .map((e) => Buisnees(
              name: e['name'],
              address: e['address'],
              contact: e['contact'],
              email: e['email'],
              password: e['password'],
            ))
        .toList();
    notifyListeners();
  }
}
