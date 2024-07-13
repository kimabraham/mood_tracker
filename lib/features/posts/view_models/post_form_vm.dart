import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mood_tracker/features/posts/models/post_model.dart';

class PostFormNotifier extends StateNotifier<PostModel> {
  PostFormNotifier() : super(PostModel.empty());

  int currentIndex = 0;

  void update({
    String? title,
    String? description,
    Mood? emotion,
    List<File>? images,
  }) {
    state = state.copyWith(
      title: title,
      description: description,
      emotion: emotion,
      images: images,
    );
  }

  void reset() {
    state = PostModel.empty();
    currentIndex = 0;
  }

  Future<void> onTapPhotoByCamera() async {
    final file = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 70,
      maxWidth: 500,
      maxHeight: 500,
    );

    if (file != null) {
      if (state.images.length < 3) {
        update(images: [...state.images, File(file.path)]);
      }
    }
  }

  Future<void> onTapPhotoByGallery() async {
    final restPhotoCount = 3 - state.images.length;

    if (restPhotoCount > 1) {
      final files = await ImagePicker().pickMultiImage(
        imageQuality: 70,
        maxWidth: 500,
        maxHeight: 500,
        limit: restPhotoCount,
      );
      if (files.isNotEmpty) {
        update(images: [
          ...state.images,
          ...files.map((xfile) => File(xfile.path))
        ]);
      }
    } else {
      final file = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
        maxWidth: 500,
        maxHeight: 500,
      );
      if (file != null) {
        update(images: [...state.images, File(file.path)]);
      }
    }
  }

  void onRemovePhoto(int index) {
    update(images: [...state.images]..removeAt(index));
  }
}

final postFormProvider =
    StateNotifierProvider<PostFormNotifier, PostModel>((ref) {
  return PostFormNotifier();
});
