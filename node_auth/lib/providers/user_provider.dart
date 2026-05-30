import 'package:flutter/material.dart';
import 'package:node_auth/model/user.dart';

class UserProvider extends ChangeNotifier{
  User _user = User(
    name: '', 
    email: '', 
    id: '', 
    password: '', 
    token: ''
  );
  bool _isLoading = true;

  User get user => _user;
  bool get isLoading => _isLoading;

  void setUser(String user){
    _user = User.fromJson(user);
    notifyListeners();
  }

  void setUserFromModel(User user){
    _user = user;
    notifyListeners();
  }

  void setLoading(bool value){
    _isLoading = value;
    notifyListeners();
  }

}