import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

class SignUpWidget extends HookWidget {
  const SignUpWidget({
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
    final confirmPasswordTextController = useTextEditingController();

    void onConfirButtonClick() => onLoginClick?.call(
          login: loginTextController.text,
          password: passwordTextController.text,
        );

    final headLine = Row(
      children: [
        IconButton(
          onPressed: context.pop,
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
        Expanded(
          child: Align(
            child: Text(
              'Sign up',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
        ),
        const SizedBox(width: 36),
      ],
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

    final emailTextField = TextField(
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

    final confirmPasswordTextField = TextField(
      controller: confirmPasswordTextController,
      obscureText: !showPassowrd.value,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.confirmation_num),
          enabled: !isLoading,
          labelText: 'Confrim password',
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
                : const Align(child: Text('Register')),
          );

    return Card(
      margin: const EdgeInsets.all(8),
      child: Container(
        padding: const EdgeInsets.all(20),
        width: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            headLine,
            errorWidget,
            emailTextField,
            const SizedBox(height: 8),
            passwordTextField,
            const SizedBox(height: 8),
            confirmPasswordTextField,
            const SizedBox(height: 8),
            confirmButton,
          ],
        ),
      ),
    );
  }
}
