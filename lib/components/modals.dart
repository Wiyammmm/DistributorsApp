import 'dart:typed_data';

import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:distributorsapp/components/buttons.dart';
import 'package:distributorsapp/components/color.dart';

import 'package:distributorsapp/pages/login.dart';
import 'package:distributorsapp/pages/transactionhistory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:screenshot/screenshot.dart';

class MyModals {
  final GlobalKey<ScreenshotState> _screenshotKey =
      GlobalKey<ScreenshotState>();
  void currentBalanceModal(BuildContext context, String amount) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: Container(
            height: MediaQuery.of(context).size.height * 0.3,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'CURRENT BALANCE',
                      style: TextStyle(
                          color: myColors.darkblue,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                  Column(
                    children: [
                      Text('Your current FILIPAY CARD credit is'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              'PHP ',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          Text(
                            '$amount',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'CLOSE',
                        style: TextStyle(fontSize: 18),
                      ))
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void notAvailableModal(BuildContext context) {
    ArtSweetAlert.show(
        context: context,
        artDialogArgs: ArtDialogArgs(
            type: ArtSweetAlertType.info,
            title: "NOT AVAILABLE",
            text: "Sorry, this page is currently not available",
            confirmButtonText: "THANK YOU",
            confirmButtonColor: myColors.darkblue));
  }

  void somethingWentWrongModal(BuildContext context) {
    ArtSweetAlert.show(
        context: context,
        artDialogArgs: ArtDialogArgs(
            type: ArtSweetAlertType.info,
            title: "ERROR",
            text: "SOMETHING WENT WRONG, PLEASE TRY AGAIN LATER",
            confirmButtonText: "THANK YOU",
            confirmButtonColor: myColors.darkblue));
  }

  void errorModal(BuildContext context, String message) {
    ArtSweetAlert.show(
        context: context,
        artDialogArgs: ArtDialogArgs(
            type: ArtSweetAlertType.info,
            title: "ERROR",
            text: "${message.toUpperCase()}",
            confirmButtonText: "THANK YOU",
            confirmButtonColor: myColors.darkblue));
  }

  void confirmationLoadModal(
    BuildContext context,
    bool isFilipayAppActive,
    double amount,
    String phoneNumber,
    void Function() thisFunction,
  ) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: Container(
            height: MediaQuery.of(context).size.height * 0.55,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Buy Load for',
                              style: TextStyle(
                                  color: myColors.darkblue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ),
                          isFilipayAppActive
                              ? Image.asset(
                                  "assets/filipaylogobanner.png",
                                  width: 50,
                                )
                              : Image.asset(
                                  "assets/filipaycard.png",
                                  width: 50,
                                ),
                          Column(
                            children: [
                              Text('$phoneNumber'),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(
                                      'PHP ',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                  Text(
                                    '${amount.toDouble().toStringAsFixed(2)}',
                                    style: TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Opacity(
                                opacity: 0.5,
                                child: Text(
                                  'The amount shown above is going to be deducted  from your account. Click proceed if you wish to continue.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 12),
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              darkblueButton(
                                  thisFunction: thisFunction, label: "Proceed"),
                              SizedBox(
                                height: 10,
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'CLOSE',
                                    style: TextStyle(fontSize: 18),
                                  )),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void invalidModal(BuildContext context, String invalidString) {
    ArtSweetAlert.show(
        context: context,
        artDialogArgs: ArtDialogArgs(
            type: ArtSweetAlertType.warning,
            title: "INVALID",
            text: "Please input valid $invalidString",
            confirmButtonText: "THANK YOU",
            confirmButtonColor: myColors.darkblue));
  }

  void missingFieldModal(BuildContext context, String missingString) {
    ArtSweetAlert.show(
        context: context,
        artDialogArgs: ArtDialogArgs(
            type: ArtSweetAlertType.warning,
            title: "MISSING",
            text: "Please input $missingString",
            confirmButtonText: "THANK YOU",
            confirmButtonColor: myColors.darkblue));
  }

  void successModal(
      BuildContext context, String successString, Function thisFunction) {
    ArtSweetAlert.show(
            context: context,
            artDialogArgs: ArtDialogArgs(
                type: ArtSweetAlertType.success,
                title: "SUCCESS",
                text: "Successfully $successString",
                confirmButtonText: "THANK YOU",
                confirmButtonColor: myColors.darkblue))
        .then(thisFunction);
  }

  void showProcessing(BuildContext context, String label) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return PopScope(
            canPop: true,
            onPopInvoked: (didPop) {
              // logic
            },
            child: AlertDialog(
              contentPadding: EdgeInsets.zero,
              content: Container(
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$label',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: myColors.darkblue,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Image.asset(
                      'assets/loading.gif',
                      width: MediaQuery.of(context).size.width * 0.4,
                    ),
                    Text(
                      'Please wait...',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: myColors.darkblue,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  void tapCardModal(
    BuildContext context,
    String cardName,
    String imageName,
  ) {
    showDialog(
        context: context,
        // barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            content: Container(
              height: MediaQuery.of(context).size.height * 0.3,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$cardName',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: myColors.darkblue,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Image.asset(
                    'assets/$imageName',
                    width: MediaQuery.of(context).size.width * 0.4,
                  ),
                  Text(
                    'TAP YOUR CARD',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: myColors.darkblue, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void successLoadModal(
      BuildContext context,
      bool isFilipayAppActive,
      double amount,
      String previousAmount,
      String newAmount,
      String phoneNumber,
      String referenceNumber,
      String thisName,
      String date,
      void Function() thisFunction) {
    final ScreenshotController _screenshotController = ScreenshotController();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content:
              // Screenshot(
              // key: _screenshotKey,
              // controller: _screenshotController,
              // child:
              Stack(
            children: [
              Screenshot(
                controller: _screenshotController,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.7,
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
                                    height: MediaQuery.of(context).size.height *
                                        0.6,
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
                                            '${thisName}',
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
                                                  fontSize: 12,
                                                  // fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                '${double.parse(previousAmount).toStringAsFixed(2)}',
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
                                                  fontSize: 12,
                                                  // fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                '${double.parse(newAmount).toStringAsFixed(2)}',
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
                                                          ' ${amount.toStringAsFixed(2)}',
                                                      style: TextStyle(
                                                          fontSize: 25,
                                                          fontWeight:
                                                              FontWeight.bold))
                                                ]),
                                          ),
                                          Divider(),
                                          Text('$date'),
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
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.7,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Congratulations!',
                              style: TextStyle(
                                  color: myColors.darkblue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ),
                          isFilipayAppActive
                              ? Image.asset(
                                  "assets/filipaylogobanner.png",
                                  width: 100,
                                )
                              : Image.asset(
                                  "assets/filipaycard.png",
                                  width: 100,
                                ),
                          Column(
                            children: [
                              Text('$phoneNumber'),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(
                                      'PHP ',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                  Text(
                                    '${amount.toDouble().toStringAsFixed(2)}',
                                    style: TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Text('$thisName'),
                              Text('$date'),
                              Opacity(
                                opacity: 0.5,
                                child: Text(
                                  'The amount show above has been successfully loaded to $phoneNumber',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 12),
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  width: double.infinity,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          width: 1,
                                          color: Colors.grey.shade100)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  TransactionHistoryPage()),
                                        );
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Transaction History',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          TransactionHistoryPage()),
                                                );
                                              },
                                              icon: Icon(
                                                  Icons.chevron_right_sharp,
                                                  color: Colors.black))
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 5),
                              darkblueButton(
                                  thisFunction: thisFunction,
                                  label: "Back to Main Menu"),
                            ],
                          )
                        ],
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                            onPressed: () async {
                              Uint8List? imageBytes =
                                  await _screenshotController.capture();

                              // Save the image to the gallery
                              if (imageBytes != null) {
                                // await ImageGallerySaver.saveImage(imageBytes);
                                final result =
                                    await ImageGallerySaver.saveImage(
                                        imageBytes.buffer.asUint8List());
                                print("imageFile result: $result");
                                if (result['isSuccess']) {
                                  successModal(context, "Saved Image", (value) {
                                    // Navigator.of(context).pop();
                                  });
                                } else {
                                  errorModal(context,
                                      "Something went wrong, please try again");
                                }
                                // Show a snackbar indicating that the image has been saved
                                // ScaffoldMessenger.of(context).showSnackBar(
                                //   SnackBar(
                                //       content: Text('Image saved to gallery')),
                                // );
                              }
                              print('imageFile: $imageBytes');
                            },
                            icon: Icon(
                              Icons.download,
                              color: Colors.lightBlue,
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // ),
        );
      },
    );
  }

  void logout(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    String pwd = "";

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: IntrinsicHeight(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 1,
              // height: 500,
              child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 8.0,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Image(
                          image: AssetImage('assets/filipay-logo.png'),
                          width: 150,
                        ),
                        const Text("Enter password to logout",
                            style: TextStyle(
                              fontSize: 14.0,
                            )),
                        SizedBox(
                          width: double.infinity,
                          child: TextFormField(
                            validator: (value) {
                              pwd = value ?? '';

                              if (value!.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                // Perform login action
                                if (formKey.currentState!.validate()) {
                                  ArtSweetAlert.show(
                                    context: context,
                                    artDialogArgs: ArtDialogArgs(
                                      showCancelBtn: true,
                                      type: ArtSweetAlertType.info,
                                      confirmButtonText: "Logout",
                                      title: "Confirm Logout",
                                      text: "Are you sure you want to logout?",
                                      onConfirm: () {
                                        print(pwd);

                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const LoginPage()),
                                        );
                                      },
                                    ),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromRGBO(135, 189, 230, 1.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5.0, vertical: 15.0),
                                elevation: 5,
                                textStyle: const TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                              child: const Text(
                                'VERIFY',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
