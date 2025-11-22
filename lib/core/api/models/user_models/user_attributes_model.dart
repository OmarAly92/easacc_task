import 'package:equatable/equatable.dart';

class UserAttributesModel extends Equatable {
  final String? name;
  final String? email;
  final String? phone;
  final String? gender;
  final String? photoUrl;
  final String? userType;
  final Object? otp;
  final String? createdAt;
  final String? updatedAt;

  const UserAttributesModel({
    this.name,
    this.email,
    this.phone,
    this.gender,
    this.photoUrl,
    this.userType,
    this.otp,
    this.createdAt,
    this.updatedAt,
  });

  factory UserAttributesModel.fromJson(Map<String, dynamic> json) {
    return UserAttributesModel(
      name: json['name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      gender: json['gender'] as String?,
      photoUrl: json['photo_url'] as String?,
      userType: json['user_Type'] as String?,
      otp: json['otp'],
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  @override
  List<Object?> get props => [
    name,
    email,
    phone,
    gender,
    photoUrl,
    userType,
    otp,
    createdAt,
    updatedAt,
  ];
}
