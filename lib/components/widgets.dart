import 'package:flutter/material.dart';

class homeWidget extends StatelessWidget {
  const homeWidget(
      {super.key,
      required this.imageName,
      required this.label,
      required this.thisfunction});
  final String imageName;
  final String label;
  final void Function() thisfunction;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: thisfunction,
      child: Column(
        children: [
          Image.asset(
            "assets/$imageName",
            width: 100,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            '$label',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          )
        ],
      ),
    );
  }
}
