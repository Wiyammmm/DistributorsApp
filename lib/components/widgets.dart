import 'package:distributorsapp/components/color.dart';
import 'package:distributorsapp/components/modals.dart';
import 'package:distributorsapp/pages/home.dart';
import 'package:distributorsapp/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:idle_detector_wrapper/idle_detector_wrapper.dart';

class homeWidget extends StatelessWidget {
  const homeWidget(
      {super.key,
      required this.imageName,
      required this.label,
      required this.thisfunction,
      required this.isAvailable});
  final String imageName;
  final String label;
  final void Function() thisfunction;
  final bool isAvailable;

  @override
  Widget build(BuildContext context) {
    MyModals myModals = MyModals();
    return GestureDetector(
      onTap: isAvailable
          ? thisfunction
          : () {
              myModals.notAvailableModal(context);
            },
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/$imageName",
                width: 100,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '$label',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              )
            ],
          ),
          if (!isAvailable)
            Container(
              height: 140,
              width: 130,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(110, 0, 0, 0),
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Not Available',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class IdleWidget extends StatelessWidget {
  const IdleWidget({super.key, required this.myWidget});
  final Widget myWidget;
  @override
  Widget build(BuildContext context) {
    return IdleDetector(
      idleTime: const Duration(minutes: 10),
      onIdle: () {
        print("wala ka ginagawa");
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.white,
              title: Center(
                  child: Text(
                'OOPS',
                style: TextStyle(
                    color: myColors.darkblue, fontWeight: FontWeight.bold),
              )),
              content: Text(
                'For your security, We automatically logged you out dueto inactivity. Please log in again.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Text(
                      'OK',
                      style: TextStyle(
                          color: myColors.darkblue,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ))
              ],
            );
          },
        );
      },
      child: myWidget,
    );
  }
}

class amountButtonWidget extends StatelessWidget {
  const amountButtonWidget(
      {super.key, required this.amount, required this.thisFunction});
  final int amount;
  final void Function() thisFunction;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: thisFunction,
        child: Container(
          height: 80,
          decoration: BoxDecoration(
              color: myColors.ligtblue, borderRadius: BorderRadius.circular(5)),
          child: Center(
              child: Text(
            '$amount',
            style: TextStyle(
                color: myColors.darkblue,
                fontSize: 30,
                fontWeight: FontWeight.bold),
          )),
        ),
      ),
    );
  }
}

class getVerifiedUploadWidget extends StatelessWidget {
  const getVerifiedUploadWidget(
      {super.key,
      required this.step,
      required this.label,
      required this.sublabel,
      required this.isUploaded,
      required this.thisFunction});

  final int step;
  final String label;
  final String sublabel;
  final bool isUploaded;
  final void Function() thisFunction;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Color(0xffd4e5ee), borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'STEP $step',
                    style: TextStyle(
                        fontStyle: FontStyle.italic, color: Colors.blueGrey),
                  ),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      '${label}',
                      style: TextStyle(
                        color: myColors.darkblue,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  Text(
                    "${sublabel}",
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.blueGrey,
                        fontSize: 12),
                  ),
                ],
              ),
            ),
            isUploaded
                ? Icon(
                    Icons.check_circle,
                    color: myColors.navyblue,
                    size: 40,
                  )
                : IconButton(
                    onPressed: thisFunction,
                    icon: Icon(
                      Icons.file_upload_outlined,
                      color: Colors.blueGrey,
                      size: 40,
                    ))
          ],
        ),
      ),
    );
  }
}

class appBardarkblueWidget extends StatelessWidget {
  const appBardarkblueWidget({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        color: myColors.darkblue,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => HomePage()),
                      // );
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      color: myColors.ligtblue,
                    )),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        '$title',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
              onPressed: () {},
              icon: Icon(Icons.help_outline, color: myColors.ligtblue))
        ],
      ),
    );
  }
}

class titleWidget extends StatelessWidget {
  const titleWidget({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 2,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Center(
        child: Text(
          "$title",
          style: TextStyle(
              color: myColors.darkblue,
              fontWeight: FontWeight.bold,
              fontSize: 20),
        ),
      ),
    );
  }
}
