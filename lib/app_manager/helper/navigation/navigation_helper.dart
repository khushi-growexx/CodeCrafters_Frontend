



import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';

class NavigationHelper {


  // use this pushNamed it can manage your routing according to your platform
  static Future<T?> pushNamed<T extends Object?>(
      BuildContext context,
      String name, {
        Map<String, String> pathParameters = const <String, String>{},
        Map<String, dynamic> queryParameters = const <String, dynamic>{},
        Object? extra,
      }) async{
    if(defaultTargetPlatform == TargetPlatform.android || defaultTargetPlatform == TargetPlatform.iOS) {
      return await context.pushNamed(name,
        queryParameters: queryParameters,
        pathParameters: pathParameters,
        extra: extra,
      );
    } else{
      context.goNamed(name,
        queryParameters: queryParameters,
        pathParameters: pathParameters,
        extra: extra,
      );
      return Future(() => null);
    }
  }


}