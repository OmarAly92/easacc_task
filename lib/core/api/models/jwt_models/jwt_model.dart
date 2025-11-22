import 'package:equatable/equatable.dart';
import 'package:easacc_task/core/api/models/jwt_models/jwt_user_model.dart';
import 'package:easacc_task/core/helpers/cache/cache_helper.dart';
import 'package:easacc_task/core/utils/jwt_decoder.dart';

class JwtModel extends Equatable {
  final String? iss;
  final int? iat;
  final int? exp;
  final int? nbf;
  final String? jti;
  final String? sub;
  final String? prv;
  final JwtUserModel? user;

  const JwtModel({this.iss, this.iat, this.exp, this.nbf, this.jti, this.sub, this.prv, this.user});

  factory JwtModel.fromAppToken() {
    final token = CacheHelper.get(CacheKeys.token);
    final json = JwtDecoder.tryDecode(token ?? '');
    return JwtModel(
      iss: json?['iss'] as String?,
      iat: json?['iat'] as int?,
      exp: json?['exp'] as int?,
      nbf: json?['nbf'] as int?,
      jti: json?['jti'] as String?,
      sub: json?['sub'] as String?,
      prv: json?['prv'] as String?,
      user: json?['user'] != null ? JwtUserModel.fromJson(json?['user']) : null,
    );
  }

  @override
  List<Object?> get props => [iss, iat, exp, nbf, jti, sub, prv, user];
}
