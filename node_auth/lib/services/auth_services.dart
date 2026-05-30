import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:node_auth/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:node_auth/providers/user_provider.dart';
import 'package:node_auth/screens/homescreen.dart';
import 'package:node_auth/screens/signup_screen.dart';
import 'package:node_auth/utils/constants.dart';
import 'package:node_auth/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthServices {
  void signUpUser({
    required BuildContext context, 
    required String email,
    required String password,
    required String name
  }) async{
    try{

      User user = User(
        id: '',
        name: name,
        email: email,
        password: password,
        token: ''
      );

      http.Response res = await http.post(
        Uri.parse('${Constants.uri}/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );

      if(context.mounted){
        httpErrorHandle(
          response: res , 
          context: context, 
          onSuccess: (){
            showSnackBar(context, 'Account Created!');
          }
        );
      }
      

    }catch(e){
      // ignore: use_build_context_synchronously
      showSnackBar(context, e.toString());
    }
  }

  void signInUser({
    required BuildContext context,
    required String email,
    required String password
  }) async{
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      final navigator = Navigator.of(context);
      final User user = User(name: '', email: email, id: '', password: password, token: ' ');
      http.Response res = await http.post(
        Uri.parse("${Constants.uri}/api/signin"),
        body: user.toJson(),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8"
        }
      );
      if(context.mounted){
        httpErrorHandle(
          response: res, 
          context: context, 
          onSuccess: () async{
            SharedPreferences pref = await SharedPreferences.getInstance();
            userProvider.setUser(res.body);
            await pref.setString('x-auth-token', jsonDecode(res.body)['token']);
            navigator.pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const MyHomePage()), 
              (route)=> false
              );
          }
        );
      }
      
    } catch (e) {
      if(context.mounted){
        showSnackBar(context, e.toString());
      }   
    }
  }

  void getUserData(
    BuildContext context
  )async {
    try{
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("x-auth-token");

      if(token == null){
        prefs.setString('x-auth-token', '');
        userProvider.setLoading(false);
        token = '';
      }

      var tokenRes = await http.post(
        Uri.parse('${Constants.uri}/tokenIsValid'),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          "x-auth-token": token
        },
      );

      var response = jsonDecode(tokenRes.body);

      if(response == true){
        http.Response res = await http.get(
          Uri.parse("${Constants.uri}/"),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
            "x-auth-token": token 
          }
        );
        userProvider.setUser(res.body);
      }
      
      userProvider.setLoading(false);

    }catch(e){
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.setLoading(false);
      if(context.mounted){
        showSnackBar(context, e.toString());
      }
    }
  }

  void signOut(
    BuildContext context
  ) async{
    var navigator = Navigator.of(context);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("x-auth-token", '');
    
    navigator.pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const SignupScreen()
      ), 
      (route)=> false
    );
  }
}