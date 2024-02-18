import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:distributorsapp/components/color.dart';
import 'package:distributorsapp/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:idle_detector_wrapper/idle_detector_wrapper.dart';

class pageTemplate extends StatelessWidget {
  const pageTemplate({
    super.key,
    required this.thiswidget,
    required this.haveappbar,
  });

  final Widget thiswidget;
  final bool haveappbar;

  @override
  Widget build(BuildContext context) {
    return haveappbar
        ? IdleDetector(
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
                          color: myColors.darkblue,
                          fontWeight: FontWeight.bold),
                    )),
                    content: Text(
                      'For your security, We automatically logged you out dueto inactivity. Please log in again.',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()),
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
            child: Scaffold(
              appBar: AppBar(
                iconTheme: IconThemeData(
                    color: myColors.darkblue,
                    size: 40 // Change the color of the menu icon
                    ),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.notifications,
                      color: myColors.darkblue,
                      size: 30,
                    ), // Notification icon
                    onPressed: () {
                      // Add your notification button onPressed callback here
                      // Typically, you would show a notification or open a notification screen
                      print('Notification button pressed');
                    },
                  ),
                ],
                title: Image.asset(
                  "assets/FILIPAYDistributorLogo2.png",
                  width: 100,
                ),
                centerTitle: true,
              ),
              drawer: Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    DrawerHeader(
                        decoration: BoxDecoration(
                          color: myColors.darkblue,
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                    color: Color(0xffaec7d5),
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                        width: 3, color: Colors.black)),
                                child: Icon(
                                  Icons.person,
                                  color: Colors.black,
                                  size: 60,
                                ),
                              ),
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  "Juan Dela Cruz",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30),
                                ),
                              ),
                              Opacity(
                                opacity: 0.8,
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    "juandelacruz@gmail.com",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          ListTile(
                            leading: Icon(
                              Icons.storefront_outlined,
                              color: myColors.darkblue,
                              size: 30,
                            ),
                            title: Text(
                              'Partnered Sectors',
                              style: TextStyle(fontSize: 18),
                            ),
                            onTap: () {
                              // Add your navigation logic here
                              // For example, you can navigate to the home screen
                              Navigator.pop(context); // Close the drawer
                            },
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.headset_mic_rounded,
                              color: myColors.darkblue,
                              size: 30,
                            ),
                            title: Text(
                              'Message Us',
                              style: TextStyle(fontSize: 18),
                            ),
                            onTap: () {
                              // Add your navigation logic here
                              // For example, you can navigate to the home screen
                              Navigator.pop(context); // Close the drawer
                            },
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.question_answer,
                              color: myColors.darkblue,
                              size: 30,
                            ),
                            title: Text(
                              'FAQs',
                              style: TextStyle(fontSize: 18),
                            ),
                            onTap: () {
                              // Add your navigation logic here
                              // For example, you can navigate to the home screen
                              Navigator.pop(context); // Close the drawer
                            },
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.help_outline_outlined,
                              color: myColors.darkblue,
                              size: 30,
                            ),
                            title: Text(
                              'Help',
                              style: TextStyle(fontSize: 18),
                            ),
                            onTap: () {
                              // Add your navigation logic here
                              // For example, you can navigate to the home screen
                              Navigator.pop(context); // Close the drawer
                            },
                          ),
                          Opacity(
                            opacity: 0.5,
                            child: Divider(
                              color: myColors.darkblue,
                              thickness: 2,
                            ),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: Opacity(
                                  opacity: 0.5,
                                  child: Text(
                                    'Settings and Privacy',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.settings,
                              color: myColors.darkblue,
                              size: 30,
                            ),
                            title: Text(
                              'Settings',
                              style: TextStyle(fontSize: 18),
                            ),
                            onTap: () {
                              // Add your navigation logic here
                              // For example, you can navigate to the home screen
                              Navigator.pop(context); // Close the drawer
                            },
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.policy_outlined,
                              color: myColors.darkblue,
                              size: 30,
                            ),
                            title: Text(
                              'Privacy Policy',
                              style: TextStyle(fontSize: 18),
                            ),
                            onTap: () {
                              // Add your navigation logic here
                              // For example, you can navigate to the home screen
                              Navigator.pop(context); // Close the drawer
                            },
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.description_rounded,
                              color: myColors.darkblue,
                              size: 30,
                            ),
                            title: Text(
                              'Terms & Condition',
                              style: TextStyle(fontSize: 18),
                            ),
                            onTap: () {
                              // Add your navigation logic here
                              // For example, you can navigate to the home screen
                              Navigator.pop(context); // Close the drawer
                            },
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.logout,
                              color: myColors.darkblue,
                              size: 30,
                            ),
                            title: Text(
                              'Sign Out',
                              style: TextStyle(fontSize: 18),
                            ),
                            onTap: () async {
                              ArtDialogResponse response =
                                  await ArtSweetAlert.show(
                                      barrierDismissible: false,
                                      context: context,
                                      artDialogArgs: ArtDialogArgs(
                                          denyButtonText: "NO",
                                          title: "SIGN OUT",
                                          text:
                                              "Are you sure you want to logout?",
                                          confirmButtonText: "Yes",
                                          type: ArtSweetAlertType.question));

                              if (response == null) {
                                return;
                              }

                              if (response.isTapConfirmButton) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()),
                                );
                                return;
                              }

                              // Add your navigation logic here
                              // For example, you can navigate to the home screen
                              Navigator.pop(context); // Close the drawer
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              body: SafeArea(
                child: Container(
                    decoration: BoxDecoration(color: Color(0xfff2f2f2)),
                    height: MediaQuery.of(context).size.height,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Opacity(
                            opacity: 0.5,
                            child: Image.asset(
                              "assets/citybg.png",
                            ),
                          ),
                        ),
                        thiswidget
                      ],
                    )),
              ),
            ),
          )
        : Scaffold(
            body: SafeArea(
              child: Container(
                  decoration: BoxDecoration(color: Color(0xfff2f2f2)),
                  height: MediaQuery.of(context).size.height,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Opacity(
                          opacity: 0.5,
                          child: Image.asset(
                            "assets/citybg.png",
                          ),
                        ),
                      ),
                      thiswidget
                    ],
                  )),
            ),
          );
  }
}
