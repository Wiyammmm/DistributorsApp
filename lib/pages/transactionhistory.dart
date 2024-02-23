import 'package:distributorsapp/components/color.dart';
import 'package:distributorsapp/components/template.dart';
import 'package:distributorsapp/components/widgets.dart';
import 'package:distributorsapp/pages/home.dart';
import 'package:flutter/material.dart';

class TransactionHistoryPage extends StatefulWidget {
  const TransactionHistoryPage({super.key});

  @override
  State<TransactionHistoryPage> createState() => _TransactionHistoryPageState();
}

class _TransactionHistoryPageState extends State<TransactionHistoryPage> {
  bool isCashInTransaction = true;
  List<Map<String, dynamic>> transactionList = [
    {
      "_id": "2",
      "amount": 500,
      "transactionType": "cashin",
      "date": "2021-05-21 02:54 pm",
      "sNo": "XXXXXX",
    },
    {
      "_id": "1",
      "amount": 150.50,
      "transactionType": "cashin",
      "date": "2021-05-21 02:54 pm",
      "sNo": "XXXXXX",
    },
    {
      "_id": "1",
      "amount": 500,
      "transactionType": "load",
      "date": "2021-05-21 02:54 pm",
      "name": "Juan Dela Cruz",
      "loadType": "filipayapp",
    },
    {
      "_id": "1",
      "amount": 1000,
      "transactionType": "load",
      "date": "2021-05-21 02:54 pm",
      "name": "John Doe",
      "loadType": "card",
    },
    {
      "_id": "1",
      "amount": 1000,
      "transactionType": "load",
      "date": "2021-05-21 02:54 pm",
      "name": "John Doe",
      "loadType": "card",
    }
  ];
  @override
  Widget build(BuildContext context) {
    return pageTemplate(
        thiswidget: Column(children: [
          appBardarkblueWidget(title: "Transaction History"),
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
                        color:
                            isCashInTransaction ? Colors.white : Colors.grey),
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
                                                "assets/gcashlogo.png",
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
                                          'PHP ${double.parse(transactionList[index]['amount'].toString()).toStringAsFixed(2)}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          '${transactionList[index]['date']}',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.blueGrey),
                                        ),
                                        Text(
                                          isCashInTransaction
                                              ? '${transactionList[index]['sNo']}'
                                              : '${transactionList[index]['name']}',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.blueGrey),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                IconButton(
                                    onPressed: () {},
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
