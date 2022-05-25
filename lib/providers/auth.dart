import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../helpers/db_helper.dart';
import '../models/business.dart';

class Auth with ChangeNotifier {
  String _token = "0";
  late String _userId;
  bool get isAuth {
    return _token != "0";
  }

  String get token {
    if (_token != "0") {
      return _token;
    }
    return "0";
  }

  String get userId {
    return _userId;
  }

  authenicate(String name, String password) async {
    try {
      final dataList = await DBHelper.getSpecificBusiness(name);
      final _buisnesList = dataList
          .map((e) => Buisnees(
                name: e['name'],
                address: e['address'],
                contact: e['contact'],
                email: e['email'],
                password: e['password'],
              ))
          .toList();
      if (_buisnesList[0].name == '') {
        return 'No Businness Register with this Name';
      }
      if (_buisnesList[0].password != password) {
        return 'Password is wrong';
      } else if (_buisnesList[0].password == password) {
        _token = _buisnesList[0].name;
        _userId = _buisnesList[0].email;
        notifyListeners();
        final prefs = await SharedPreferences.getInstance();
        final userData = json.encode({
          'token': _token,
          'userId': _userId,
        });
        prefs.setString('userData', userData);
        return [_buisnesList[0].name, _buisnesList[0].password];
      }
    } catch (error) {
      return "Error fetching Data" + error.toString();
    }
  }

  Future<bool> tryAutoLogin() async {
    Timer(const Duration(seconds: 2), () {
      //  print('waitting in auto login');
    });
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData = json.decode(prefs.getString('userData') as String)
        as Map<String, Object>;
    _token = extractedUserData['token'] as String;
    _userId = extractedUserData['userId'] as String;

    notifyListeners();
    return true;
  }

  Future<void> logout() async {
    _token = "0";
    _userId = "0";

    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.clear(); //this one remove all the shared pref data so use if you have
    //so use prefs.remove('userData) mthod it can be use to remove paticulara only}
  }
}
