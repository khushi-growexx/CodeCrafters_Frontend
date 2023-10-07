
import 'package:flutter/cupertino.dart';

class AppConstant {

  static String appName = "app_name";
  static String appNameString = "CodeCrafters";
  static const String fontFamily = "Montserrat";
  static const Duration animationDuration = Duration(milliseconds: 300);
  static const EdgeInsets textFieldPadding = EdgeInsets.fromLTRB(12, 10, 12, 10);
  static String hiveDB = "todo_db";
  static LinearGradient getGradient(gradientColor){
    return  LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [
        gradientColor!.withOpacity(0.7),
        gradientColor!.withOpacity(0.8),
        gradientColor!,
        gradientColor!,

      ],
    );
  }

}