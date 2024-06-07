import 'package:semaphore/core/common/entities/user.dart';

class ProfileModel extends User {
  ProfileModel({
    required super.id,
    required super.email,
    required super.name,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> map) {
    return ProfileModel(
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      name: map['name'] ?? '',
    );
  }

  ProfileModel copyWith({
    String? id,
    String? email,
    String? name,
  }) {
    return ProfileModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
    );
  }
}
