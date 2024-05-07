import 'dart:async';

import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:distributorsapp/backend/httprequest/httprequest.dart';
import 'package:distributorsapp/components/buttons.dart';
import 'package:distributorsapp/components/color.dart';
import 'package:distributorsapp/components/modals.dart';
import 'package:distributorsapp/components/template.dart';
import 'package:distributorsapp/pages/login.dart';
import 'package:distributorsapp/pages/register/registerUserProfile.dart';
import 'package:flutter/material.dart';

class RegisterUserTypePage extends StatefulWidget {
  const RegisterUserTypePage({super.key});

  @override
  State<RegisterUserTypePage> createState() => _RegisterUserTypePageState();
}

class _RegisterUserTypePageState extends State<RegisterUserTypePage> {
  bool isDistributor = true;
  MyModals myModals = MyModals();
  HttprequestService httprequestService = HttprequestService();
  TextEditingController referenceNumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return pageTemplate(
        thiswidget: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()),
                            );
                          },
                          icon: Icon(Icons.arrow_back_ios_new_rounded,
                              color: myColors.darkblue)),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Image.asset(
                          "assets/FILIPAYDistributorLogo2.png",
                          width: 120,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      )
                    ],
                  ),
                ),
                // Image.asset(
                //   "assets/FILIPAYDistributorLogo2.png",
                //   width: MediaQuery.of(context).size.width * 0.5,
                // ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      'Are you a..',
                      style: TextStyle(
                          color: myColors.darkblue,
                          fontWeight: FontWeight.bold,
                          fontSize: 30),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isDistributor = true;
                    });
                  },
                  child: SizedBox(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.white,
                                      Color.fromARGB(255, 90, 203, 255)
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.people_alt_outlined,
                                  color: myColors.darkblue,
                                  size: 70,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Distributor',
                              style: TextStyle(
                                  color: myColors.darkblue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ],
                        ),
                        Transform.scale(
                          scale: 1.5,
                          child: Radio(
                              value: true,
                              groupValue: isDistributor,
                              onChanged: (value) {
                                setState(() {
                                  isDistributor = value!;
                                });
                              }),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isDistributor = false;
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.white,
                                      Color.fromARGB(255, 90, 203, 255)
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.store_outlined,
                                  color: myColors.darkblue,
                                  size: 70,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Retailer',
                              style: TextStyle(
                                  color: myColors.darkblue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ],
                        ),
                        Transform.scale(
                          scale: 1.5,
                          child: Radio(
                              value: false,
                              groupValue: isDistributor,
                              onChanged: (value) {
                                setState(() {
                                  isDistributor = value!;
                                });
                              }),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                if (!isDistributor)
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Reference Number of Distributor',
                            style: TextStyle(color: myColors.darkblue),
                          ),
                          Container(
                            width: double.infinity,
                            height: 60,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    width: 2, color: myColors.darkblue)),
                            child: TextField(
                              controller: referenceNumberController,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                  hintText: "Reference Number",
                                  hintStyle: TextStyle(color: Colors.grey)),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                SizedBox(
                  height: 20,
                ),
                darkblueButton(
                    thisFunction: () async {
                      if (!isDistributor) {
                        if (referenceNumberController.text.trim() == "") {
                          myModals.missingFieldModal(
                              context, "reference number");
                          return;
                        }
                        myModals.showProcessing(context, "CHECKING");
                        final checkRefNum = await httprequestService
                            .checkRefNum(referenceNumberController.text.trim());

                        if (checkRefNum['messages'][0]['code'].toString() ==
                            "0") {
                          Navigator.of(context).pop();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterUserProfilePage(
                                      thisData: {
                                        "isDistributor": false,
                                        "refNumber":
                                            "${referenceNumberController.text.trim()}"
                                      },
                                    )),
                          );
                        } else {
                          Navigator.of(context).pop();
                          ArtSweetAlert.show(
                              context: context,
                              artDialogArgs: ArtDialogArgs(
                                  type: ArtSweetAlertType.danger,
                                  title: "Oops...",
                                  text:
                                      "This Reference Number is not existing."));
                        }
                        // Timer(Duration(seconds: 3), () {
                        //   Navigator.of(context).pop();
                        //   Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => RegisterUserProfilePage(
                        //               thisData: {
                        //                 "isDistributor": false,
                        //                 "refNumber":
                        //                     "${referenceNumberController.text.trim()}"
                        //               },
                        //             )),
                        //   );
                        // });
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterUserProfilePage(
                                    thisData: {"isDistributor": true},
                                  )),
                        );
                      }
                    },
                    label: "NEXT")
              ],
            ),
          ),
        ),
        haveappbar: false);
  }
}
