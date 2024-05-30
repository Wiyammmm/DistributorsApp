import 'package:flutter/material.dart';
import 'package:distributorsapp/components/color.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class ReceiptImage extends StatelessWidget {
  const ReceiptImage(
      {super.key,
      this.isFilipayAppActive = false,
      required this.thisName,
      required this.amount,
      required this.prevAmount,
      required this.newAmount,
      required this.refNum,
      required this.date,
      required this.isCashin});
  final bool isFilipayAppActive;
  final String thisName;
  final double amount;
  final String prevAmount;
  final String newAmount;
  final String refNum;
  final String date;
  final bool isCashin;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      decoration: BoxDecoration(color: myColors.ligtblue),
      child: Center(
        // key: containerKey,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Container(
                        height: 200,
                        // margin: EdgeInsets.only(top: 200),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 10,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ClipPath(
                      clipper: PointsClipper(),
                      child: Container(
                        height: 400,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          // boxShadow: [
                          //   BoxShadow(
                          //     color: Colors.grey.withOpacity(0.5),
                          //     spreadRadius: 10,
                          //     blurRadius: 7,
                          //     offset: Offset(0, 3),
                          //   ),
                          // ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 40),
                          child: Column(
                            children: [
                              Text(
                                '$thisName',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Divider(),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Previous Amount',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black
                                        // fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  Text(
                                    '${double.parse(prevAmount).toStringAsFixed(2)}',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black
                                        // fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'New Amount',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black
                                        // fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  Text(
                                    '${double.parse(newAmount).toStringAsFixed(2)}',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black
                                        // fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ],
                              ),
                              Divider(),
                              SizedBox(
                                height: 10,
                              ),
                              RichText(
                                text: TextSpan(
                                    text: 'Amount:',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black),
                                    children: [
                                      TextSpan(
                                          text: ' ${amount.toStringAsFixed(2)}',
                                          style: TextStyle(
                                              fontSize: 25,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold))
                                    ]),
                              ),
                              Divider(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Reference#:',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  Text(
                                    '$refNum',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                              Text(
                                '$date',
                                style: TextStyle(color: Colors.black),
                              ),
                              // Text(
                              //   'Amount Sent: $amount',
                              //   style: TextStyle(
                              //     fontSize: 25,
                              //     // fontWeight: FontWeight.bold,
                              //   ),
                              // ),
                              SizedBox(
                                height: 50,
                              ),

                              Image.asset(
                                "assets/receiptPoweredBy.png",
                                width: 130,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                child: isFilipayAppActive
                    ? Image.asset(
                        "assets/filipaylogobanner.png",
                        width: 100,
                      )
                    : Image.asset(
                        "assets/filipaycard.png",
                        width: 100,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
