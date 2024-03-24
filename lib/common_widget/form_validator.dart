// form_validation.dart
class FormValidator {
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name.';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email address.';
    }
    final emailRegExp = RegExp(
        r"[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?\.[a-zA-Z]{2,6}");
    if (!emailRegExp.hasMatch(value)) {
      return 'Please enter a valid email address.';
    }
    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      // Phone number is optional, so an empty value is considered valid
      return null;
    }
    final phoneRegExp =
        RegExp(r"^\(?([0-9]{3})\)?[-. ]?([0-9]{3})[-. ]?([0-9]{4})");
    if (!phoneRegExp.hasMatch(value)) {
      return 'Please enter a valid phone number (e.g., 123-456-7890).';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password.';
    }
    final passwordRegExp = RegExp(
        r"(?=^.{8,}$)(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[^\w\s])"); // Minimum 8 characters, 1 digit, 1 lowercase, 1 uppercase, 1 special character
    if (!passwordRegExp.hasMatch(value)) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }
}
