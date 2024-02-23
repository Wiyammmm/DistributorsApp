import 'package:distributorsapp/components/color.dart';
import 'package:distributorsapp/components/template.dart';
import 'package:distributorsapp/components/widgets.dart';
import 'package:flutter/material.dart';

class PartneredSectorsPage extends StatefulWidget {
  const PartneredSectorsPage({super.key});

  @override
  State<PartneredSectorsPage> createState() => _PartneredSectorsPageState();
}

class _PartneredSectorsPageState extends State<PartneredSectorsPage> {
  @override
  Widget build(BuildContext context) {
    return pageTemplate(
        thiswidget: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            appBardarkblueWidget(title: "Partnered Sectors"),
            titleWidget(
              title: "FILIPAY'S Allied Partners",
            ),
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                  color: const Color.fromARGB(226, 255, 255, 255)),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: Column(
                          children: [
                            Image.asset("assets/pontransco.png",
                                width: 150, height: 150),
                            Text(
                              'PONTRANSCO',
                              style: TextStyle(color: Colors.blue),
                            )
                          ],
                        )),
                        Expanded(
                            child: Column(
                          children: [
                            Image.asset("assets/kapitbisig.png",
                                width: 150, height: 150),
                            Text(
                              'KAPIT BISIG',
                              style: TextStyle(color: Colors.blue),
                            )
                          ],
                        ))
                      ],
                    )
                  ],
                ),
              ),
            )),
            Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(190, 255, 255, 255)),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Visit '),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          'filipay.com.ph',
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(' to see full list of our partners')
                    ],
                  ),
                ))
          ],
        ),
        haveappbar: false);
  }
}
