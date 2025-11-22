import 'package:equatable/equatable.dart';

class LoginParams extends Equatable {
  final String email;
  final String password;
  final String? fcmtoken;

  const LoginParams({required this.email, required this.password, this.fcmtoken});

  Map<String, dynamic> toJson() {
    return {'credential': email, 'password': password, 'fcm_token': fcmtoken};
  }

  @override
  List<Object?> get props => [email, password, fcmtoken];
}
