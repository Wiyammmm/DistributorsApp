import 'package:distributorsapp/components/buttons.dart';
import 'package:distributorsapp/components/template.dart';
import 'package:distributorsapp/components/widgets.dart';
import 'package:flutter/material.dart';

class FAQsPage extends StatefulWidget {
  const FAQsPage({super.key});

  @override
  State<FAQsPage> createState() => _FAQsPageState();
}

class _FAQsPageState extends State<FAQsPage> {
  @override
  Widget build(BuildContext context) {
    return pageTemplate(
        thiswidget: Column(children: [
          appBardarkblueWidget(
            title: "Frequently Asked Questions         ",
            thisFunction: () {
              Navigator.of(context).pop();
            },
          ),
          titleWidget(title: "FAQs"),
          SizedBox(
            height: 20,
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  faqButton(
                    label: "What is Filipay",
                    thisFunction: () {},
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  faqButton(
                    label: "What is FILIPAY Card? What is FILIPAY App?",
                    thisFunction: () {},
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  faqButton(
                    label: "How to Load FILIPAY Card/App?",
                    thisFunction: () {},
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            'See more',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ))
                    ],
                  )
                ],
              )),
            ),
          ))
        ]),
        haveappbar: false);
  }
}
