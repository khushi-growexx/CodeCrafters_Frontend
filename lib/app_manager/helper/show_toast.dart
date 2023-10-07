import 'package:codeathon_usecase_5/app_manager/service/navigation_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void showToast(String msg) {
  try {
      var snackBar = SnackBar(
        content: Text(msg),
      );
      ScaffoldMessenger.of(NavigationService.context!).showSnackBar(snackBar);

  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }
}
