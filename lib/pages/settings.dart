import 'package:distributorsapp/components/buttons.dart';
import 'package:distributorsapp/components/color.dart';
import 'package:distributorsapp/components/template.dart';
import 'package:distributorsapp/components/widgets.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return pageTemplate(
        thiswidget: Column(
          children: [
            appBardarkblueWidget(title: "Profile Settings"),
            SizedBox(
              height: 10,
            ),
            Expanded(
                child: SizedBox(
              child: SingleChildScrollView(
                  child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      "assets/FILIPAYDistributorLogo2.png",
                      width: 120,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Verified Account',
                      style: TextStyle(
                          color: Colors.green, fontStyle: FontStyle.italic),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 110,
                      height: 110,
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Color(0xffaec7d5),
                                shape: BoxShape.circle,
                                border: Border.all(
                                    width: 5, color: Color(0xff273d4a)),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage("assets/person.png"))),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: myColors.darkblue,
                                  borderRadius: BorderRadius.circular(100)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.camera_alt_outlined,
                                    color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: myColors.ligtblue,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            settingsTextfield(
                              label: "Name",
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            settingsTextfield(
                              label: "Address",
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            settingsTextfield(
                              label: "Phone Number",
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            settingsTextfield(
                              label: "Business Permit",
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            settingsTextfield(
                              label: "E-mail Address",
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            settingsTextfield(
                              label: "Password",
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'Keep your information updated for fast transaction',
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    darkblueButton(thisFunction: () {}, label: "Save changes")
                  ],
                ),
              )),
            ))
          ],
        ),
        haveappbar: false);
  }
}

class settingsTextfield extends StatelessWidget {
  const settingsTextfield({super.key, required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            alignment: Alignment.centerLeft,
            width: MediaQuery.of(context).size.width * 0.3,
            child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  '$label',
                ))),
        Expanded(
            child: Container(
                height: 21,
                decoration: BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(width: 1, color: myColors.darkblue))),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(borderSide: BorderSide.none)),
                )))
      ],
    );
  }
}
