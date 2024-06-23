import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_test/src/app.dart';

class LoginWidget extends HookWidget {
  const LoginWidget({
    super.key,
    this.onLoginClick,
    this.isLoading = false,
    this.error,
  });

  final void Function({
    required String login,
    required String password,
  })? onLoginClick;

  final bool isLoading;
  final String? error;

  @override
  Widget build(BuildContext context) {
    final loginTextController = useTextEditingController();
    final passwordTextController = useTextEditingController();

    void onConfirButtonClick() => onLoginClick?.call(
          login: loginTextController.text,
          password: passwordTextController.text,
        );

    final headLine = Text(
      'Login',
      style: Theme.of(context).textTheme.headlineMedium,
    );

    final realError = error;
    final errorWidget = SizedBox(
      height: 18,
      child: AnimatedScale(
        scale: realError == null ? 0 : 1,
        duration: const Duration(milliseconds: 300),
        child: realError != null
            ? Text(
                realError,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                ),
              )
            : null,
      ),
    );

    final loginTextField = TextField(
      keyboardType: TextInputType.emailAddress,
      controller: loginTextController,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.email),
        enabled: !isLoading,
        labelText: 'Email',
      ),
    );

    final showPassowrd = useState(false);

    final passwordTextField = TextField(
      controller: passwordTextController,
      obscureText: !showPassowrd.value,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.lock),
          enabled: !isLoading,
          labelText: 'Password',
          suffixIcon: IconButton(
            icon: Icon(
              showPassowrd.value ? Icons.visibility_off : Icons.visibility,
            ),
            onPressed: () => showPassowrd.value = !showPassowrd.value,
          )),
    );

    final confirmButton = isLoading
        ? const CircularProgressIndicator()
        : OutlinedButton(
            onPressed: onConfirButtonClick,
            child: isLoading
                ? const CircularProgressIndicator()
                : const Align(child: Text('Login')),
          );

    final integratedAuth = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Image.asset(
            'assets/icon/google.png',
            width: 24,
            height: 24,
          ),
          onPressed: isLoading
              ? null
              : () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Isn\'t provided yet'),
                    ),
                  ),
        ),
        IconButton(
          icon: Image.asset(
            'assets/icon/github.png',
            width: 24,
            height: 24,
          ),
          onPressed: isLoading
              ? null
              : () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Isn\'t provided yet'),
                    ),
                  ),
        ),
        TextButton(
          onPressed: isLoading
              ? null
              : () => context.goNamed(Routes.signUpScreen.name),
          child: const Text('Create account'),
        ),
      ],
    );

    final forgotPasswor = Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: isLoading
            ? null
            : () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Isn\'t provided yet'),
                  ),
                ),
        child: const Text('Reset password'),
      ),
    );

    return Card(
      margin: const EdgeInsets.all(8),
      child: Container(
        padding: const EdgeInsets.all(20),
        width: 400,
        // height: 360,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            headLine,
            errorWidget,
            loginTextField,
            const SizedBox(height: 8),
            passwordTextField,
            const SizedBox(height: 8),
            integratedAuth,
            forgotPasswor,
            const SizedBox(height: 8),
            confirmButton,
          ],
        ),
      ),
    );
  }
}
