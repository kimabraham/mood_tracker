import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mood_tracker/features/profile/models/profile_model.dart';

class ProfileRepo {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createProfile(ProfileModel profile) async {
    await _db.collection('users').doc(profile.uid).set(profile.toJson());
  }

  Future<Map<String, dynamic>?> findProfile(String uid) async {
    final doc = await _db.collection('users').doc(uid).get();
    return doc.data();
  }
}

final profileRepoProvider = Provider(
  (ref) => ProfileRepo(),
);
