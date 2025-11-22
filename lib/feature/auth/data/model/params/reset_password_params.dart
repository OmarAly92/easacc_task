import 'package:equatable/equatable.dart';

class ResetPasswordParams extends Equatable {
  final String? email;
  final String? otp;
  final String? password;

  const ResetPasswordParams({this.email, this.otp, this.password});

  Map<String, dynamic> toJson() {
    return {'email': email, 'otp': otp, 'password': password};
  }

  @override
  List<Object?> get props => [email, otp, password];
}
