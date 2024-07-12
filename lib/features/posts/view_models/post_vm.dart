import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mood_tracker/features/auth/repositories/auth_repo.dart';
import 'package:mood_tracker/features/posts/models/post_model.dart';
import 'package:mood_tracker/features/posts/repositories/post_repo.dart';

class PostVm extends AsyncNotifier<List<PostModel>> {
  late final PostRepo _postRepo;
  late final AuthRepo _authRepo;

  List<PostModel> _list = [];

  @override
  FutureOr<List<PostModel>> build() async {
    _postRepo = ref.read(postRepoProvider);
    _authRepo = ref.read(authRepoProvider);

    _list = await _fetchPosts(lastItemCreatedAt: null);

    return _list;
  }

  Future<List<PostModel>> _fetchPosts({int? lastItemCreatedAt}) async {
    final result = await _postRepo.fetchPosts(
      lastItemCreatedAt: lastItemCreatedAt,
      uid: _authRepo.user!.uid,
    );

    final posts = result.docs.map(
      (doc) => PostModel.fromJson(
        json: doc.data(),
        postId: doc.id,
        uid: _authRepo.user!.uid,
      ),
    );

    return posts.toList();
  }

  Future<void> addPost(PostModel newPost) async {
    _list.insert(0, newPost);
    state = AsyncValue.data([..._list]);
  }

  Future<void> fetchNextPage() async {
    final nextPage = await _fetchPosts(lastItemCreatedAt: _list.last.createdAt);
    state = AsyncValue.data([..._list, ...nextPage]);
  }
}

final postProvider = AsyncNotifierProvider<PostVm, List<PostModel>>(
  () => PostVm(),
);
