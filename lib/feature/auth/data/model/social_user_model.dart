import 'package:equatable/equatable.dart';

enum SocialProvider { google, facebook }

class SocialUserModel extends Equatable {
  const SocialUserModel({
    this.id,
    this.email,
    this.displayName,
    this.photoUrl,
    this.accessToken,
    required this.provider,
  });

  final String? id;
  final String? email;
  final String? displayName;
  final String? photoUrl;
  final String? accessToken;
  final SocialProvider provider;

  factory SocialUserModel.fromJson(Map<String, dynamic> json) {
    return SocialUserModel(
      id: json['id'] as String?,
      email: json['email'] as String?,
      displayName: json['display_name'] as String?,
      photoUrl: json['photo_url'] as String?,
      accessToken: json['access_token'] as String?,
      provider: SocialProvider.values.firstWhere(
        (e) => e.name == json['provider'],
        orElse: () => SocialProvider.google,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'display_name': displayName,
      'photo_url': photoUrl,
      'access_token': accessToken,
      'provider': provider.name,
    };
  }

  @override
  List<Object?> get props => [id, email, displayName, photoUrl, accessToken, provider];
}
