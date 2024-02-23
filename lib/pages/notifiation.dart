import 'package:distributorsapp/components/color.dart';
import 'package:distributorsapp/components/template.dart';
import 'package:distributorsapp/components/widgets.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  bool isAllNotif = true;
  bool isAlertNotif = false;
  bool isEmailNotif = false;
  bool isTransactionMail = false;

  bool isShowFilter = false;

  List<Map<String, dynamic>> notificationList = [
    {
      "type": "alert",
      "message":
          "Your FILIPAY Distributor account was just logged into from another device. Please review.",
      "isRead": false
    },
    {
      "type": "email",
      "message":
          "Your FILIPAY Distributor password has been changed. Not you? Reset your password",
      "isRead": true
    },
    {
      "type": "email",
      "message":
          "Your saved mobile number has been changed. Not you? Reset your password.",
      "isRead": true
    },
    {
      "type": "transaction",
      "message":
          "[LOADING] 1,500 FILIPAY Credits have been loaded to XXXXXXXXXXX.",
      "isRead": true
    },
    {
      "type": "transaction",
      "message":
          "[RELOADING] 1,500 FILIPAY Credits have been loaded to your account.",
      "isRead": true
    },
  ];
  @override
  Widget build(BuildContext context) {
    return pageTemplate(
        thiswidget: Stack(
          children: [
            Column(
              children: [
                appBardarkblueWidget(title: "Notifications"),
                Container(
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'All Notifications',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isShowFilter = !isShowFilter;
                            });
                          },
                          child: Image.asset(
                            "assets/filter.png",
                            width: 30,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          setState(() {
                            notificationList.map((data) {
                              data['isRead'] = true;
                              return data;
                            }).toList();
                          });
                        },
                        child: Text(
                          'Mark All as Read',
                          style: TextStyle(
                              color: Colors.lightBlue,
                              fontWeight: FontWeight.bold),
                        ))
                  ],
                ),
                Expanded(
                    child: notificationList.isEmpty
                        ? Center(child: Text("NO DATA"))
                        : ListView.builder(
                            itemCount: notificationList.length,
                            itemBuilder: (BuildContext context, int index) {
                              String imageName = "";
                              String type = "all";
                              bool isRead =
                                  notificationList[index]['isRead'] ?? false;
                              if (notificationList[index]['type'] == "alert") {
                                imageName = "cellphone.png";
                              } else if (notificationList[index]['type'] ==
                                  "email") {
                                imageName = "danger.png";
                              } else if (notificationList[index]['type'] ==
                                  "transaction") {
                                imageName = "transaction.png";
                              }

                              if (isAlertNotif) {
                                type = "alert";
                              }
                              if (isAllNotif) {
                                type = "all";
                              }
                              if (isEmailNotif) {
                                type = "email";
                              }
                              if (isTransactionMail) {
                                type = "transaction";
                              }
                              if (type == "all") {
                                return Container(
                                  decoration: BoxDecoration(
                                      color: isRead
                                          ? const Color.fromARGB(
                                              185, 255, 255, 255)
                                          : Color.fromARGB(193, 5, 88, 143),
                                      border: Border(
                                          bottom: BorderSide(
                                              width: 1, color: Colors.grey))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          "assets/$imageName",
                                          width: 60,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${notificationList[index]['message']}',
                                                style: TextStyle(
                                                    color: isRead
                                                        ? Colors.black
                                                        : Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                'Aug 3, 2021 11:21 PM',
                                                style: TextStyle(
                                                    color: isRead
                                                        ? Colors.grey
                                                        : Colors.white,
                                                    fontSize: 12),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }
                              if (notificationList[index]['type'] == type) {
                                return imageName != ""
                                    ? (Container(
                                        decoration: BoxDecoration(
                                            color: isRead
                                                ? const Color.fromARGB(
                                                    185, 255, 255, 255)
                                                : Color.fromARGB(
                                                    193, 5, 88, 143),
                                            border: Border(
                                                bottom: BorderSide(
                                                    width: 1,
                                                    color: Colors.grey))),
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Row(
                                            children: [
                                              Image.asset(
                                                "assets/$imageName",
                                                width: 60,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      '${notificationList[index]['message']}',
                                                      style: TextStyle(
                                                          color: isRead
                                                              ? Colors.black
                                                              : Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      'Aug 3, 2021 11:21 PM',
                                                      style: TextStyle(
                                                          color: isRead
                                                              ? Colors.grey
                                                              : Colors.white,
                                                          fontSize: 12),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ))
                                    : SizedBox();
                              } else {
                                return SizedBox();
                              }
                            }))
              ],
            ),
            if (isShowFilter)
              Positioned(
                  top: MediaQuery.of(context).size.height * 0.14,
                  right: MediaQuery.of(context).size.width * 0.1,
                  child: Container(
                    height: 130,
                    width: 200,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isAllNotif = true;
                                isAlertNotif = false;
                                isEmailNotif = false;
                                isTransactionMail = false;
                              });
                            },
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                'All Notifications',
                                style: TextStyle(
                                    fontSize: isAllNotif ? 18 : 15,
                                    color: isAllNotif
                                        ? myColors.darkblue
                                        : Colors.grey.shade700,
                                    fontWeight: isAllNotif
                                        ? FontWeight.bold
                                        : FontWeight.normal),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isAllNotif = false;
                                isAlertNotif = true;
                                isEmailNotif = false;
                                isTransactionMail = false;
                              });
                            },
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                'Alert Notifications',
                                style: TextStyle(
                                    fontSize: isAlertNotif ? 18 : 15,
                                    color: isAlertNotif
                                        ? myColors.darkblue
                                        : Colors.grey.shade700,
                                    fontWeight: isAlertNotif
                                        ? FontWeight.bold
                                        : FontWeight.normal),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isAllNotif = false;
                                isAlertNotif = false;
                                isEmailNotif = true;
                                isTransactionMail = false;
                              });
                            },
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                'Email Notifications',
                                style: TextStyle(
                                    fontSize: isEmailNotif ? 18 : 15,
                                    color: isEmailNotif
                                        ? myColors.darkblue
                                        : Colors.grey.shade700,
                                    fontWeight: isEmailNotif
                                        ? FontWeight.bold
                                        : FontWeight.normal),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isAllNotif = false;
                                isAlertNotif = false;
                                isEmailNotif = false;
                                isTransactionMail = true;
                              });
                            },
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text('Transaction Mails',
                                  style: TextStyle(
                                      fontSize: isTransactionMail ? 18 : 15,
                                      color: isTransactionMail
                                          ? myColors.darkblue
                                          : Colors.grey.shade700,
                                      fontWeight: isTransactionMail
                                          ? FontWeight.bold
                                          : FontWeight.normal)),
                            ),
                          )
                        ],
                      ),
                    ),
                  ))
          ],
        ),
        haveappbar: false);
  }
}
