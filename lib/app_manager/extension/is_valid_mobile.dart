extension MobileValidator on String {
  bool isValidMobile() {
    return RegExp(
        r'^(\+\d{2})?\d{10}$')
        .hasMatch(this);
  }
}