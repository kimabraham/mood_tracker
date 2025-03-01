import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mood_tracker/common/main_navigation/main_navigation_screen.dart';
import 'package:mood_tracker/features/auth/repositories/auth_repo.dart';
import 'package:mood_tracker/features/auth/views/join_screen.dart';
import 'package:mood_tracker/features/auth/views/login_screen.dart';
import 'package:mood_tracker/features/posts/views/posts_list_screen.dart';

final routerProvider = Provider(
  (ref) {
    return GoRouter(
      initialLocation: PostsListScreen.routeUrl,
      redirect: (context, state) {
        final isLoggedIn = ref.read(authRepoProvider).isLoggedIn;

        if (!isLoggedIn) {
          if (state.subloc != JoinScreen.routeUrl &&
              state.subloc != LoginScreen.routeUrl) {
            return LoginScreen.routeUrl;
          }
        }

        return null;
      },
      routes: [
        GoRoute(
          path: '/:tab(home|profile)',
          name: MainNavigationScreen.routeName,
          builder: (context, state) {
            final tab = state.params['tab']!;
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
