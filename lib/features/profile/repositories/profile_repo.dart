import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mood_tracker/features/profile/models/profile_model.dart';

class ProfileRepo {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> createProfile(ProfileModel profile) async {
    await _db.collection('users').doc(profile.uid).set(profile.toJson());
  }

  Future<Map<String, dynamic>?> findProfile(String uid) async {
    final doc = await _db.collection('users').doc(uid).get();
    return doc.data();
  }

  Future<String> uploadAvatar(File file, String fileName) async {
    final fileRef = _storage.ref().child('avatars/$fileName');
    await fileRef.putFile(file);
    return await fileRef.getDownloadURL();
  }

  Future<void> updateUser(String uid, Map<String, dynamic> data) async {
    await _db.collection('users').doc(uid).update(data);
  }
}

final profileRepoProvider = Provider(
  (ref) => ProfileRepo(),
);
