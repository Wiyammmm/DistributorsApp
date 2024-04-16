import 'dart:math';

class GeneratorServices {
  String generateUUID() {
    const String chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    const int length = 32;
    final Random random = Random();
    String uuid = '';

    for (int i = 0; i < length; i++) {
      if (i == 8 || i == 13 || i == 18 || i == 23) {
        uuid += '-';
      } else {
        final int index = random.nextInt(chars.length);
        uuid += chars[index];
      }
    }

    return uuid;
  }

  String generateRandomDigits() {
    DateTime now = DateTime.now();
    String day = now.day.toString().padLeft(2, '0');
    String hour = now.hour.toString().padLeft(2, '0');
    String minute = now.minute.toString().padLeft(2, '0');
    String second = now.second.toString().padLeft(2, '0');
    String millisecond = now.millisecond.toString().padLeft(3, '0');

    // Concatenate the components and ensure the total length does not exceed 6 digits
    String uniqueId = '$day$hour$minute$second$millisecond'.substring(0, 6);
    return uniqueId;
  }

  String generateRandomString() {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final random = Random();
    return String.fromCharCodes(Iterable.generate(
        16, (_) => chars.codeUnitAt(random.nextInt(chars.length))));
  }
}
