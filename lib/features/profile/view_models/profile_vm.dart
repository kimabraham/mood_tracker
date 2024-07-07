import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mood_tracker/features/auth/repositories/auth_repo.dart';
import 'package:mood_tracker/features/profile/models/profile_model.dart';
import 'package:mood_tracker/features/profile/repositories/profile_repo.dart';

class ProfileVm extends AsyncNotifier<ProfileModel> {
  late final ProfileRepo _profileRepo;
  late final AuthRepo _authRepo;

  @override
  FutureOr<ProfileModel> build() async {
    _profileRepo = ref.read(profileRepoProvider);
    _authRepo = ref.read(authRepoProvider);

    if (_authRepo.isLoggedIn) {
      final profile = await _profileRepo.findProfile(_authRepo.user!.uid);
      if (profile != null) {
        return ProfileModel.fromJson(profile);
      }
    }

    return ProfileModel.empty();
  }

  Future<void> createProfile(
      UserCredential credential, String email, String name) async {
    state = const AsyncValue.loading();
    print('hello');
    final profile = ProfileModel(
      uid: credential.user!.uid,
      email: credential.user!.email ?? email,
      name: credential.user!.displayName ?? name,
      hasAvatar: false,
    );

    await _profileRepo.createProfile(profile);

    state = AsyncValue.data(profile);
  }
}

final profileProvider = AsyncNotifierProvider<ProfileVm, ProfileModel>(
  () => ProfileVm(),
);
