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
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final user = ref.read(authRepoProvider).user!;
      final userProfile = ref.read(profileProvider).value;
      final post = ref.read(postFormProvider);
      final newPost = post.copyWith(
        creator: userProfile!.name,
        creatorUid: user.uid,
        createdAt: DateTime.now().millisecondsSinceEpoch,
      );
      final postId = await _postRepo.createPost(newPost, user.uid);
      final fileUrlTasks = await _postRepo.uploadImageFiles(
        post.images,
        user.uid,
        postId,
      );

      final List<String> imageUrls = await Future.wait(
        fileUrlTasks.map((uploadTask) async {
          final snapshot = await uploadTask;
          return await snapshot.ref.getDownloadURL();
        }),
      );

      await _postRepo.updatePost(postId, {'images': imageUrls});
    });
  }
}

final postAddProvider = AsyncNotifierProvider<PostAddVm, void>(
  () => PostAddVm(),
);
