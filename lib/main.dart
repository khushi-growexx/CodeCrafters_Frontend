import 'package:codeathon_usecase_5/app_manager/constant/app_constant.dart';
import 'package:codeathon_usecase_5/app_manager/service/navigation_service.dart';
import 'package:codeathon_usecase_5/go_router/error_screen.dart';
import 'package:codeathon_usecase_5/routes.dart';
import 'package:codeathon_usecase_5/viewmodel/common_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  await dotenv.load(fileName: ".env");
  runApp(ChangeNotifierProvider<CommonViewModel>(create: (_) => CommonViewModel(), child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      title: AppConstant.appNameString,
      builder: (context, widget) {
        return SafeArea(child: widget ?? Container());
      },
    );
  }
}

GoRouter router = GoRouter(
  routes: routes,
  navigatorKey: NavigationService.navigatorKey,
  errorBuilder: (context, state) => const ErrorScreen(),
);
