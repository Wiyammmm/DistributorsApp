import 'dart:typed_data';

import 'package:distributorsapp/components/modals.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:screenshot/screenshot.dart';
import 'package:distributorsapp/components/color.dart';

// final GlobalKey containerKey = GlobalKey();
final ScreenshotController screenshotController = ScreenshotController();

class LoadReceiptImage extends StatefulWidget {
  const LoadReceiptImage(
      {super.key,
      this.isFilipayAppActive = false,
      this.thisName = "",
      this.amount = 0,
      this.prevAmount = "",
      this.newAmount = "",
      this.refNum = "",
      this.date = ""});
  final bool isFilipayAppActive;
  final String thisName;
  final double amount;
  final String prevAmount;
  final String newAmount;
  final String refNum;
  final String date;

  @override
  State<LoadReceiptImage> createState() => _LoadReceiptImageState();
}

class _LoadReceiptImageState extends State<LoadReceiptImage> {
  MyModals myModals = MyModals();
  @override
  void initState() {
    // TODO: implement initState
    // _saveImage();

    super.initState();
  }

  void _saveImage() async {
    Uint8List? imageBytes = await screenshotController.capture();

    // Save the image to the gallery
    if (imageBytes != null) {
      // await ImageGallerySaver.saveImage(imageBytes);
      final result =
          await ImageGallerySaver.saveImage(imageBytes.buffer.asUint8List());
      print("imageFile result: $result");
      if (result['isSuccess']) {
        myModals.successModal(context, "Saved Image", (value) {
          // Navigator.of(context).pop();
        });
      } else {
        myModals.errorModal(context, "Something went wrong, please try again");
      }
      // Show a snackbar indicating that the image has been saved
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //       content: Text('Image saved to gallery')),
      // );
    }
    print('imageFile: $imageBytes');
  }

  @override
  Widget build(BuildContext context) {
    // final ScreenshotController _screenshotController = ScreenshotController();
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.7,
          decoration: BoxDecoration(color: myColors.ligtblue),
          child: Screenshot(
            controller: screenshotController,
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
                                      '${widget.thisName}',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Divider(),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Previous Amount',
                                          style: TextStyle(
                                            fontSize: 15,
                                            // fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          '${double.parse(widget.prevAmount).toStringAsFixed(2)}',
                                          style: TextStyle(
                                            fontSize: 15,
                                            // fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'New Amount',
                                          style: TextStyle(
                                            fontSize: 15,
                                            // fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          '${double.parse(widget.newAmount).toStringAsFixed(2)}',
                                          style: TextStyle(
                                            fontSize: 15,
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
                                              fontSize: 20,
                                              color: Colors.black),
                                          children: [
                                            TextSpan(
                                                text:
                                                    ' ${widget.amount.toStringAsFixed(2)}',
                                                style: TextStyle(
                                                    fontSize: 25,
                                                    fontWeight:
                                                        FontWeight.bold))
                                          ]),
                                    ),
                                    Divider(),
                                    Text('asdasdasdd'),
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
                      child: widget.isFilipayAppActive
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
          ),
        ),
      ),
    );
  }
}
