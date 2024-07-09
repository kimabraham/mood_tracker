import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mood_tracker/features/auth/repositories/auth_repo.dart';
import 'package:mood_tracker/features/profile/models/profile_model.dart';
import 'package:mood_tracker/features/profile/repositories/profile_repo.dart';

class ProfileVm extends AsyncNotifier<ProfileModel> {
  late final ProfileRepo _profileRepo;
  late final AuthRepo _authRepo;

  bool _isLoading = false;
  String _errorMessage = '';

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

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
    final profile = ProfileModel(
      uid: credential.user!.uid,
      email: credential.user!.email ?? email,
      name: credential.user!.displayName ?? name,
      hasAvatar: false,
      avatarUrl: '',
    );

    await _profileRepo.createProfile(profile);

    state = AsyncValue.data(profile);
  }

  Future<void> onAvatarUpload({required String avatarUrl}) async {
    state = AsyncValue.data(
      state.value!.copyWith(
        hasAvatar: true,
        avatarUrl: avatarUrl,
      ),
    );
  }

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    _isLoading = true;
    state = state;

    try {
      final currentUser = _authRepo.user;

      if (currentUser == null) {
        throw Exception('User not found');
      }

      final credential = EmailAuthProvider.credential(
        email: currentUser.email!,
        password: currentPassword,
      );

      await currentUser.reauthenticateWithCredential(credential);
      await currentUser.updatePassword(newPassword);
      _errorMessage = '';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        _errorMessage = 'Incorrect current password';
      } else {
        _errorMessage = e.message ?? 'An error occurred';
      }
    } catch (e) {
      _errorMessage = 'An error occurred while changing password';
    } finally {
      _isLoading = false;
      state = state;
    }
  }
}

final profileProvider = AsyncNotifierProvider<ProfileVm, ProfileModel>(
  () => ProfileVm(),
);
