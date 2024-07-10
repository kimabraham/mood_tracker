enum Mood {
  anger,
  sadness,
  fear,
  disgust,
  joy,
  shame,
  ennui,
  anxiety,
  envy,
}

class PostModel {
  final String id;
  final String title;
  final String description;
  final String creator;
  final String creatorUid;
  final Mood? emotion;
  final List<String> imageUrls;
  final int createdAt;
  final int updatedAt;

  PostModel({
    required this.id,
    required this.title,
    required this.description,
    required this.creator,
    required this.creatorUid,
    required this.emotion,
    this.imageUrls = const [],
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'creator': creator,
      'creatorUid': creatorUid,
      'emotion': emotion,
      'imageUrls': imageUrls,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  PostModel.empty()
      : id = '',
        title = '',
        description = '',
        creator = '',
        creatorUid = '',
        emotion = null,
        imageUrls = [],
        createdAt = 0,
        updatedAt = 0;
}
