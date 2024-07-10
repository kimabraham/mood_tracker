import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mood_tracker/features/posts/models/post_model.dart';

class PostFormNotifier extends StateNotifier<PostModel> {
  PostFormNotifier() : super(PostModel.empty());

  void updateTitle(String title) {
    state = PostModel(
      id: state.id,
      title: title,
      description: state.description,
      creator: state.creator,
      creatorUid: state.creatorUid,
      emotion: state.emotion,
      imageUrls: state.imageUrls,
      createdAt: state.createdAt,
      updatedAt: state.updatedAt,
    );
  }

  void updateDescription(String description) {
    state = PostModel(
      id: state.id,
      title: state.title,
      description: description,
      creator: state.creator,
      creatorUid: state.creatorUid,
      emotion: state.emotion,
      imageUrls: state.imageUrls,
      createdAt: state.createdAt,
      updatedAt: state.updatedAt,
    );
  }

  void updateEmotion(Mood emotion) {
    state = PostModel(
      id: state.id,
      title: state.title,
      description: state.description,
      creator: state.creator,
      creatorUid: state.creatorUid,
      emotion: emotion,
      imageUrls: state.imageUrls,
      createdAt: state.createdAt,
      updatedAt: state.updatedAt,
    );
  }
}

final postFormProvider =
    StateNotifierProvider<PostFormNotifier, PostModel>((ref) {
  return PostFormNotifier();
});
