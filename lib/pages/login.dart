import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:distributorsapp/backend/hive/hiveService.dart';
import 'package:distributorsapp/backend/httprequest/httprequest.dart';
import 'package:distributorsapp/components/buttons.dart';
import 'package:distributorsapp/components/modals.dart';
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
  HttprequestService httpRequest = HttprequestService();
  HiveServices hiveService = HiveServices();
  MyModals myModals = MyModals();
  final _formKey = GlobalKey<FormState>();

  bool isShowPass = true;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

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
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height,
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
                              controller: emailController,
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
                              controller: passwordController,
                              decoration: InputDecoration(
                                  labelText: "Enter your Password",
                                  labelStyle:
                                      TextStyle(color: Colors.blueAccent),
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
                              thisFunction: () async {
                                if (_formKey.currentState!.validate()) {
                                  myModals.showProcessing(context, "Checking");
                                  Map<String, dynamic> isLogin =
                                      await httpRequest.isLogin({
                                    "email": "${emailController.text}",
                                    "password": "${passwordController.text}"
                                  });
                                  print('isLogin: $isLogin');
                                  try {
                                    if (isLogin['messages'][0]['code']
                                            .toString() ==
                                        "0") {
                                      if (isLogin['response']['userInfo']
                                          ['isVerified']) {
                                        bool isInserted = await hiveService
                                            .isSaveUserInfo(isLogin['response']
                                                ['userInfo']);
                                        if (isInserted) {
                                          Navigator.of(context).pop();
                                          // If the form is valid, perform necessary actions
                                          // For example, you can submit the form
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HomePage()),
                                          );
                                        } else {
                                          Navigator.of(context).pop();
                                          ArtSweetAlert.show(
                                              context: context,
                                              artDialogArgs: ArtDialogArgs(
                                                  type:
                                                      ArtSweetAlertType.danger,
                                                  title: "Oops...",
                                                  text:
                                                      "SOMETHING WENT WRONG, PLEASE TRY AGAIN"));
                                        }
                                      } else {
                                        Navigator.of(context).pop();
                                        ArtSweetAlert.show(
                                            context: context,
                                            artDialogArgs: ArtDialogArgs(
                                                type: ArtSweetAlertType.danger,
                                                title: "Oops...",
                                                text:
                                                    "Your Account is not Verified yet"));
                                      }
                                    } else {
                                      if (isLogin['messages'][0]['code']
                                              .toString() ==
                                          "500") {
                                        Navigator.of(context).pop();
                                        ArtSweetAlert.show(
                                            context: context,
                                            artDialogArgs: ArtDialogArgs(
                                                type: ArtSweetAlertType.danger,
                                                title: "Oops...",
                                                text:
                                                    "NO INTERNET CONNECTION"));
                                        return;
                                      }
                                      Navigator.of(context).pop();
                                      ArtSweetAlert.show(
                                          context: context,
                                          artDialogArgs: ArtDialogArgs(
                                              type: ArtSweetAlertType.danger,
                                              title: "Oops...",
                                              text: "Wrong email or Password"));
                                    }
                                  } catch (e) {
                                    print(e);
                                    Navigator.of(context).pop();
                                    ArtSweetAlert.show(
                                        context: context,
                                        artDialogArgs: ArtDialogArgs(
                                            type: ArtSweetAlertType.danger,
                                            title: "Oops...",
                                            text:
                                                "SOMETHING WENT WRONG, PLEASE TRY AGAIN"));
                                  }
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
                                fontStyle: FontStyle.italic,
                                color: Colors.grey),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          RegisterUserTypePage()),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
