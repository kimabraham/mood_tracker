import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mood_tracker/features/auth/repositories/auth_repo.dart';
import 'package:mood_tracker/features/posts/posts_list_screen.dart';
import 'package:mood_tracker/features/profile/view_models/profile_vm.dart';
import 'package:mood_tracker/utils.dart';

class JoinVm extends AsyncNotifier<void> {
  late final AuthRepo _authRepo;

  @override
  FutureOr<void> build() {
    _authRepo = ref.read(authRepoProvider);
  }

  Future<void> join(BuildContext context) async {
    state = const AsyncValue.loading();

    final form = ref.read(joinFormProvider);
    final profile = ref.read(profileProvider.notifier);

    state = await AsyncValue.guard(
      () async {
        final userCredential = await _authRepo.join(
          form['email'],
          form['password'],
        );

        await profile.createProfile(
          userCredential,
          form['email'],
          form['name'],
        );
      },
    );

    if (state.hasError) {
      print(state.error.toString());
      showFirebaseErrorSnack(context, state.error);
    } else {
      context.go(PostsListScreen.routeUrl);
    }
  }
}

final joinProvider = AsyncNotifierProvider<JoinVm, void>(
  () => JoinVm(),
);

final joinFormProvider = StateProvider(
  (ref) => {},
);
