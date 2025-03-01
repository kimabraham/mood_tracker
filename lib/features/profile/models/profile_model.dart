class ProfileModel {
  final String uid;
  final String email;
  final String name;
  final bool hasAvatar;
  final String avatarUrl;

  ProfileModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.hasAvatar,
    required this.avatarUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'hasAvatar': hasAvatar,
      'avatarUrl': avatarUrl,
    };
  }

  ProfileModel.empty()
      : uid = '',
        email = '',
        name = '',
        hasAvatar = false,
        avatarUrl = 'false';

  ProfileModel.fromJson(Map<String, dynamic> json)
      : uid = json['uid'],
        email = json['email'],
        name = json['name'],
        hasAvatar = json['hasAvatar'],
        avatarUrl = json['avatarUrl'];

  ProfileModel copyWith({
    String? uid,
    String? email,
    String? name,
    bool? hasAvatar,
    String? avatarUrl,
  }) {
    return ProfileModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
      hasAvatar: hasAvatar ?? this.hasAvatar,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }
}
