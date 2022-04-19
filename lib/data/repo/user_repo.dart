import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import 'package:mapalus/data/models/result.dart';
import 'package:mapalus/data/models/user_app.dart';
import 'package:mapalus/data/services/firebase_services.dart';

abstract class UserRepoContract {
  Future<UserApp?> readSignedInUser();

  Future<bool> checkIfRegistered(String phone);

  Future<UserApp> registerUser(String phone, String name);

  void requestOTP(String phone, Function(Result) onResult);
}

class UserRepo extends UserRepoContract {
  UserApp? signedUser;
  int? resendToken;
  String? verificationId;
  FirestoreService firestore = FirestoreService();
  FirebaseAuth auth = FirebaseAuth.instance;

  bool canRegister = false;

  Function(UserApp)? onSuccessSigning;
  VoidCallback? onSigningOut;

  UserRepo() {
    auth.authStateChanges().listen((User? user) async {
      print('AuthStateChanges()');
      if (user != null) {
        print('AuthStateChanges, Phone number confirmed');
        UserApp? userApp = await firestore.getUser(
          user.phoneNumber!.replaceFirst('+62', '0'),
        );
        if (userApp != null) {
          signing(userApp);

          print('signed success ' + signedUser.toString());
        } else {
          // user is not registered
          signedUser = null;
          canRegister = true;
          print('Phone is not registered ' + user.phoneNumber!);
        }
      } else {
        print('AuthStateChanges() user = null');

        canRegister = false;
        signedUser = null;
      }
    });
    // checkPreviousSigning();
  }

  Future<void> checkPreviousSigning() async {
    var box = await Hive.openBox('user_signing');
    String? name = box.get('name');
    String? phone = box.get('phone');
    if (name != null && phone != null) {
      signedUser = UserApp(phone: phone, name: name);
    }
  }

  void signing(UserApp user) {
    signedUser = user;
    if (onSuccessSigning != null) {
      onSuccessSigning!(user);
    }
    // var box = Hive.box('user_signing');
    // box.put('name', user.name);
    // box.put('phone', user.phone);
  }

  @override
  Future<UserApp?> readSignedInUser() {
    return Future.value(signedUser);
  }

  @override
  Future<bool> checkIfRegistered(String phone) async {
    return Future.value(await firestore.checkPhoneRegistration(phone));
  }

  @override
  Future<UserApp> registerUser(String phone, String name) async {
    UserApp user = UserApp(phone: phone, name: name);
    signing(await firestore.createUser(user));

    return Future.value(
      user,
    );
  }

  @override
  void requestOTP(String phone, Function(Result) onResult) async {
    phone = phone.replaceFirst("0", "+62");
    if (kDebugMode) {
      print("phone " + phone);
    }
    await auth.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential);
        if (!await checkIfRegistered(phone)) {
          onResult(Result(message: "UNREGISTERED"));
          return;
        }
        onResult(Result(message: "PROCEED"));
      },
      verificationFailed: (FirebaseAuthException e) {
        if (kDebugMode) {
          print('VERIFICATION_FAILED ' + e.code);
        }
        onResult(Result(message: "VERIFICATION_FAILED"));
      },
      codeSent: (String _verificationId, int? _resendToken) {
        resendToken = _resendToken;
        verificationId = _verificationId;

        onResult(Result(message: "SENT"));
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
      forceResendingToken: resendToken,
    );
  }

  void checkOTPCode(String smsCode, Function(Result) onResult) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId!,
      smsCode: smsCode,
    );

    try {
      await auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-verification-code") {
        if (kDebugMode) {
          print('inv code');
        }
        onResult(Result(message: "INVALID_CODE"));
        return;
      } else if (e.code == "invalid-verification-id") {
        if (kDebugMode) {
          print('inv id');
        }
        onResult(Result(message: "INVALID_ID"));
        return;
      } else if (e.code == 'session-expired') {
        if (kDebugMode) {
          print('session expired');
        }
        onResult(Result(message: "EXPIRED"));
        return;
      } else {
        if (kDebugMode) {
          print('Unidentified error occurred in signInWithCredential');
          print(e.toString());
          return;
        }
      }
    }
    Future.delayed(const Duration(milliseconds: 800));
    onResult(Result(message: 'OK'));
  }

  Future<void> signOut() async {
    if (signedUser != null) {
      await FirebaseAuth.instance.signOut();
      signedUser = null;
    }

    if (onSigningOut != null) {
      onSigningOut!();
    }
  }
}