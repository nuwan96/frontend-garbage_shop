import 'dart:io';
import 'package:flutter/cupertino.dart';
import '../helpers/db_helper.dart';
import '../models/customer.dart';

class CustomerProvider with ChangeNotifier {
  List<Customer> _customerList = [];
  List<Customer> get customerList {
    return [..._customerList];
  }

  Future<void> addCustomer(
    String name,
    String id,
    String address,
    String contact,
    String dateOfBirth,
    String accountNumber,
    String email,
    File image,
  ) async {
    final newCustomer = Customer(
      name: name,
      id: id,
      address: address,
      contact: contact,
      accountNumber: accountNumber,
      dateOfBirth: dateOfBirth,
      email: email,
      image: image,
    );
    _customerList.add(newCustomer);
    notifyListeners();
    DBHelper.insert('customer', {
      'id': newCustomer.id,
      'name': newCustomer.name,
      'address': newCustomer.address,
      'contact': newCustomer.contact,
      'dateofbirth': newCustomer.dateOfBirth,
      'accountnumber': newCustomer.accountNumber,
      'email': newCustomer.email,
      'image': newCustomer.image.path
    });
  }

  // Customer findByIdOfCustomer(String id) {
  //   return _customerList.firstWhere((element) => element.id == id);
  // }

  Future<void> fetchAndSetCustomers() async {
    final dataList = await DBHelper.getData('customer');
    _customerList = dataList
        .map((e) => Customer(
              id: e['id'],
              name: e['name'],
              address: e['address'],
              dateOfBirth: e['dateofbirth'],
              contact: e['contact'],
              accountNumber: e['accountnumber'],
              email: e['email'],
              image: File(e['image']),
            ))
        .toList();
    notifyListeners();
  }

  fetchCustomerListFormDatabase() async {
    try {
      final dataList = await DBHelper.getData('customer');
      _customerList = dataList
          .map((e) => Customer(
                id: e['id'],
                name: e['name'],
                address: e['address'],
                dateOfBirth: e['dateofbirth'],
                contact: e['contact'],
                accountNumber: e['accountnumber'],
                email: e['email'],
                image: File(e['image']),
              ))
          .toList();
      return _customerList;
    } catch (error) {
      // print(error.toString());
    }
  }
}
