import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:distributorsapp/components/buttons.dart';
import 'package:distributorsapp/components/color.dart';
import 'package:distributorsapp/pages/login.dart';
import 'package:flutter/material.dart';

class MyModals {
  void currentBalanceModal(BuildContext context) {
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
                            '250.00',
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
            height: MediaQuery.of(context).size.height * 0.6,
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
                                fontSize: 40, fontWeight: FontWeight.bold),
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

  void successModal(BuildContext context, String successString) {
    ArtSweetAlert.show(
            context: context,
            artDialogArgs: ArtDialogArgs(
                type: ArtSweetAlertType.success,
                title: "SUCCESS",
                text: "Successfully $successString",
                confirmButtonText: "THANK YOU",
                confirmButtonColor: myColors.darkblue))
        .then((value) {});
  }

  void showProcessing(BuildContext context, String label) {
    showDialog(
        context: context,
        // barrierDismissible: false,
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

  void successLoadModal(BuildContext context, bool isFilipayAppActive,
      double amount, String phoneNumber, void Function() thisFunction) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: Container(
            height: MediaQuery.of(context).size.height * 0.6,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
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
                                    fontSize: 40, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
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
                                      width: 1, color: Colors.grey.shade100)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
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
                                        onPressed: () {},
                                        icon: Icon(Icons.chevron_right_sharp,
                                            color: Colors.black))
                                  ],
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
                        onPressed: () {},
                        icon: Icon(
                          Icons.download,
                          color: Colors.lightBlue,
                        )),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
