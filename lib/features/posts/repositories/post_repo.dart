import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mood_tracker/features/posts/models/post_model.dart';

class PostRepo {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createPosts(String uid, PostModel post) async {
    await _db.collection('posts').doc(uid).set(post.toJson());
  }
}

final postRepoProvider = Provider(
  (ref) => PostRepo(),
);
