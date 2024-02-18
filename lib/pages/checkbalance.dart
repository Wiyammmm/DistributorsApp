import 'package:distributorsapp/components/color.dart';
import 'package:distributorsapp/components/template.dart';
import 'package:distributorsapp/pages/home.dart';
import 'package:flutter/material.dart';

class CheckBalancePage extends StatefulWidget {
  const CheckBalancePage({super.key});

  @override
  State<CheckBalancePage> createState() => _CheckBalancePageState();
}

class _CheckBalancePageState extends State<CheckBalancePage> {
  @override
  Widget build(BuildContext context) {
    return pageTemplate(
      haveappbar: true,
      thiswidget: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Container(
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: myColors.darkblue,
                        size: 40,
                      )),
                  Text(
                    'Check Balance',
                    style: TextStyle(
                        color: myColors.darkblue,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.headset_mic, color: Colors.grey))
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Tap Card to Check Balance or You may enter your\nSerial Number.',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Expanded(
                child: Container(
              width: double.infinity,
              decoration:
                  BoxDecoration(color: const Color.fromARGB(158, 0, 0, 0)),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.lightBlue, width: 3),
                          borderRadius: BorderRadius.circular(10)),
                      height: 60,
                      child: TextField(
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.transparent,
                            hintText: "Type your Serial Number",
                            hintStyle: TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none)),
                      ),
                    ),
                    SizedBox(height: 20),
                    Image.asset(
                      "assets/tapcard.png",
                      width: MediaQuery.of(context).size.width * 0.7,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Tap Your Card Here',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    )
                  ],
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
