import 'package:distributorsapp/components/color.dart';
import 'package:distributorsapp/components/template.dart';
import 'package:distributorsapp/pages/checkbalance.dart';
import 'package:flutter/material.dart';

import '../components/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Return false to prevent back navigation
        return false;
      },
      child: pageTemplate(
          haveappbar: true,
          thiswidget: SingleChildScrollView(
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
                                  '1000.00',
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
                                thisfunction: () {
                                  print('cashin page');
                                },
                              ),
                              homeWidget(
                                imageName: "load.png",
                                label: "Load",
                                thisfunction: () {
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
                                thisfunction: () {
                                  print('Transaction History');
                                },
                              ),
                              homeWidget(
                                imageName: "checkbalance.png",
                                label: "Check Balance",
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
    );
  }
}
