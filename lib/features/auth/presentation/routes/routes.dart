import 'package:flutter_template/features/auth/presentation/screens/login_screen.dart';
import 'package:go_router/go_router.dart';

final class AuthRoutes {
  static final routes = [
    GoRoute(
      path: '/login',
      builder: (context, state) {
        return const LoginScreen();
      },
    ),
  ];
}
