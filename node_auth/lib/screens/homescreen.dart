import 'package:flutter/material.dart';
import 'package:node_auth/services/auth_services.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});


  void signOutUser(BuildContext context){
    AuthServices().signOut(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: ()=>signOutUser(context), 
            child: const Text("Sign Out")
          )
        ],
      ),
      body: Center(
        child: const Text("Yes")
      )
    );
  }
}
