import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mood_tracker/features/auth/repositories/auth_repo.dart';
import 'package:mood_tracker/features/posts/views/posts_list_screen.dart';
import 'package:mood_tracker/utils.dart';

class LoginVm extends AsyncNotifier<void> {
  late final AuthRepo _authRepo;

  @override
  FutureOr<void> build() {
    _authRepo = ref.read(authRepoProvider);
  }

  Future<void> login(BuildContext context) async {
    state = const AsyncValue.loading();

    final form = ref.read(loginFormProvider);

    state = await AsyncValue.guard(
      () async => await _authRepo.login(form['email'], form['password']),
    );

    if (state.hasError) {
      showFirebaseErrorSnack(context, state.error);
    } else {
      context.go(PostsListScreen.routeUrl);
    }
  }
}

final loginProvider = AsyncNotifierProvider<LoginVm, void>(() => LoginVm());

final loginFormProvider = StateProvider(
  (ref) => {},
);
