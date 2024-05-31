import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:distributorsapp/backend/get/getValueServices.dart';
import 'package:distributorsapp/backend/httprequest/httprequest.dart';
import 'package:distributorsapp/backend/printer/connectToPrinter.dart';
import 'package:distributorsapp/components/color.dart';
import 'package:distributorsapp/components/notif_screen.dart';
import 'package:distributorsapp/components/template.dart';
import 'package:distributorsapp/main.dart';
import 'package:distributorsapp/pages/cashin.dart';
import 'package:distributorsapp/pages/checkbalance.dart';
import 'package:distributorsapp/pages/load.dart';
import 'package:distributorsapp/pages/transactionhistory.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../components/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  HttprequestService httprequestService = HttprequestService();
  PrinterController connectToPrinter = PrinterController();
  final _myBox = Hive.box('myBox');
  Map<String, dynamic> userInfo = {};

  @override
  void initState() {
    userInfo = _myBox.get('userInfo');
    _connectToPrinter();
    getUserInfo();

    // _firebaseMessaging.requestPermission(
    //     alert: true, announcement: true, badge: true, sound: true);
    // print('_firebaseMessaging: ${_firebaseMessaging.app}');
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   print('Got a message whilst in the foreground!');
    //   print('Message data: ${message.data}');

    //   if (message.notification != null) {
    //     print('Message also contained a notification: ${message.notification}');
    //   }

    //   navigatorKey.currentState?.push(MaterialPageRoute(
    //       builder: (context) => NotificationScreen(
    //             title: message.notification?.title ?? 'Notification',
    //             body: message.notification?.body ?? 'No message body',
    //           )));
    // });

    // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    //   print('Message clicked!');
    //   navigatorKey.currentState?.push(MaterialPageRoute(
    //       builder: (context) => NotificationScreen(
    //             title: message.notification?.title ?? 'Notification',
    //             body: message.notification?.body ?? 'No message body',
    //           )));
    // });
    super.initState();
  }

  void _connectToPrinter() async {
    try {
      final resultprinter = await connectToPrinter.connectToPrinter();

      if (resultprinter != null) {
        print('resultprinter: $resultprinter');
        if (resultprinter) {
        } else {
          ArtDialogResponse response = await ArtSweetAlert.show(
              context: context,
              artDialogArgs: ArtDialogArgs(
                  type: ArtSweetAlertType.danger,
                  title: "Can't connect to printer",
                  text: "Open Bluetooth to automatically connect"));
          print('response: $response');
          if (response.isTapConfirmButton) {
            // _connectToPrinter();
          }
        }
      } else {
        ArtDialogResponse response = await ArtSweetAlert.show(
            context: context,
            artDialogArgs: ArtDialogArgs(
                type: ArtSweetAlertType.danger,
                title: "Can't connect to printer",
                text: "Open Bluetooth to automatically connect"));
        print('else resultprinter: $resultprinter');
        print('response: $response');
        if (response.isTapConfirmButton) {
          // _connectToPrinter();
        }
      }
    } catch (e) {
      print(e);
    }
  }

  getUserInfo() async {
    final gettingUserInfo =
        await httprequestService.getUserInfo({"userId": "${userInfo['_id']}"});

    try {
      if (gettingUserInfo['messages'][0]['code'].toString() == "0") {
        setState(() {
          userInfo = gettingUserInfo['response']['userInfo'];
          _myBox.put('userInfo', userInfo);
        });
      } else {
        ArtSweetAlert.show(
            context: context,
            artDialogArgs: ArtDialogArgs(
                type: ArtSweetAlertType.danger,
                title: "Oops...",
                text: "SOMETHING WENT WRONG, PLEASE TRY AGAIN"));
      }
    } catch (e) {
      print(e);

      ArtSweetAlert.show(
          context: context,
          artDialogArgs: ArtDialogArgs(
              type: ArtSweetAlertType.danger,
              title: "Oops...",
              text: "SOMETHING WENT WRONG, PLEASE TRY AGAIN"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Return false to prevent back navigation
        return false;
      },
      child: RefreshIndicator(
        onRefresh: () async {
          getUserInfo();

          // Navigator.pushReplacement(
          //     context, MaterialPageRoute(builder: (context) => LoginPage()));
        },
        child: pageTemplate(
            haveappbar: true,
            thiswidget: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                          decoration: BoxDecoration(
                              color: Color(0xff112fa7),
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'BALANCE',
                                  style: TextStyle(
                                      color: Color(0xff01baef),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Divider(thickness: 3, color: Color(0xff4e93b9)),
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    '${double.parse(userInfo['balance'].toString()).toStringAsFixed(2)}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 50),
                                  ),
                                ),
                                Text(
                                  'PHP',
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                homeWidget(
                                  imageName: "cashin.png",
                                  label: "Cash In",
                                  isAvailable: true,
                                  thisfunction: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CashInPage()),
                                    );
                                  },
                                ),
                                homeWidget(
                                  imageName: "load.png",
                                  label: "Load",
                                  isAvailable: true,
                                  thisfunction: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoadPage()),
                                    );
                                    print('loadpage');
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                homeWidget(
                                  imageName: "transactionhistory.png",
                                  label: "Transaction History",
                                  isAvailable: true,
                                  thisfunction: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              TransactionHistoryPage()),
                                    );
                                    print('Transaction History');
                                  },
                                ),
                                homeWidget(
                                  imageName: "checkbalance.png",
                                  label: "Check Balance",
                                  isAvailable: true,
                                  thisfunction: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CheckBalancePage()),
                                    );
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
