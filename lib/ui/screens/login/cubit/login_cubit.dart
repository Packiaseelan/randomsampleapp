import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String _verificationId;

  LoginCubit() : super(LoginInitial());

  Future verifyPhoneNumber(String phoneNumber) async {
    emit(PhoneNumberSubmit());
    try {
      _firebaseAuth.verifyPhoneNumber(
        phoneNumber: '+91$phoneNumber',
        verificationCompleted: (authCredential) {
          _signInWithCredential(authCredential);
        },
        verificationFailed: (authException) {
          emit(LoginFailed(authException.message));
        },
        codeSent: (String verificationId, [int forceResendingToken]) async {
          _verificationId = verificationId;
          emit(CodeSentSuccess());
        },
        codeAutoRetrievalTimeout: (verificationId) {
          _verificationId = verificationId;
          emit(LoginTimeout('time out'));
        },
      );
    } catch (e) {
      emit(LoginFailed('Phone verification failed.'));
    }
  }

  Future submitCode(
      {@required String phoneNumber, @required String smsCode}) async {
    try {
      AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: smsCode,
      );
      await _signInWithCredential(credential);
    } catch (e) {
      emit(LoginFailed('Submitting code failed'));
    }
  }

  Future userCancelled() async {
    emit(UserCancelled());
  }

  Future _signInWithCredential(AuthCredential credential) async {
    await _firebaseAuth.signInWithCredential(credential).then((userCredential) {
      emit(LoginSuccess());
    }).catchError((error) {
      emit(LoginFailed('Submitting code failed'));
    });
  }
}
