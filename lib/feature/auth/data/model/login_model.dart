import 'package:equatable/equatable.dart';
import 'package:easacc_task/core/api/models/user_models/user_model.dart';

class LoginResponseModel extends Equatable {
  final UserModel? user;
  final String? token;

  const LoginResponseModel({this.user, this.token});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
    user: json['user'] != null ? UserModel.fromJson(json['user'] as Map<String, dynamic>) : null,
    token: json['token'] as String?,
  );

  @override
  List<Object?> get props => [user, token];
}
