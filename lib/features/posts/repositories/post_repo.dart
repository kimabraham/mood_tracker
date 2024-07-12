import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mood_tracker/features/posts/models/post_model.dart';

class PostRepo {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<List<UploadTask>> uploadImageFiles(List images, String uid) async {
    List<UploadTask> uploadTasks = [];

    for (var image in images) {
      final fileRef = _storage.ref().child(
            '/images/$uid/${DateTime.now().millisecondsSinceEpoch.toString()}',
          );

      final uploadTask = fileRef.putFile(image);
      uploadTasks.add(uploadTask);
    }

    return uploadTasks;
  }

  Future<void> createPosts(PostModel post) async {
    print(post.toJson());
    await _db.collection('posts').add(post.toJson());
  }
}

final postRepoProvider = Provider(
  (ref) => PostRepo(),
);
