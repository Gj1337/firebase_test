import 'package:firebase_test/src/app.dart';
import 'package:firebase_test/src/feature/authorization/login_screen/change_notifier/login_notifier.dart';
import 'package:firebase_test/src/feature/authorization/login_screen/widget/login_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginNotifier(),
      child: Builder(
        builder: (context) {
          final loginNotifier = context.watch<LoginNotifier>();

          if (loginNotifier.userHasBeenLogined) {
            WidgetsBinding.instance.addPostFrameCallback(
                (_) => context.goNamed(Routes.mainScreen.name));
          }

          return Scaffold(
            body: Center(
                child: LoginWidget(
              onLoginClick: loginNotifier.onLoginClick,
              isLoading: loginNotifier.isLoading,
              error: loginNotifier.error,
            )),
          );
        },
      ),
    );
  }
}
