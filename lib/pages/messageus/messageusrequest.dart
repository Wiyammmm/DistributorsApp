import 'package:distributorsapp/components/buttons.dart';
import 'package:distributorsapp/components/color.dart';
import 'package:distributorsapp/components/template.dart';
import 'package:distributorsapp/components/widgets.dart';
import 'package:flutter/material.dart';

class MessageUsRequestPage extends StatefulWidget {
  const MessageUsRequestPage({super.key, required this.type});
  final String type;

  @override
  State<MessageUsRequestPage> createState() => _MessageUsRequestPageState();
}

class _MessageUsRequestPageState extends State<MessageUsRequestPage> {
  String title = "";
  String subtitle = "";
  @override
  void initState() {
    super.initState();

    if (widget.type == "suggestions") {
      title = "Give us your thougts";
      subtitle = "Share us your experience and how we can serve you better";
    }
    if (widget.type == "complaint") {
      title = "Help us improve our services.";
      subtitle = "Report any technical issues you experience here";
    }
    if (widget.type == "tutorial") {
      title = "Get familiarize in this app";
      subtitle =
          "Type your questions regarding how to use a feature in this app";
    }
  }

  @override
  Widget build(BuildContext context) {
    return pageTemplate(
        thiswidget: Column(children: [
          appBardarkblueWidget(title: "Message Us"),
          Container(
            height: 60,
            width: double.infinity,
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
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "$title",
                    style: TextStyle(
                        color: myColors.darkblue,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  Text(
                    '$subtitle',
                    style: TextStyle(fontSize: 8),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.5,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 2,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '${widget.type.toUpperCase()}',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                maxLines:
                                    null, // Set to null for unlimited lines or a specific number for a fixed number of lines
                                keyboardType: TextInputType.multiline,
                                decoration: InputDecoration(
                                  // labelText: 'Enter your message',
                                  hintText: 'Type your message here...',

                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: darkblueButton(thisFunction: () {}, label: "Send"),
                    )
                  ],
                ),
              ),
            ),
          ),
        ]),
        haveappbar: false);
  }
}
