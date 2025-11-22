import 'package:easacc_task/core/api/models/global_response.dart';
import 'package:easacc_task/core/error_handling/failures/failure.dart';
import 'package:easacc_task/core/helpers/network/network_status.dart';
import 'package:easacc_task/core/helpers/result/result.dart';
import 'package:easacc_task/feature/auth/data/data_source/auth_remote_data_source.dart';
import 'package:easacc_task/feature/auth/data/data_source/firebase_auth_data_source.dart';
import 'package:easacc_task/feature/auth/data/model/login_model.dart';
import 'package:easacc_task/feature/auth/data/model/params/login_params.dart';
import 'package:easacc_task/feature/auth/data/model/params/reset_password_params.dart';
import 'package:easacc_task/feature/auth/data/model/params/send_otp_params.dart';
import 'package:easacc_task/feature/auth/data/model/params/verify_otp_params.dart';
import 'package:easacc_task/feature/auth/data/model/social_user_model.dart';

abstract class AuthRepository {
  FutureResult<GlobalResponse<LoginResponseModel>> login(LoginParams params);

  FutureResult<GlobalResponse> sendOtp(SendOtpParams params);

  FutureResult<GlobalResponse> verifyOtp(VerifyOtpParams params);

  FutureResult<GlobalResponse> resetPassword(ResetPasswordParams params);

  FutureResult<SocialUserModel> signInWithGoogle();

  FutureResult<SocialUserModel> signInWithFacebook();

  Future<void> signOut();
}

class AuthRepositoryImp implements AuthRepository {
  AuthRepositoryImp(this._remoteDataSource, this._firebaseAuthDataSource, this._networkStatus);

  final AuthRemoteDataSource _remoteDataSource;
  final FirebaseAuthDataSource _firebaseAuthDataSource;
  final NetworkStatus _networkStatus;

  @override
  FutureResult<GlobalResponse<LoginResponseModel>> login(LoginParams params) async {
    if (await _networkStatus.isConnected) {
      try {
        final result = await _remoteDataSource.login(params);
        return Result.success(result);
      } on Failure catch (error) {
        return Result.failure(error);
      }
    } else {
      return Result.failure(ServerFailure.noNetwork());
    }
  }

  @override
  FutureResult<GlobalResponse> resetPassword(ResetPasswordParams params) async {
    if (await _networkStatus.isConnected) {
      try {
        final result = await _remoteDataSource.resetPassword(params);
        return Result.success(result);
      } on Failure catch (error) {
        return Result.failure(error);
      }
    } else {
      return Result.failure(ServerFailure.noNetwork());
    }
  }

  @override
  FutureResult<GlobalResponse> sendOtp(SendOtpParams params) async {
    if (await _networkStatus.isConnected) {
      try {
        final result = await _remoteDataSource.sendOtp(params);
        return Result.success(result);
      } on Failure catch (error) {
        return Result.failure(error);
      }
    } else {
      return Result.failure(ServerFailure.noNetwork());
    }
  }

  @override
  FutureResult<GlobalResponse> verifyOtp(VerifyOtpParams params) async {
    if (await _networkStatus.isConnected) {
      try {
        final result = await _remoteDataSource.verifyOtp(params);
        return Result.success(result);
      } on Failure catch (error) {
        return Result.failure(error);
      }
    } else {
      return Result.failure(ServerFailure.noNetwork());
    }
  }

  @override
  FutureResult<SocialUserModel> signInWithGoogle() async {
    if (await _networkStatus.isConnected) {
      try {
        final result = await _firebaseAuthDataSource.signInWithGoogle();
        return Result.success(result);
      } on Failure catch (error) {
        return Result.failure(error);
      }
    } else {
      return Result.failure(ServerFailure.noNetwork());
    }
  }

  @override
  FutureResult<SocialUserModel> signInWithFacebook() async {
    if (await _networkStatus.isConnected) {
      try {
        final result = await _firebaseAuthDataSource.signInWithFacebook();
        return Result.success(result);
      } on Failure catch (error) {
        return Result.failure(error);
      }
    } else {
      return Result.failure(ServerFailure.noNetwork());
    }
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuthDataSource.signOut();
  }
}
