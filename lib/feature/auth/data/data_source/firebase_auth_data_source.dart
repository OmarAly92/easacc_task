import 'package:easacc_task/core/error_handling/failures/failure.dart';
import 'package:easacc_task/feature/auth/data/model/social_user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class FirebaseAuthDataSource {
  Future<SocialUserModel> signInWithGoogle();

  Future<SocialUserModel> signInWithFacebook();

  Future<void> signOut();

  User? getCurrentUser();
}

class FirebaseAuthDataSourceImp implements FirebaseAuthDataSource {
  FirebaseAuthDataSourceImp({
    FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
    FacebookAuth? facebookAuth,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
       _googleSignIn = googleSignIn ?? GoogleSignIn.instance,
       _facebookAuth = facebookAuth ?? FacebookAuth.instance;

  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final FacebookAuth _facebookAuth;

  @override
  Future<SocialUserModel> signInWithGoogle() async {
    try {
      await _googleSignIn.initialize();
      final GoogleSignInAccount? googleUser = await _googleSignIn
          .attemptLightweightAuthentication();

      if (googleUser == null) {
        throw ServerFailure(
          error: 'Google sign in cancelled',
          message: 'Google sign in was cancelled by user',
        );
      }

      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.idToken,
        idToken: googleAuth.idToken,
      );

      final data = await _firebaseAuth.signInWithCredential(credential);
      return SocialUserModel(
        provider: SocialProvider.google,
        displayName: data.user?.displayName ?? '',
        email: data.user?.email,
        id: data.user?.uid,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'popup-closed-by-user' || e.code == 'user-cancelled') {
        throw ServerFailure(
          error: 'Google sign in cancelled',
          message: 'Google sign in was cancelled by user',
        );
      }
      throw ServerFailure(error: e.code, message: e.message ?? 'Google sign in failed');
    } catch (e) {
      if (e is Failure) rethrow;
      throw ServerFailure(error: e, message: 'Google sign in failed: ${e.toString()}');
    }
  }

  @override
  Future<SocialUserModel> signInWithFacebook() async {
    try {
      final LoginResult result = await _facebookAuth.login(
        permissions: ['email', 'public_profile'],
      );

      if (result.status == LoginStatus.cancelled) {
        throw ServerFailure(
          error: 'Facebook sign in cancelled',
          message: 'Facebook sign in was cancelled',
        );
      }

      if (result.status == LoginStatus.failed) {
        throw ServerFailure(
          error: result.message ?? 'Facebook failed',
          message: result.message ?? 'Facebook sign in failed',
        );
      }

      final AccessToken? accessToken = result.accessToken;
      if (accessToken == null) {
        throw ServerFailure(
          error: 'Facebook access token null',
          message: 'Failed to get Facebook access token',
        );
      }

      final credential = FacebookAuthProvider.credential(accessToken.tokenString);

      final UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user == null) {
        throw ServerFailure(
          error: 'Firebase user null',
          message: 'Failed to get user from Firebase',
        );
      }

      return SocialUserModel(
        id: user.uid,
        email: user.email,
        displayName: user.displayName,
        photoUrl: user.photoURL,
        accessToken: accessToken.tokenString,
        provider: SocialProvider.facebook,
      );
    } catch (e) {
      if (e is Failure) rethrow;
      throw ServerFailure(error: e, message: 'Facebook sign in failed: ${e.toString()}');
    }
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }
}
