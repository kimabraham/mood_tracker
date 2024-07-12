import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mood_tracker/features/auth/repositories/auth_repo.dart';
import 'package:mood_tracker/features/posts/repositories/post_repo.dart';
import 'package:mood_tracker/features/posts/view_models/post_form_vm.dart';
import 'package:mood_tracker/features/profile/view_models/profile_vm.dart';

class PostAddVm extends AsyncNotifier<void> {
  late final PostRepo _postRepo;

  @override
  FutureOr<void> build() {
    _postRepo = ref.read(postRepoProvider);
  }

  Future<void> createPost() async {
    print('done?');
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final user = ref.read(authRepoProvider).user;
      final userProfile = ref.read(profileProvider).value;
      final post = ref.read(postFormProvider);

      final task = await _postRepo.uploadImageFiles(
        post.images,
        user!.uid,
      );

      final List<String> imageUrls = await Future.wait(
        task.map((uploadTask) async {
          final snapshot = await uploadTask;
          return await snapshot.ref.getDownloadURL();
        }),
      );

      final newPost = post.copyWith(
        images: imageUrls,
        creator: userProfile!.name,
        creatorUid: user.uid,
        createdAt: DateTime.now().millisecondsSinceEpoch,
      );

      await _postRepo.createPosts(newPost);
    });
  }
}

final postAddProvider = AsyncNotifierProvider<PostAddVm, void>(
  () => PostAddVm(),
);
