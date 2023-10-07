import 'package:codeathon_usecase_5/view/screens/add_record_screen.dart';
import 'package:codeathon_usecase_5/view/screens/generate_controller_code.dart';
import 'package:codeathon_usecase_5/view/screens/generate_db_schema_screen.dart';
import 'package:codeathon_usecase_5/view/screens/generate_unit_test_screen.dart';
import 'package:codeathon_usecase_5/view/screens/home_screen.dart';
import 'package:codeathon_usecase_5/view/screens/project_details_screen.dart';
import 'package:codeathon_usecase_5/view/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// define for transition animation
CustomTransitionPage buildPageWithDefaultTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(
      opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
      child: child,
    ),
  );
}

List<RouteBase> routes = [
  GoRoute(
    name: SplashScreen.name,
    path: SplashScreen.path,
    pageBuilder: (context, state) => buildPageWithDefaultTransition(
        context: context, state: state, child: const SplashScreen()),
  ),
  GoRoute(
      name: HomeScreen.name,
      path: HomeScreen.path,
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
          context: context, state: state, child: const HomeScreen())),
  GoRoute(
      name: AddRecordScreen.name,
      path: AddRecordScreen.path,
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
          context: context, state: state, child: const AddRecordScreen())),
  GoRoute(
      name: GenerateDbSchemaScreen.name,
      path: GenerateDbSchemaScreen.path,
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
          context: context,
          state: state,
          child: const GenerateDbSchemaScreen())),
  GoRoute(
      name: GenerateUnitTestScreen.name,
      path: GenerateUnitTestScreen.path,
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
          context: context,
          state: state,
          child: const GenerateUnitTestScreen())),
  GoRoute(
      name: GenerateControllerCodeScreen.name,
      path: GenerateControllerCodeScreen.path,
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
          context: context,
          state: state,
          child: const GenerateControllerCodeScreen())),
  GoRoute(
      name: ProjectDetailsScreen.name,
      path: ProjectDetailsScreen.path,
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
          context: context, state: state, child: ProjectDetailsScreen(
            projectId: state.pathParameters['projectId'],
          ))),
];
