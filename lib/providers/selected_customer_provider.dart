import 'dart:io';
import 'package:flutter/cupertino.dart';
import '../models/customer.dart';

class SelectedCustomerProvider with ChangeNotifier {
  Customer selectedCustomer = Customer(
      name: 'Name of the customer',
      id: "ID",
      address: "Test",
      dateOfBirth: "test",
      contact: "test",
      accountNumber: "test",
      email: "test",
      image: File(''));
  Customer get selectedCustomerGetter {
    return selectedCustomer;
  }

  void addSelectedCusotmer(Customer newSelectedCustomer) {
    selectedCustomer = newSelectedCustomer;
    notifyListeners();
  }
}
