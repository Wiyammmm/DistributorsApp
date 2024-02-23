import 'dart:async';

import 'package:distributorsapp/backend/validator.dart';
import 'package:distributorsapp/components/buttons.dart';
import 'package:distributorsapp/components/color.dart';
import 'package:distributorsapp/components/modals.dart';
import 'package:distributorsapp/components/template.dart';
import 'package:distributorsapp/components/widgets.dart';
import 'package:distributorsapp/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

class LoadPage extends StatefulWidget {
  const LoadPage({super.key});

  @override
  State<LoadPage> createState() => _LoadPageState();
}

class _LoadPageState extends State<LoadPage> {
  MyModals myModals = MyModals();
  MyValidators myValidators = MyValidators();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController numberController = TextEditingController();
  String initialCountry = 'PH';
  PhoneNumber number = PhoneNumber(isoCode: 'PH');
  bool isFilipayAppActive = true;
  TextEditingController amountController = TextEditingController();
  TextEditingController sNoController = TextEditingController();
  double amount = 0;
  @override
  Widget build(BuildContext context) {
    return pageTemplate(
        thiswidget: Column(
          children: [
            Container(
              height: 60,
              decoration: BoxDecoration(color: myColors.darkblue),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()),
                            );
                          },
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: 30,
                          )),
                      Text(
                        'Load',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                    ],
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.headset_mic, color: myColors.ligtblue))
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isFilipayAppActive = true;
                      });
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color:
                              isFilipayAppActive ? Colors.white : Colors.grey),
                      child: Center(
                          child: Text(
                        'FilipayApp',
                        style: TextStyle(
                            color: isFilipayAppActive
                                ? Colors.lightBlue
                                : Colors.blueGrey,
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                  )),
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isFilipayAppActive = false;
                      });
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: !isFilipayAppActive
                              ? Colors.white
                              : Color(0xffe0e0e0)),
                      child: Center(
                          child: Text(
                        'Filipay Card',
                        style: TextStyle(
                            color: !isFilipayAppActive
                                ? Colors.lightBlue
                                : Colors.blueGrey,
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                  )),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Expanded(
              child: Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // isFilipayAppActive
                      //     ?
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Buy Load for',
                                  style: TextStyle(
                                      color: myColors.darkblue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                isFilipayAppActive
                                    ? Image.asset(
                                        "assets/filipaylogobanner.png",
                                        width: 50,
                                      )
                                    : Image.asset(
                                        "assets/filipaycard.png",
                                        width: 50,
                                      )
                              ],
                            ),
                            isFilipayAppActive
                                ? Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          width: 2,
                                          color: Colors.lightBlue,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: InternationalPhoneNumberInput(
                                      onInputChanged: (PhoneNumber number) {
                                        print(number.phoneNumber);
                                      },
                                      onInputValidated: (bool value) {
                                        print(value);
                                      },
                                      selectorConfig: SelectorConfig(
                                        selectorType:
                                            PhoneInputSelectorType.BOTTOM_SHEET,
                                        useBottomSheetSafeArea: true,
                                      ),
                                      ignoreBlank: false,
                                      autoValidateMode:
                                          AutovalidateMode.disabled,
                                      selectorTextStyle:
                                          TextStyle(color: Colors.black),
                                      initialValue: number,
                                      textFieldController: numberController,
                                      formatInput: true,
                                      keyboardType:
                                          TextInputType.numberWithOptions(
                                              signed: true, decimal: true),
                                      inputDecoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide.none),
                                          suffixIcon: Icon(
                                              Icons
                                                  .perm_contact_calendar_outlined,
                                              color: Colors.blueAccent)),
                                      inputBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                      onSaved: (PhoneNumber number) {
                                        print('On Saved: $number');
                                      },
                                    ),
                                  )
                                : Container(
                                    width: double.infinity,
                                    height: 60,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            width: 2,
                                            color: myColors.darkblue)),
                                    child: TextField(
                                      controller: sNoController,
                                      style:
                                          TextStyle(color: myColors.darkblue),
                                      decoration: InputDecoration(
                                          hintText: "XXXXX",
                                          hintStyle: TextStyle(
                                            color: const Color.fromARGB(
                                                164, 3, 168, 244),
                                          ),
                                          filled: false,
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide.none)),
                                    ),
                                  ),
                            Row(
                              children: [
                                Text(
                                  isFilipayAppActive
                                      ? 'Insert mobile number'
                                      : 'Insert Account Number',
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      color:
                                          const Color.fromARGB(158, 0, 0, 0)),
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      amountButtonWidget(
                                        amount: 10,
                                        thisFunction: () {
                                          _updateAmount(10);
                                        },
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      amountButtonWidget(
                                        amount: 50,
                                        thisFunction: () {
                                          _updateAmount(50);
                                        },
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      amountButtonWidget(
                                        amount: 100,
                                        thisFunction: () {
                                          _updateAmount(100);
                                        },
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      amountButtonWidget(
                                        amount: 250,
                                        thisFunction: () {
                                          _updateAmount(250);
                                        },
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      amountButtonWidget(
                                        amount: 500,
                                        thisFunction: () {
                                          _updateAmount(500);
                                        },
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      amountButtonWidget(
                                        amount: 1000,
                                        thisFunction: () {
                                          _updateAmount(1000);
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              height: 60,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      width: 2, color: Colors.lightBlue)),
                              child: TextField(
                                controller: amountController,
                                decoration: InputDecoration(
                                    hintText: "Enter Amount",
                                    hintStyle: TextStyle(
                                      color: myColors.darkblue,
                                    ),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none)),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: myColors.darkblue,
                                    fontWeight: FontWeight.bold),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Opacity(
                                opacity: 0.7,
                                child: Text(
                                    'Choose from any denominations above.')),
                            SizedBox(
                              height: 10,
                            ),
                            darkblueButton(
                                thisFunction: () {
                                  double tempamount = 0;
                                  try {
                                    tempamount =
                                        double.parse(amountController.text);
                                  } catch (e) {
                                    print(e);
                                    myModals.invalidModal(context, "amount");
                                    return;
                                  }
                                  bool isproceed = false;
                                  if (isFilipayAppActive) {
                                    isproceed =
                                        myValidators.validatePhoneNumber(
                                            numberController.text);
                                  } else {
                                    isproceed = sNoController.text.trim() != "";
                                  }

                                  if (isproceed) {
                                    myModals.confirmationLoadModal(
                                        context,
                                        isFilipayAppActive,
                                        tempamount,
                                        isFilipayAppActive
                                            ? "0${numberController.text.replaceAll(RegExp('^0+|\\s+'), '')}"
                                            : "${sNoController.text}", () {
                                      Navigator.of(context).pop();
                                      myModals.showProcessing(
                                          context, "PROCESSING");
                                      Timer(Duration(seconds: 3), () {
                                        Navigator.of(context).pop();
                                        myModals.successLoadModal(
                                            context,
                                            isFilipayAppActive,
                                            tempamount,
                                            isFilipayAppActive
                                                ? "0${numberController.text.replaceAll(RegExp('^0+|\\s+'), '')}"
                                                : "${sNoController.text}", () {
                                          // Navigator.of(context).pop();
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LoadPage()),
                                          );
                                        });
                                      });
                                    });
                                    print(
                                        'phone number: ${numberController.text.replaceAll(RegExp('^0+|\\s+'), '')}');
                                  } else {
                                    myModals.invalidModal(
                                        context,
                                        isFilipayAppActive
                                            ? "phone number"
                                            : "account number");
                                  }
                                },
                                label: "Next")
                          ],
                        ),
                      )
                      // : Padding(
                      //     padding: const EdgeInsets.all(16.0),
                      //     child: Column(
                      //       children: [],
                      //     ),
                      //   )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        haveappbar: false);
  }

  void _updateAmount(double thisamount) {
    setState(() {
      amountController.text = "${thisamount.toDouble().toStringAsFixed(2)}";
    });
  }
}
