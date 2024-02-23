class MyValidators {
  bool validatePhoneNumber(String? value) {
    // Regular expression to match a phone number with optional country code
    // Example formats: +1234567890, 1234567890, (123) 456-7890, 123-456-7890, etc.
    // You can modify the regex pattern to match the specific format you require
    final RegExp phoneRegex = RegExp(
      r'^(\+\d{1,3}\s?)?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}$',
    );

    if (value == null || value.isEmpty) {
      return false;
    }

    if (!phoneRegex.hasMatch(value)) {
      return false;
    }

    return true; // Return null if the input is valid
  }
}
