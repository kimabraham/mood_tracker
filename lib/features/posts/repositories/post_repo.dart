import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mood_tracker/features/posts/models/post_model.dart';

class PostRepo {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<List<UploadTask>> uploadImageFiles(
      List images, String uid, String postId) async {
    List<UploadTask> uploadTasks = [];

    for (var image in images) {
      final fileRef = _storage.ref().child(
            '/images/$uid/$postId/${DateTime.now().millisecondsSinceEpoch.toString()}',
          );

      final uploadTask = fileRef.putFile(image);
      uploadTasks.add(uploadTask);
    }

    return uploadTasks;
  }

  Future<String> createPost(PostModel post, String uid) async {
    final postRef = await _db.collection('posts').add(post.toJson());

    return postRef.id;
  }

  Future<void> updatePost(String postId, Map<String, dynamic> data) async {
    await _db.collection('posts').doc(postId).update(data);
  }

  Future<void> removePost(String postId) async {
    await _db.collection('posts').doc(postId).delete();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> fetchPosts(
      {int? lastItemCreatedAt, required String uid}) async {
    final query = _db
        .collection('users')
        .doc(uid)
        .collection('posts')
        .orderBy('createdAt', descending: true)
        .limit(5);

    if (lastItemCreatedAt == null) {
      return query.get();
    } else {
      return query.startAfter([lastItemCreatedAt]).get();
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>> fetchOneMore(
      {int? lastItemCreatedAt, required String uid}) async {
    return _db
        .collection('users')
        .doc(uid)
        .collection('posts')
        .orderBy('createdAt', descending: true)
        .limit(1)
        .startAfter([lastItemCreatedAt]).get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> searchPost(uid, term) async {
    return _db
        .collection('users')
        .doc(uid)
        .collection('posts')
        .where('title', isGreaterThanOrEqualTo: term)
        .where('title', isLessThanOrEqualTo: term + '\uf8ff')
        .orderBy('title')
        .orderBy('createdAt', descending: true)
        .get();
  }
}

final postRepoProvider = Provider(
  (ref) => PostRepo(),
);
