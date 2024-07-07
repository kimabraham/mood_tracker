import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mood_tracker/common/main_navigation/main_navigation_screen.dart';
import 'package:mood_tracker/features/auth/views/join_screen.dart';
import 'package:mood_tracker/features/auth/views/login_screen.dart';

final routerProvider = Provider(
  (ref) {
    return GoRouter(
      routes: [
        GoRoute(
          path: '/:tab(home|new|profile)',
          name: MainNavigationScreen.routeName,
          builder: (context, state) {
            final tab = state.pathParameters['tab']!;
            return MainNavigationScreen(tab: tab);
          },
        ),
        GoRoute(
          path: JoinScreen.routeUrl,
          name: JoinScreen.routeName,
          builder: (context, state) => const JoinScreen(),
        ),
        GoRoute(
          path: LoginScreen.routeUrl,
          name: LoginScreen.routeName,
          builder: (context, state) => const LoginScreen(),
        ),
      ],
    );
  },
);
