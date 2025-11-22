import 'package:easacc_task/core/error_handling/failures/failure.dart';
import 'package:easacc_task/core/helpers/cache/cache_helper.dart';
import 'package:easacc_task/core/helpers/result/result.dart';
import 'package:easacc_task/feature/auth/data/model/social_user_model.dart';
import 'package:easacc_task/feature/auth/data/repository/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._repository) : super(const LoginInitialState());
  final AuthRepository _repository;

  SocialUserModel? currentUser;

  Future<void> loginWithGoogle() async {
    emit(const LoginLoadingState(provider: SocialProvider.google));
    final result = await _repository.signInWithGoogle();
    result.when(
      onFailure: (failure) => emit(LoginFailureState(failure: failure)),
      onSuccess: (user) async {
        currentUser = user;
        await _saveUserSession(user);
        emit(const LoginSuccessState());
      },
    );
  }

  Future<void> loginWithFacebook() async {
    emit(const LoginLoadingState(provider: SocialProvider.facebook));
    final result = await _repository.signInWithFacebook();
    result.when(
      onFailure: (failure) => emit(LoginFailureState(failure: failure)),
      onSuccess: (user) async {
        currentUser = user;
        await _saveUserSession(user);
        emit(const LoginSuccessState());
      },
    );
  }

  Future<void> _saveUserSession(SocialUserModel user) async {
    await Future.wait([
      CacheHelper.save(CacheKeys.token, user.accessToken),
      CacheHelper.save(CacheKeys.userEmail, user.email),
      CacheHelper.save(CacheKeys.userName, user.displayName),
      CacheHelper.save(CacheKeys.userPhoto, user.photoUrl),
      CacheHelper.save(CacheKeys.socialProvider, user.provider.name),
    ]);
  }

  Future<void> signOut() async {
    await _repository.signOut();
    await CacheHelper.clear();
  }

  Future<bool> isLoggedIn() async {
    final token = CacheHelper.get(CacheKeys.token);
    return token != null;
  }
}
