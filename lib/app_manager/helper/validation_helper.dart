import 'package:codeathon_usecase_5/app_manager/extension/is_valid_email.dart';
import 'package:flutter/material.dart';

class ValidationHelper {
  static String requiredFieldText = "This is a mandatory field.";

  static String? passwordValidationSignIn(String? val) {
    if (val == null || val.trim().isEmpty) {
      return requiredFieldText;
    } else {
      return null;
    }
  }

  static String? emailValidation(String? val, {String? errorText}) {
    if (val == null || val.trim().isEmpty) {
      return requiredFieldText;
    } else if (!val.isValidEmail()) {
      return "Please enter a valid email";
    } else if (errorText != null) {
      return errorText;
    } else {
      return null;
    }
  }

  static String? requiredField(String? val,
      {String? errorText, FocusNode? focusNode}) {
    if (val == null || val.trim().isEmpty) {
      _requestFocus(focusNode);
      return requiredFieldText;
    } else if (errorText != null) {
      _requestFocus(focusNode);
      return errorText;
    } else {
      return null;
    }
  }

  static void _requestFocus(FocusNode? focusNode) {
    if (focusNode != null) {
      focusNode.requestFocus();
    }
  }
}
