import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mood_tracker/features/posts/models/post_model.dart';
import 'package:mood_tracker/features/posts/repositories/post_repo.dart';
import 'package:mood_tracker/features/profile/repositories/profile_repo.dart';

class PostVm extends AsyncNotifier<List<PostModel>> {
  // late final PostRepo _postRepo;
  // late final ProfileRepo _profileRepo;
  final List<PostModel> _list = [];

  @override
  FutureOr<List<PostModel>> build() async {
    // _profileRepo = ref.read(profileRepoProvider);
    // _postRepo = ref.read(postRepoProvider);
    return _list;
  }
}

final postProvider = AsyncNotifierProvider<PostVm, List<PostModel>>(
  () => PostVm(),
);
