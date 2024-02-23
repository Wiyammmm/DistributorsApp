import 'dart:async';

import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:distributorsapp/components/buttons.dart';
import 'package:distributorsapp/components/color.dart';
import 'package:distributorsapp/components/modals.dart';
import 'package:distributorsapp/components/template.dart';
import 'package:distributorsapp/components/textfields.dart';
import 'package:distributorsapp/components/widgets.dart';
import 'package:distributorsapp/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class RegisterGetVerified extends StatefulWidget {
  const RegisterGetVerified({super.key});

  @override
  State<RegisterGetVerified> createState() => _RegisterGetVerifiedState();
}

class _RegisterGetVerifiedState extends State<RegisterGetVerified> {
  final TextEditingController numberController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  String initialCountry = 'PH';
  PhoneNumber number = PhoneNumber(isoCode: 'PH');
  MyModals myModals = MyModals();
  @override
  Widget build(BuildContext context) {
    return pageTemplate(
        thiswidget: Column(
          children: [
            Container(
                width: double.infinity,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Image.asset(
                      "assets/FILIPAYDistributorLogo2.png",
                      width: 120,
                    ),
                  ),
                )),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(
                  child: SingleChildScrollView(
                      child: Column(
                children: [
                  Text(
                    'Get Verified',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                  Text(
                    'Verify your account to proceed',
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 2, color: myColors.darkblue)),
                    child: InternationalPhoneNumberInput(
                      isEnabled: false,
                      onInputChanged: (PhoneNumber number) {
                        print(number.phoneNumber);
                      },
                      onInputValidated: (bool value) {
                        print(value);
                      },
                      selectorConfig: SelectorConfig(
                        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                        useBottomSheetSafeArea: true,
                      ),
                      ignoreBlank: false,
                      autoValidateMode: AutovalidateMode.disabled,
                      selectorTextStyle: TextStyle(color: Colors.black),
                      initialValue: number,
                      textFieldController: numberController,
                      formatInput: true,
                      keyboardType: TextInputType.numberWithOptions(
                          signed: true, decimal: true),
                      inputDecoration: InputDecoration(
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          hintText: "Mobile Number",
                          hintStyle: TextStyle(color: Colors.lightBlue)),
                      inputBorder:
                          OutlineInputBorder(borderSide: BorderSide.none),
                      onSaved: (PhoneNumber number) {
                        print('On Saved: $number');
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  getVerifiedUploadWidget(
                    step: 1,
                    label: "Photo ID",
                    sublabel: "Take a picture of any Valid Gov't ID",
                    isUploaded: true,
                    thisFunction: () {},
                  ),
                  SizedBox(height: 10),
                  getVerifiedUploadWidget(
                    step: 2,
                    label: "Selfie with ID",
                    sublabel: "Take a picture holding valid Gov's ID",
                    isUploaded: false,
                    thisFunction: () {},
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xffd4e5ee),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, left: 16),
                          child: Text(
                            "STEP 3",
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.blueGrey),
                          ),
                        ),
                        textfieldWidget(
                            label: "Account Number",
                            thisTextInputType: TextInputType.text,
                            thisController: accountNumberController),
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Text(
                            "Type the account number issued",
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.blueGrey,
                                fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  getVerifiedUploadWidget(
                    step: 4,
                    label: "DTI / Business Permit",
                    sublabel: "Take a picture holding valid Gov's ID",
                    isUploaded: false,
                    thisFunction: () {},
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Why is it needed?',
                    style: TextStyle(
                      color: Colors.blue,
                      fontStyle: FontStyle.italic,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Text(
                      'Switch Another Account',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: myColors.darkblue,
                          fontSize: 15),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  darkblueButton(
                      thisFunction: () {
                        myModals.showProcessing(context, "Uploading");
                        Timer(Duration(seconds: 3), () async {
                          Navigator.of(context).pop();
                          await ArtSweetAlert.show(
                                  context: context,
                                  artDialogArgs: ArtDialogArgs(
                                      type: ArtSweetAlertType.success,
                                      title: "SUCCESS",
                                      text:
                                          "Successfully Uploaded\nPlease wait for the email to log in.",
                                      confirmButtonText: "THANK YOU",
                                      confirmButtonColor: myColors.darkblue))
                              .then((value) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()),
                            );
                          });
                        });
                      },
                      label: "Let's Go"),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ))),
            ))
          ],
        ),
        haveappbar: false);
  }
}
