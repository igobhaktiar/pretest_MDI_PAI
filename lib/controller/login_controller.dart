
import 'package:flutter/material.dart';
import 'package:pretest_mdi_pai/api/api.dart';

import '../data/user.dart';
import '../service/user_preferences.dart';

class LoginController with ChangeNotifier {
  AuthState _state = AuthState.notLoggedIn;
  AuthState get state => _state;

  User _user = User(
      id: 0,
      username: '',
      email: '',
      firstName: '',
      lastName: '',
      gender: '',
      image: '',
      token: '',);
  User get user => _user;

  String _message = '';
  String get message => _message;

  void _setState(AuthState state) {
    _state = state;
    notifyListeners();
  }

  Future<Map<String, dynamic>> login(String username, String password) async {
    Map<String, dynamic> result;
    _setState(AuthState.authenticating);
    var data = await Api.login(username, password);
    if (data['status']) {
      _user = data['data'];
      _message = data['message'];
      result = {'status': data['status']};
      UserPreferrences().saveUser(_user);
      _setState(AuthState.loggedIn);
      notifyListeners();
    } else {
      _message = '${data['message']} ${data['data'].message}';
      result = {'status': data['status']};
      _setState(AuthState.notLoggedIn);
      notifyListeners();
    }
    return result;
  }
}
enum AuthState {
  notLoggedIn,
  loggedIn,
  authenticating,
}