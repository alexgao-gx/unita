import 'package:flutter/material.dart';

/// 表单验证
class Validators {
  /// Validatorless.password(6, 20, 'password must have between 6 and 20 digits')
  static FormFieldValidator<String> password(int min, int max, String m) =>
      (v) {
        if (v?.isEmpty ?? true) return null;
        if ((v?.length ?? 0) < min) return m;
        if ((v?.length ?? 0) > max) return m;
        return null;
      };
  /// Check for at least one number
  static bool containsNumber(String? input) {
    final RegExp numberRegex = RegExp(r'\d');
    return numberRegex.hasMatch(input ?? '');
  }
  /// Check for at least one uppercase letter
  static bool containsUppercase(String? input) {
    final RegExp uppercaseRegex = RegExp(r'[A-Z]');
    return uppercaseRegex.hasMatch(input ?? '');
  }

  static bool isValidEmail(String? email) {
    // 定义正则表达式
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    // 返回是否匹配
    return emailRegex.hasMatch(email ?? '');
  }
  static bool containsSpecialCharacter(String? input) {
    // Regex pattern to match a wide range of special characters
    final RegExp specialCharRegex = RegExp(r'''[!@#\$%\^&\*\(\)_\+\-=\[\]\{\};:"',<>\.\?\/\\|`~]''');
    return specialCharRegex.hasMatch(input ?? '');
  }




  static int calculateAge(DateTime birthDate) {
    DateTime today = DateTime.now();
    int age = today.year - birthDate.year;

    // If the current date has not yet reached the birthdate this year, subtract one year from the age
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }

    return age;
  }

 static String maskBankCardNumber(String? cardNumber) {
   // Check if the input is null or empty
   if (cardNumber == null || cardNumber.isEmpty) {
     return '';
   }

   // If the card number is less than four digits, return the input directly
   if (cardNumber.length < 4) {
     return cardNumber;
   }

   // Extract the last four digits of the card number
   String lastFourDigits = cardNumber.substring(cardNumber.length - 4);

   // Return the masked card number format
   return "****$lastFourDigits";
  }

  // Extension method to remove trailing zeros from a double value
 static String removeTrailingZeros(String? string) {
    String valueAsString = string ?? '';
    // Check if the string contains a decimal point
    if (valueAsString.contains('.')) {
      // Remove trailing zeros using a regular expression
      valueAsString = valueAsString.replaceAll(RegExp(r'0*$'), '');

      // If the string ends with a decimal point (e.g., "1."), remove the decimal point
      valueAsString = valueAsString.replaceAll(RegExp(r'\.$'), '');
    }
    // Return the processed string without trailing zeros
    return valueAsString;
  }
}
