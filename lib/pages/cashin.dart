import 'package:distributorsapp/backend/generator/generator.dart';
import 'package:distributorsapp/backend/get/getValueServices.dart';
import 'package:distributorsapp/backend/httprequest/httprequest.dart';
import 'package:distributorsapp/components/buttons.dart';
import 'package:distributorsapp/components/color.dart';
import 'package:distributorsapp/components/modals.dart';
import 'package:distributorsapp/components/template.dart';
import 'package:distributorsapp/components/widgets.dart';
import 'package:distributorsapp/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CashInPage extends StatefulWidget {
  const CashInPage({super.key});

  @override
  State<CashInPage> createState() => _CashInPageState();
}

class _CashInPageState extends State<CashInPage> {
  MyModals myModals = MyModals();
  GetValueServices getValueServices = GetValueServices();
  HttprequestService httprequestService = HttprequestService();
  GeneratorServices generatorServices = GeneratorServices();
  TextEditingController amountController = TextEditingController();
  final _myBox = Hive.box('myBox');
  Map<String, dynamic> userInfo = {};
  late InAppWebViewController inAppWebViewController;
  String urlLink = "";
  String amountToPass = "";
  bool isShowPayment = false;
  @override
  void initState() {
    userInfo = _myBox.get('userInfo');
    print('userInfo: $userInfo');
    super.initState();
  }

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return pageTemplate(
        thiswidget: Column(
          children: [
            appBardarkblueWidget(
                title: "CASH IN",
                thisFunction: () {
                  if (isShowPayment) {
                    setState(() {
                      isShowPayment = false;
                    });
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  }
                }),
            isShowPayment
                ? Expanded(
                    child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(137, 158, 158, 158)),
                        child: InAppWebView(
                          initialUrlRequest:
                              URLRequest(url: WebUri.uri(Uri.parse(urlLink))),
                          onWebViewCreated:
                              (InAppWebViewController controller) {
                            inAppWebViewController = controller;
                          },
                          onLoadStart:
                              (InAppWebViewController controller, Uri? url) {
                            String returnUrl = url.toString();
                            String baseSuccessSubstring =
                                "https://filipworks.com/success.html";
                            String baseCancelSubstring =
                                "https://filipworks.com/error.html";
                            if (url != null) {
                              if (returnUrl.contains(baseCancelSubstring)) {
                                setState(() {
                                  urlLink = '';
                                  isShowPayment = false;
                                  // Set urlLink to an empty string
                                });
                              }
                            }
                            if (url != null) {
                              if (returnUrl.contains(baseSuccessSubstring)) {
                                setState(() {
                                  isShowPayment = false;
                                  urlLink =
                                      ''; // Set urlLink to an empty string
                                });
                                myModals.successModal(context, "CASH IN",
                                    (value) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomePage()),
                                  );
                                });
                              }
                            }
                          },
                          onLoadStop:
                              (InAppWebViewController controller, Uri? url) {
                            // Web view finished loading
                            // setState(() {
                            //   webloading = false;
                            // });
                          },
                        )))
                : Expanded(
                    child: Padding(
                    padding: isShowPayment
                        ? const EdgeInsets.all(0)
                        : const EdgeInsets.all(16.0),
                    child: SizedBox(
                      child: SingleChildScrollView(
                          child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'TOP-UP FOR',
                                style: TextStyle(
                                    color: myColors.darkblue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              Image.asset(
                                "assets/filipaylogobanner.png",
                                width: 50,
                              )
                            ],
                          ),
                          Divider(
                            thickness: 2,
                          ),
                          Row(
                            children: [
                              Text(
                                'Enter Amount',
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: const Color.fromARGB(158, 0, 0, 0)),
                                textAlign: TextAlign.left,
                              ),
                            ],
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
                              onTapOutside: (value) {
                                FocusScope.of(context).unfocus();
                              },
                            ),
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
                          SizedBox(
                            height: 10,
                          ),
                          darkblueButton(
                              thisFunction: () async {
                                bool isValid = _validateAmount();
                                if (isValid) {
                                  myModals.showProcessing(
                                      context, "PROCESSING");

                                  Map<String, dynamic> sandBoxResponse =
                                      await httprequestService.sandBoxRequest({
                                    "customer": {
                                      "fname": "${userInfo['firstName']}",
                                      "lname": "${userInfo['lastName']}",
                                      "mname": "${userInfo['middleName']}",
                                      "email": "${userInfo['email']}",
                                      "mobile": "NA",
                                      "phone": "NA",
                                      "customer_id":
                                          "${generatorServices.generateUUID()}",
                                      "address": {
                                        "line1": "NA",
                                        "line2": "NA",
                                        "city": "NA",
                                        "province": "NA",
                                        "zip_code": "NA",
                                        "country": "Philippines"
                                      }
                                    },
                                    "reference_id":
                                        "${generatorServices.generateRandomString()}",
                                    "amount": {
                                      "cur": "PHP",
                                      "num": "$amountToPass"
                                    },
                                    "from": {"type": "BANK", "country": "PH"},
                                    "payment_channel": "_",
                                    "memo":
                                        "distributor-${userInfo['_id']}-${getValueServices.convertToCents(amountController.text)}",
                                    "destination_account_id":
                                        "1957a366-d46b-11ee-8de3-42010a88002a",
                                    "client": {
                                      "display_name": "Your Application Name",
                                      "logo_url":
                                          "https://example.com/logo.svg",
                                      "return_url":
                                          "https://filipworks.com/success.html",
                                      "fail_url":
                                          "https://filipworks.com/error.html",
                                      "deep_link": true,
                                      "short_redirect_uri": true,
                                      "language": "EN_LANGUAGE",
                                      "biometric_auth": false
                                    },
                                    "expiry_date_time": "2025-12-30T00:00:00Z"
                                  });
                                  if (sandBoxResponse
                                      .containsKey("redirect_uri")) {
                                    Navigator.of(context).pop();
                                    setState(() {
                                      isShowPayment = true;
                                      urlLink = sandBoxResponse['redirect_uri'];
                                    });
                                    print(
                                        "redirect url: ${sandBoxResponse['redirect_uri']}");
                                  } else {
                                    Navigator.of(context).pop();
                                    myModals.somethingWentWrongModal(context);
                                  }
                                }
                              },
                              label: "Next")
                        ],
                      )),
                    ),
                  ))
          ],
        ),
        haveappbar: false);
  }

  void _updateAmount(double thisamount) {
    setState(() {
      amountController.text = "${thisamount.toDouble().toStringAsFixed(2)}";
    });
  }

  bool _validateAmount() {
    try {
      double amount = double.parse(amountController.text);
      if (amount < 10) {
        myModals.invalidModal(context, "AMOUNT");
        return false;
      }
      setState(() {
        amountController.text = "${amount.toStringAsFixed(2)}";
        amountToPass = (amount * 100).toStringAsFixed(0);
        print('amountToPass: $amountToPass');
      });
      return true;
    } catch (e) {
      print(e);
      myModals.invalidModal(context, "AMOUNT");
      return false;
    }
  }
}
