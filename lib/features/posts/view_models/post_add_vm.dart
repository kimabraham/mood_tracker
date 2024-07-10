import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mood_tracker/features/posts/repositories/post_repo.dart';

class PostAddVm extends AsyncNotifier<void> {
  late final PostRepo _postRepo;

  @override
  FutureOr<void> build() {
    _postRepo = ref.read(postRepoProvider);
  }
}

final postAddProvider = AsyncNotifierProvider<PostAddVm, void>(
  () => PostAddVm(),
);
