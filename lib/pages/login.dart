import 'dart:ffi';

import 'package:distributorsapp/components/buttons.dart';
import 'package:distributorsapp/pages/home.dart';
import 'package:distributorsapp/pages/register/registerUserType.dart';
import 'package:flutter/material.dart';

import '../components/template.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  bool isShowPass = true;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Return false to prevent back navigation
        return false;
      },
      child: pageTemplate(
        haveappbar: false,
        thiswidget: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset(
                    'assets/FILIPAYDistributorLogo.png',
                    width: 300,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: "Enter your Email",
                          labelStyle: TextStyle(color: Colors.blueAccent),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!RegExp(
                                  r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b')
                              .hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          // You can add more validation rules for email here
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: "Enter your Password",
                            labelStyle: TextStyle(color: Colors.blueAccent),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isShowPass = !isShowPass;
                                  });
                                },
                                icon: !isShowPass
                                    ? Icon(Icons.remove_red_eye_outlined)
                                    : Icon(Icons.remove_red_eye))),
                        obscureText: isShowPass,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your password';
                          }
                          // You can add more validation rules for email here
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      darkblueButton(
                        label: "SIGN IN",
                        thisFunction: () {
                          if (_formKey.currentState!.validate()) {
                            // If the form is valid, perform necessary actions
                            // For example, you can submit the form
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()),
                            );
                          }
                        },
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "don't have an account?",
                      style: TextStyle(
                          fontStyle: FontStyle.italic, color: Colors.grey),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterUserTypePage()),
                          );
                        },
                        child: Text(
                          'Sign Up Now',
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
