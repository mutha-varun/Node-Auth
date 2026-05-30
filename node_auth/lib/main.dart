import 'package:flutter/material.dart';
import 'package:node_auth/providers/user_provider.dart';
import 'package:node_auth/screens/homescreen.dart';
import 'package:node_auth/screens/signup_screen.dart';
import 'package:node_auth/services/auth_services.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create:(_)=> UserProvider())
    ],
    child: const MyApp()
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    final AuthServices authServices = AuthServices();
    super.initState();
    authServices.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Provider.of<UserProvider>(context).user.token.isEmpty ? const SignupScreen():const MyHomePage()
    );
  }
}
