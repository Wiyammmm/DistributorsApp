import 'dart:math';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class GetValueServices {
  final _myBox = Hive.box('myBox');

  Future<double> getUserCurrentBalance() async {
    double balance = 0;
    try {
      final userInfo = _myBox.get('userInfo');
      balance = double.parse(userInfo['balance']);
      return balance;
    } catch (e) {
      print("getUserCurrentBalance error: $e");
      return balance;
    }
  }

  String getUserName() {
    String name = "";
    try {
      final userInfo = _myBox.get('userInfo');
      name = "${userInfo['firstName']} ${userInfo['lastName']}";
      return name;
    } catch (e) {
      print("getUserCurrentBalance error: $e");
      return name;
    }
  }

  String getUserEmail() {
    String name = "";
    try {
      final userInfo = _myBox.get('userInfo');
      name = "${userInfo['email']}";
      return name;
    } catch (e) {
      print("getUserCurrentBalance error: $e");
      return name;
    }
  }

  String convertToCents(String value) {
    double amount = double.parse(value);
    int cents = (amount * 100).toInt();
    return cents.toString();
  }

  String formatTimestamp(String timestamp) {
    DateTime dateTime = DateTime.parse(timestamp);
    return DateFormat.yMMMMd().add_jms().format(dateTime);
  }

  String convertToPhilippineTime(String utcTimestamp) {
    // Parse the provided timestamp
    DateTime utcTime = DateTime.parse(utcTimestamp);

    // Add 8 hours to convert from UTC to Philippine time
    DateTime philippineTime = utcTime.add(Duration(hours: 8, minutes: 0));
    print('philippineTime: $philippineTime');
    // Format the Philippine time to the desired format
    String formattedPhilippineTime =
        DateFormat('MMMM dd, yyyy hh:mm:ss a').format(philippineTime);

    return formattedPhilippineTime;
  }
}
