part of 'app.dart';

typedef RouteInfo = ({String name, String path});

abstract final class Routes {
  static const RouteInfo mainScreen = (
    path: '/main',
    name: 'main',
  );

  static const RouteInfo loginScreen = (
    path: '/login',
    name: 'login',
  );

  static const RouteInfo signUpScreen = (
    path: 'sign_up',
    name: 'sign_up',
  );
}

final class _Route extends GoRoute {
  _Route(
    this.routeInfo, {
    super.builder,
    super.routes,
    super.pageBuilder,
  }) : super(
          path: routeInfo.path,
          name: routeInfo.name,
        );

  final RouteInfo routeInfo;
}

final _router = GoRouter(
  initialLocation: Routes.mainScreen.path,
  redirect: redirect,
  routes: [
    _Route(
      Routes.mainScreen,
      builder: (context, state) => const MainScreen(),
    ),
    _Route(Routes.loginScreen,
        builder: (context, state) => const LoginScreen(),
        routes: [
          _Route(
            Routes.signUpScreen,
            pageBuilder: (context, state) => CustomTransitionPage(
              transitionDuration: const Duration(seconds: 1),
              reverseTransitionDuration: const Duration(seconds: 1),
              child: const SignUpScreen(),
              transitionsBuilder: (
                BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child,
              ) =>
                  RotationTransition(
                turns: animation,
                child: FadeTransition(opacity: animation, child: child),
              ),
            ),
          ),
        ]),
  ],
);

FutureOr<String?> redirect(
  BuildContext context,
  GoRouterState state,
) {
  final userIsSignedOut = FirebaseAuth.instance.currentUser == null;

  final isAlredyOnLogin =
      state.matchedLocation.startsWith(Routes.loginScreen.path);

  if (userIsSignedOut && !isAlredyOnLogin) return Routes.loginScreen.path;

  if (!userIsSignedOut && isAlredyOnLogin) return Routes.mainScreen.path;

  return null;
}
