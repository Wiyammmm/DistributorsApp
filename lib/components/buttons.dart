import 'package:flutter/material.dart';

class darkblueButton extends StatelessWidget {
  const darkblueButton(
      {super.key, required this.thisFunction, required this.label});

  final void Function() thisFunction;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.blueAccent, // Background color
            // You can also customize other properties such as padding, shape, elevation, etc.
          ),
          onPressed: thisFunction,
          child: Text(
            '$label',
            style: TextStyle(color: Colors.white, fontSize: 20),
          )),
    );
  }
}

class messageusButton extends StatelessWidget {
  const messageusButton(
      {super.key, required this.label, required this.thisFunction});
  final String label;
  final void Function() thisFunction;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: thisFunction,
      child: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Center(
          child: Text(
            '$label',
            style: TextStyle(
                color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      ),
    );
  }
}

class faqButton extends StatelessWidget {
  const faqButton({super.key, required this.label, required this.thisFunction});
  final String label;
  final void Function() thisFunction;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: thisFunction,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text(
            "$label",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
