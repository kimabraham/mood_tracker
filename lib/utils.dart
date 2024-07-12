import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void showFirebaseErrorSnack(BuildContext context, Object? error) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        (error as FirebaseException).message ?? 'Error',
        style: const TextStyle(color: Colors.white),
      ),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 2),
    ),
  );
}

String formatTimeDifference(int timestamp) {
  final now = DateTime.now();
  final postTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
  final difference = now.difference(postTime);

  if (difference.inDays >= 2) {
    return '${difference.inDays} days ago';
  } else if (difference.inMinutes >= 1) {
    return '${difference.inMinutes} minutes ago';
  } else {
    return 'now';
  }
}
