import 'package:equatable/equatable.dart';

class VerifyOtpParams extends Equatable {
  final String? email;
  final String? otp;

  const VerifyOtpParams({this.email, this.otp});

  Map<String, dynamic> toJson() {
    return {'email': email, 'code': otp};
  }

  @override
  List<Object?> get props => [email, otp];
}
