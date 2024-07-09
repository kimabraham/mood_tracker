import 'dart:async';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mood_tracker/features/auth/repositories/auth_repo.dart';
import 'package:mood_tracker/features/profile/repositories/profile_repo.dart';
import 'package:mood_tracker/features/profile/view_models/profile_vm.dart';

class ProfileAvatarVm extends AsyncNotifier<void> {
  late final ProfileRepo _profileRepo;

  @override
  FutureOr<void> build() {
    _profileRepo = ref.read(profileRepoProvider);
  }

  Future<void> uploadAvatar(File file) async {
    state = const AsyncValue.loading();

    final fileName = ref.read(authRepoProvider).user!.uid;

    state = await AsyncValue.guard(() async {
      final downloadUrl = await _profileRepo.uploadAvatar(file, fileName);
      await _profileRepo.updateUser(fileName, {
        'avatarUrl': downloadUrl,
        'hasAvatar': true,
      });
      await ref
          .read(profileProvider.notifier)
          .onAvatarUpload(avatarUrl: downloadUrl);
    });
  }
}

final avatarProvider = AsyncNotifierProvider<ProfileAvatarVm, void>(
  () => ProfileAvatarVm(),
);
