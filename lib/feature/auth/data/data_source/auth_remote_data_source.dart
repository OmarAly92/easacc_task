import 'package:easacc_task/core/api/api_request_helpers/api_consumer.dart';
import 'package:easacc_task/core/api/api_request_helpers/end_points.dart';
import 'package:easacc_task/core/api/models/global_response.dart';
import 'package:easacc_task/feature/auth/data/model/login_model.dart';
import 'package:easacc_task/feature/auth/data/model/params/login_params.dart';
import 'package:easacc_task/feature/auth/data/model/params/reset_password_params.dart';
import 'package:easacc_task/feature/auth/data/model/params/send_otp_params.dart';
import 'package:easacc_task/feature/auth/data/model/params/verify_otp_params.dart';

abstract class AuthRemoteDataSource {
  Future<GlobalResponse<LoginResponseModel>> login(LoginParams params);

  Future<GlobalResponse> sendOtp(SendOtpParams params);

  Future<GlobalResponse> verifyOtp(VerifyOtpParams params);

  Future<GlobalResponse> resetPassword(ResetPasswordParams params);
}

class AuthRemoteDataSourceImp implements AuthRemoteDataSource {
  final ApiConsumer _apiConsumer;

  AuthRemoteDataSourceImp(this._apiConsumer);

  @override
  Future<GlobalResponse<LoginResponseModel>> login(LoginParams params) async {
    final response = await _apiConsumer.post(EndPoints.login, body: params.toJson());
    return GlobalResponse.fromJson(response.data, fromJsonT: LoginResponseModel.fromJson);
  }

  @override
  Future<GlobalResponse> sendOtp(SendOtpParams params) async {
    final response = await _apiConsumer.post(EndPoints.sendOtp, body: params.toJson());
    return GlobalResponse.fromJson(response.data);
  }

  @override
  Future<GlobalResponse> verifyOtp(VerifyOtpParams params) async {
    final response = await _apiConsumer.post(EndPoints.verifyOtp, body: params.toJson());
    return GlobalResponse.fromJson(response.data);
  }

  @override
  Future<GlobalResponse> resetPassword(ResetPasswordParams params) async {
    final response = await _apiConsumer.post(EndPoints.resetPassword, body: params.toJson());
    return GlobalResponse.fromJson(response.data);
  }
}
