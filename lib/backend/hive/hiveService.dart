import 'package:hive_flutter/hive_flutter.dart';

class HiveServices {
  final _myBox = Hive.box('myBox');

  Future<bool> isSaveUserInfo(Map<String, dynamic> item) async {
    try {
      _myBox.put('userInfo', item);
      final userinfo = _myBox.get('userInfo');
      print('userInfo: $userinfo');
      return true;
    } catch (e) {
      print('isSaveUserInfo error: $e');
      return false;
    }
  }
}
