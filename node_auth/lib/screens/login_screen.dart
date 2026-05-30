import 'package:flutter/material.dart';
import 'package:node_auth/custom_textfield.dart';
import 'package:node_auth/services/auth_services.dart';

class LoginScreen extends StatefulWidget {

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthServices authServices = AuthServices();

  void loginUser(){
    authServices.signInUser(context: context, email: emailController.text, password: passwordController.text);
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Login",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold
            ),
          ),
          const SizedBox(height: 40,),
          CustomTextfield(
            controller: emailController,
            hint: "Enter your email", obscure: false
          ),
          const SizedBox(height: 12 ,),
          CustomTextfield(
            controller: passwordController,
            hint: "Enter your password", obscure: true
          ),
          const SizedBox(height: 20,),
          ElevatedButton(
            onPressed: loginUser, 
            child: const Text("Login")
          )
        ],
      ),
    );
  }
}
