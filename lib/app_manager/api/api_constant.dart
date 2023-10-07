import 'package:codeathon_usecase_5/app_manager/constant/environment.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstant {
  static String baseUrl =
  kDebugMode?
  /// For Server
  dotenv.env[Environment.baseURL]??"":
  /// For localhost debugging
  defaultTargetPlatform == TargetPlatform.android?
  "http://10.0.2.2:3001/"
      :"http://localhost:3001/";
  static const Map cancelResponse = {
    'responseCode': 0,
    'message': 'Try Again...'
  };
}
