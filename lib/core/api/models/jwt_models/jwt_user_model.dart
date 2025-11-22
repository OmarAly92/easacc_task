import 'package:equatable/equatable.dart';

class JwtUserModel extends Equatable {
  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? userType;
  final String? gender;
  final int? isActive;
  final String? photoUrl;
  final List<String>? roles;
  final List<String>? permissions;

  const JwtUserModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.userType,
    this.gender,
    this.isActive,
    this.photoUrl,
    this.roles,
    this.permissions,
  });

  factory JwtUserModel.fromJson(Map<String, dynamic> json) {
    return JwtUserModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      userType: json['userType'] as String?,
      gender: json['gender'] as String?,
      isActive: json['is_active'] as int?,
      photoUrl: json['photo_url'] as String?,
      roles: (json['roles'] as List?)?.map((e) => e.toString()).toList(),
      permissions: (json['permissions'] as List?)
          ?.map((e) => e.toString())
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'userType': userType,
      'gender': gender,
      'isActive': isActive,
      'photoUrl': photoUrl,
      'roles': roles,
      'permissions': permissions,
    };
  }

  @override
  List<Object?> get props => [
    id,
    name,
    email,
    phone,
    userType,
    gender,
    isActive,
    photoUrl,
    roles,
    permissions,
  ];
}
