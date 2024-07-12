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
  final List images;
  final int createdAt;
  final int updatedAt;

  PostModel({
    required this.id,
    required this.title,
    required this.description,
    required this.creator,
    required this.creatorUid,
    required this.emotion,
    this.images = const [],
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
      'emotion': emotion.toString().split('.').last,
      'images': '',
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
        emotion = Mood.anger,
        images = [],
        createdAt = 0,
        updatedAt = 0;

  PostModel copyWith({
    String? id,
    String? title,
    String? description,
    String? creator,
    String? creatorUid,
    Mood? emotion,
    List? images,
    int? createdAt,
    int? updatedAt,
  }) {
    return PostModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      creator: creator ?? this.creator,
      creatorUid: creatorUid ?? this.creatorUid,
      emotion: emotion ?? this.emotion,
      images: images ?? this.images,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
