import 'package:distributorsapp/components/buttons.dart';
import 'package:distributorsapp/components/color.dart';
import 'package:distributorsapp/components/template.dart';
import 'package:distributorsapp/components/widgets.dart';
import 'package:distributorsapp/pages/home.dart';
import 'package:distributorsapp/pages/messageus/messageusrequest.dart';
import 'package:flutter/material.dart';

class MessageUsPage extends StatefulWidget {
  const MessageUsPage({super.key});

  @override
  State<MessageUsPage> createState() => _MessageUsPageState();
}

class _MessageUsPageState extends State<MessageUsPage> {
  @override
  Widget build(BuildContext context) {
    return pageTemplate(
        thiswidget: Column(children: [
          appBardarkblueWidget(title: "Message Us"),
          titleWidget(title: "How may I help you?"),
          SizedBox(
            height: 20,
          ),
          Expanded(
              child: SizedBox(
            child: Column(
              children: [
                messageusButton(
                  label: "Suggestions",
                  thisFunction: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MessageUsRequestPage(
                                type: "suggestions",
                              )),
                    );
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                messageusButton(
                  label: "Complaint",
                  thisFunction: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MessageUsRequestPage(
                                type: "complaint",
                              )),
                    );
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                messageusButton(
                  label: "Tutorials",
                  thisFunction: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MessageUsRequestPage(
                                type: "tutorial",
                              )),
                    );
                  },
                ),
              ],
            ),
          )),
          Container(
            height: 100,
            decoration:
                BoxDecoration(color: Color.fromARGB(143, 255, 255, 255)),
            child: Center(
                child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    },
                    icon: Icon(
                      Icons.home_outlined,
                      color: myColors.darkblue,
                      size: 50,
                    ))),
          )
        ]),
        haveappbar: false);
  }
}
