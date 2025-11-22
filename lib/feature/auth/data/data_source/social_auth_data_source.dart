// import 'package:easacc_task/core/error_handling/failures/failure.dart';
// import 'package:easacc_task/feature/auth/data/model/social_user_model.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
//
// abstract class SocialAuthDataSource {
//   Future<SocialUserModel> signInWithGoogle();
//
//   Future<SocialUserModel> signInWithFacebook();
//
//   Future<void> signOut();
// }
//
// class SocialAuthDataSourceImp implements SocialAuthDataSource {
//   SocialAuthDataSourceImp({GoogleSignIn? googleSignIn, FacebookAuth? facebookAuth})
//     : _googleSignIn = googleSignIn ?? GoogleSignIn(scopes: ['email', 'profile']),
//       _facebookAuth = facebookAuth ?? FacebookAuth.instance;
//
//   final GoogleSignIn _googleSignIn;
//   final FacebookAuth _facebookAuth;
//
//   @override
//   Future<SocialUserModel> signInWithGoogle() async {
//     try {
//       final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
//
//       if (googleUser == null) {
//         throw ServerFailure(
//           error: 'Google sign in cancelled',
//           message: 'Google sign in was cancelled',
//         );
//       }
//
//       final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
//
//       return SocialUserModel(
//         id: googleUser.id,
//         email: googleUser.email,
//         displayName: googleUser.displayName,
//         photoUrl: googleUser.photoUrl,
//         accessToken: googleAuth.accessToken,
//         provider: SocialProvider.google,
//       );
//     } catch (e) {
//       if (e is Failure) rethrow;
//       throw ServerFailure(error: e, message: 'Google sign in failed: ${e.toString()}');
//     }
//   }
//
//   @override
//   Future<SocialUserModel> signInWithFacebook() async {
//     try {
//       final LoginResult result = await _facebookAuth.login(
//         permissions: ['email', 'public_profile'],
//       );
//
//       if (result.status == LoginStatus.cancelled) {
//         throw ServerFailure(
//           error: 'Facebook sign in cancelled',
//           message: 'Facebook sign in was cancelled',
//         );
//       }
//
//       if (result.status == LoginStatus.failed) {
//         throw ServerFailure(
//           error: result.message ?? 'Facebook failed',
//           message: result.message ?? 'Facebook sign in failed',
//         );
//       }
//
//       final userData = await _facebookAuth.getUserData();
//
//       return SocialUserModel(
//         id: userData['id'] as String?,
//         email: userData['email'] as String?,
//         displayName: userData['name'] as String?,
//         photoUrl: userData['picture']?['data']?['url'] as String?,
//         accessToken: result.accessToken?.tokenString,
//         provider: SocialProvider.facebook,
//       );
//     } catch (e) {
//       if (e is Failure) rethrow;
//       throw ServerFailure(error: e, message: 'Facebook sign in failed: ${e.toString()}');
//     }
//   }
//
//   @override
//   Future<void> signOut() async {
//     await Future.wait([_googleSignIn.signOut(), _facebookAuth.logOut()]);
//   }
// }
