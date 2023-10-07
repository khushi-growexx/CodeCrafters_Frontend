import 'package:codeathon_usecase_5/view/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  static const String name = "splash_screen";
  static const String path = "/";
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: navigateToHomeScreen(context),
      builder: (context, snapshot) {
        return const Scaffold(
          body: Center(
            child: Text(
              "CodeCrafters...",
              style: TextStyle(fontSize: 20),
            ),
          ),
        );
      },
    );
  }
  
  Future navigateToHomeScreen(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 3), () async {
      Router.neglect(
          context,
          () => context.goNamed(HomeScreen.name));
    });
  }
}
