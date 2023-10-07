import 'package:codeathon_usecase_5/gen/assets.gen.dart';
import 'package:codeathon_usecase_5/view/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  static const String name = "error";
  static const String path = "/$name";

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Assets.png.error.image(width: 333, height: 270),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text("The page you are looking for does not exist",
                      textAlign: TextAlign.center,
                      style: theme.textTheme.titleMedium),
                ),
                SizedBox(
                  width: 166,
                  child: TextButton(
                    onPressed: () {
                      context.goNamed(HomeScreen.name);
                    },
                    child: const Text("Return to home"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
