import 'package:distributorsapp/components/color.dart';
import 'package:flutter/material.dart';

class textformfieldWidget extends StatelessWidget {
  const textformfieldWidget(
      {super.key,
      required this.label,
      required this.thisTextInputType,
      required this.thisController});
  final String label;
  final TextInputType thisTextInputType;
  final TextEditingController thisController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        controller: thisController,
        keyboardType: thisTextInputType,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderSide: BorderSide.none),
          label: Text("${label.toUpperCase()}"),
          labelStyle:
              TextStyle(color: Colors.lightBlue, backgroundColor: Colors.white),
          hintText: "Enter ${label.toLowerCase()}",
          hintStyle: TextStyle(color: Colors.lightBlue),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your ${label.toLowerCase()}';
          }
          if (label == "Email Address") {
            RegExp emailRegExp =
                RegExp(r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$");
            if (!emailRegExp.hasMatch(value)) {
              return 'Please enter a valid email address';
            }
            return null;
          }
          return null;
        },
      ),
    );
  }
}

class textfieldWidget extends StatelessWidget {
  const textfieldWidget(
      {super.key,
      required this.label,
      required this.thisTextInputType,
      required this.thisController});
  final String label;
  final TextInputType thisTextInputType;
  final TextEditingController thisController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        color: Color(0xffd4e5ee),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        controller: thisController,
        keyboardType: thisTextInputType,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderSide: BorderSide.none),
          // label: Text("${label.toUpperCase()}"),
          // labelStyle: TextStyle(
          //     color: myColors.darkblue, backgroundColor: Color(0xffd4e5ee)),
          hintText: "${label.toLowerCase()}",
          hintStyle: TextStyle(color: myColors.darkblue),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your ${label.toLowerCase()}';
          }
          return null;
        },
      ),
    );
  }
}
