import 'dart:typed_data';

import 'package:distributorsapp/backend/get/getValueServices.dart';
import 'package:distributorsapp/backend/httprequest/httprequest.dart';
import 'package:distributorsapp/components/color.dart';
import 'package:distributorsapp/components/loadReceiptImage.dart';
import 'package:distributorsapp/components/modals.dart';
import 'package:distributorsapp/components/receiptImage.dart';
import 'package:distributorsapp/components/template.dart';
import 'package:distributorsapp/components/widgets.dart';
import 'package:distributorsapp/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:intl/intl.dart';
import 'package:screenshot/screenshot.dart';

class TransactionHistoryPage extends StatefulWidget {
  const TransactionHistoryPage({super.key});

  @override
  State<TransactionHistoryPage> createState() => _TransactionHistoryPageState();
}

class _TransactionHistoryPageState extends State<TransactionHistoryPage> {
  HttprequestService httprequestService = HttprequestService();
  GetValueServices getValueServices = GetValueServices();

  final ScreenshotController _screenshotController = ScreenshotController();
  final GlobalKey _globalKey = GlobalKey();
  final _myBox = Hive.box('myBox');
  MyModals myModals = MyModals();
  bool isCashInTransaction = true;
  Map<String, dynamic> userInfo = {};
  var transactionList = [
    // {
    //   "_id": "2"
    //   "amount": 500,
    //   "transactionType": "cashin",
    //   "date": "2021-05-21 02:54 pm",
    //   "sn": "XXXXXX",
    // },
    // {
    //   "_id": "1",
    //   "amount": 150.50,
    //   "transactionType": "cashin",
    //   "date": "2021-05-21 02:54 pm",
    //   "sn": "XXXXXX",
    // },
    // {
    //   "_id": "1",
    //   "amount": 500,
    //   "transactionType": "load",
    //   "date": "2021-05-21 02:54 pm",
    //   "name": "Juan Dela Cruz",
    //   "loadType": "filipayapp",
    // },
    // {
    //   "_id": "1",
    //   "amount": 1000,
    //   "transactionType": "load",
    //   "date": "2021-05-21 02:54 pm",
    //   "name": "John Doe",
    //   "loadType": "card",
    // },
    // {
    //   "_id": "1",
    //   "amount": 1000,
    //   "transactionType": "load",
    //   "date": "2021-05-21 02:54 pm",
    //   "name": "John Doe",
    //   "loadType": "card",
    // }
  ];

  @override
  void initState() {
    _getTransactionHistory();
    // TODO: implement initState

    super.initState();
  }

  String convertToPhilippineTime(String utcTimestamp) {
    // Parse the provided timestamp
    DateTime utcTime = DateTime.parse(utcTimestamp);

    // Add 8 hours to convert from UTC to Philippine time
    DateTime philippineTime = utcTime.add(Duration(hours: 8));

    // Format the Philippine time to the desired format
    String formattedPhilippineTime =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(philippineTime);

    return formattedPhilippineTime;
  }

  Future<void> _getTransactionHistory() async {
    DateTime currentDate = DateTime.now();
    // Set state to trigger rebuild
    userInfo = _myBox.get('userInfo');
    final responseTransactionHistory =
        await httprequestService.getTransactionHistory("${userInfo['_id']}");
    if (mounted)
      setState(() {
        try {
          if (responseTransactionHistory['messages'][0]['code'].toString() ==
              "0") {
            transactionList = responseTransactionHistory['response'];
            transactionList.sort((a, b) => DateTime.parse(b['createdAt'])
                .compareTo(DateTime.parse(a['createdAt'])));

            print('transactionList: $transactionList');
          }
        } catch (e) {
          print('transactionList error:');
          print(e);
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return pageTemplate(
        thiswidget: Column(children: [
          appBardarkblueWidget(
              title: "Transaction History",
              thisFunction: () async {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              }),
          Stack(
            children: [
              // SizedBox(height: 500, child: LoadReceiptImage()),
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
                          isCashInTransaction = true;
                        });
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: isCashInTransaction
                                ? Colors.white
                                : Colors.grey),
                        child: Center(
                            child: Text(
                          'Cash In Transaction',
                          style: TextStyle(
                              color: isCashInTransaction
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
                          isCashInTransaction = false;
                        });
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: !isCashInTransaction
                                ? Colors.white
                                : Color(0xffe0e0e0)),
                        child: Center(
                            child: Text(
                          'Load Transaction',
                          style: TextStyle(
                              color: !isCashInTransaction
                                  ? Colors.lightBlue
                                  : Colors.blueGrey,
                              fontWeight: FontWeight.bold),
                        )),
                      ),
                    )),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: transactionList.length, // Number of items in the list
              itemBuilder: (BuildContext context, int index) {
                String thisType = "";
                if (isCashInTransaction) {
                  thisType = "cashin";
                } else {
                  thisType = "load";
                }
                // This function is called for each item in the list
                return transactionList[index]['transactionType'] == thisType
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    thisType == "cashin"
                                        ? Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 1,
                                                    color: Colors.grey),
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: Image.asset(
                                                "assets/cashin.png",
                                                width: 50,
                                              ),
                                            ),
                                          )
                                        : Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 1,
                                                    color: Colors.grey),
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: Image.asset(
                                                transactionList[index]
                                                            ['loadType'] ==
                                                        "filipayapp"
                                                    ? "assets/filipaylogobanner.png"
                                                    : "assets/filipaycard.png",
                                                width: 50,
                                              ),
                                            ),
                                          ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'PHP ${double.parse(transactionList[index]['snNewBalance'].toString()) - double.parse(transactionList[index]['snPreviousBalance'].toString())}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          '${getValueServices.convertToPhilippineTime(transactionList[index]['createdAt'].toString())}',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.blueGrey,
                                          ),
                                        ),
                                        Text(
                                          isCashInTransaction
                                              ? ''
                                              : '${transactionList[index]['sn']}',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.blueGrey),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                IconButton(
                                    onPressed: () async {
                                      myModals.showProcessing(
                                          context, "Downloading");
                                      print(
                                          'transactionList[index]: ${transactionList[index]}');
                                      _screenshotController
                                          .captureFromWidget(ReceiptImage(
                                        thisName:
                                            "${transactionList[index]['sn']}",
                                        prevAmount:
                                            "${transactionList[index]['snPreviousBalance']}",
                                        newAmount:
                                            "${transactionList[index]['snNewBalance']}",
                                        refNum:
                                            "${transactionList[index]['referenceNumber']}",
                                        date: getValueServices
                                            .convertToPhilippineTime(
                                                "${transactionList[index]['createdAt']}"),
                                        amount: double.parse(
                                                transactionList[index]
                                                        ['snNewBalance']
                                                    .toString()) -
                                            double.parse(transactionList[index]
                                                    ['snPreviousBalance']
                                                .toString()),
                                      ))
                                          .then((capturedImage) async {
                                        print('capturedImage: $capturedImage');
                                        final result =
                                            await ImageGallerySaver.saveImage(
                                                capturedImage.buffer
                                                    .asUint8List());
                                        if (result['isSuccess']) {
                                          Navigator.of(context).pop();
                                          myModals.successModal(
                                              context, "Saved Image", (value) {
                                            // Navigator.of(context).pop();
                                          });
                                        } else {
                                          Navigator.of(context).pop();
                                          myModals.errorModal(context,
                                              "Something went wrong, please try again");
                                        }

                                        print("imageFile result: $result");
                                      });
                                    },
                                    icon: Icon(
                                      Icons.download,
                                      color: Colors.lightBlue,
                                      size: 30,
                                    ))
                              ],
                            ),
                          ),
                        ),
                      )
                    : SizedBox();
              },
            ),
          ),
          Container(
            height: 60,
            decoration:
                BoxDecoration(color: Color.fromARGB(200, 255, 255, 255)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Generate Report',
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                ),
                Icon(
                  Icons.list_alt_rounded,
                  color: Colors.blue,
                )
              ],
            ),
          ),
        ]),
        haveappbar: false);
  }
}
