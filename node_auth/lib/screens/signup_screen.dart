import 'package:flutter/material.dart';
import 'package:node_auth/custom_textfield.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Signup",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 30),
          CustomTextfield(
            controller: name,
            hint: "Enter your name", obscure: false),
          const SizedBox(height: 12,),
          CustomTextfield(
            controller: email,
            hint: "Enter your email", obscure: false),
          const SizedBox(height: 12,),
          CustomTextfield(
            controller: password,
            hint: "Enter your password", obscure: true),
          const SizedBox(height: 20,),
          ElevatedButton(onPressed: () {}, child: const Text("Sign up")),
          const SizedBox(height: 70),
          TextButton(onPressed: () {}, child: const Text("Login user?")),
        ],
      ),
    );
  }
}
