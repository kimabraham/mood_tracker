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

  Future<void> searchPost(String term) async {
    if (term == '') {
      _list = await _fetchPosts(lastItemCreatedAt: null);
      state = AsyncValue.data(_list);
    } else {
      final result = await _postRepo.searchPost(_authRepo.user!.uid, term);
      final posts = result.docs.map(
        (doc) => PostModel.fromJson(
          json: doc.data(),
          postId: doc.id,
          uid: _authRepo.user!.uid,
        ),
      );

      _list = posts.toList();
      state = AsyncValue.data([..._list]);
    }
  }

  Future<void> addPost(PostModel newPost) async {
    _list.insert(0, newPost);
    state = AsyncValue.data([..._list]);
  }

  Future<void> removePost(String postId) async {
    await _postRepo.removePost(postId);
    final newList = _list.where((post) => post.id != postId).toList();
    _list = newList;

    if (_list.isNotEmpty) {
      await fetchOneMore(_authRepo.user!.uid);
    }

    state = AsyncValue.data([...newList]);
  }

  Future<void> fetchOneMore(String uid) async {
    final result = await _postRepo.fetchOneMore(
        lastItemCreatedAt: _list.last.createdAt, uid: uid);

    final post = result.docs
        .map(
          (doc) => PostModel.fromJson(
            json: doc.data(),
            postId: doc.id,
            uid: _authRepo.user!.uid,
          ),
        )
        .toList();

    state = AsyncValue.data([..._list, ...post]);
  }

  Future<void> fetchNextPage() async {
    final nextPage = await _fetchPosts(lastItemCreatedAt: _list.last.createdAt);
    state = AsyncValue.data([..._list, ...nextPage]);
  }
}

final postProvider = AsyncNotifierProvider<PostVm, List<PostModel>>(
  () => PostVm(),
);
