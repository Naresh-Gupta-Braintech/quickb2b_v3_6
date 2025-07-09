extension StringExtension on String {
  bool isQuantityValid() {
    var floatRegex = RegExp(r"^\d{1,4}[.]\d{1,2}$");
    var intRegex = RegExp(r"^\d{1,4}$");
    var afterPoingtDigitRegex = RegExp(r"^[.]\d{1,2}$");
    var beforePoingtDigitRegex = RegExp(r"^\d{1,4}[.]$");
    if (floatRegex.hasMatch(this) || intRegex.hasMatch(this) || afterPoingtDigitRegex.hasMatch(this) || beforePoingtDigitRegex.hasMatch(this)) {
      return true;
    }
    return false;
  }
}
