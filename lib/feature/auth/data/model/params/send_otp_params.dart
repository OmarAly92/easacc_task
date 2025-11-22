import 'package:equatable/equatable.dart';

class SendOtpParams extends Equatable {
  final String email;

  const SendOtpParams({required this.email});

  Map<String, dynamic> toJson() {
    return {'email': email};
  }

  @override
  List<Object?> get props => [email];
}
