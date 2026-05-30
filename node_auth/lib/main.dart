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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      authServices.getUserData(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    
    if(userProvider.isLoading){
      return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }
    
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: userProvider.user.token.isEmpty ? const SignupScreen():const MyHomePage()
    );
  }
}
