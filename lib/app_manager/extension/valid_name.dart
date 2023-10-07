extension PasswordValidator on String {
  bool isValidName() {
    String pattern =
    '([A-Z][a-zA-Z])';
    return RegExp(pattern).hasMatch(this);
  }
}
