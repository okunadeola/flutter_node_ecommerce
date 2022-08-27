import 'package:ecom/models/user.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String? _deviceToken;

  User _user = User(
    id: '',
    name: '',
    email: '',
    password: '',
    address: '',
    type: '',
    token: '',
    cart: [],
  );

  User get user => _user;
  String? get deviceToken => _deviceToken;

  void updateDeviceToken(String? token) {
    _deviceToken = token;
    notifyListeners();
  }

  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }

  void resetUser(User user) {
    _user = user;
    notifyListeners();
  }

  void setUserFromModel(User user) {
    _user = user;
    notifyListeners();
  }
}
// class SingleProvider extends ChangeNotifier {
//   int quantity = 0;


//   User get user => _user;

//   void setUser(String user) {
//     _user = User.fromJson(user);
//     notifyListeners();
//   }

//   void resetUser(User user) {
//     _user = user;
//     notifyListeners();
//   }

//   void setUserFromModel(User user) {
//     _user = user;
//     notifyListeners();
//   }
// }
