class ProfileModel {
  final String uid;
  final String email;
  final String name;
  final bool hasAvatar;

  ProfileModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.hasAvatar,
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'hasAvatar': hasAvatar,
    };
  }

  ProfileModel.empty()
      : uid = '',
        email = '',
        name = '',
        hasAvatar = false;

  ProfileModel.fromJson(Map<String, dynamic> json)
      : uid = json['uid'],
        email = json['email'],
        name = json['name'],
        hasAvatar = json['hasAvatar'];
}
