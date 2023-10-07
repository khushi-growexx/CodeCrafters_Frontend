import 'package:codeathon_usecase_5/app_manager/component/responsive/responsive.dart';
import 'package:flutter/material.dart';

class CustomBottomSheet {
  static dynamic open(BuildContext context, {required Widget child}) async {
    var data = await showModalBottomSheet(
      context: context,
      isDismissible: true,
      isScrollControlled: true,
      constraints: BoxConstraints(maxWidth: Responsive.smallScreenWidth),
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topRight: Radius.circular(10),
        topLeft: Radius.circular(10),
      )),
      builder: (context) => SingleChildScrollView(
        child: Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: child,
        ),
      ),
    );
    return data;
  }
}
