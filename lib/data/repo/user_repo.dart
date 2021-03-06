import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
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

  Function(UserApp userApp)? onSuccessSigning;
  Function(UserApp userApp)? onSignedUser;
  Function(String phone)? onUnregisteredUser;
  VoidCallback? onSigningOut;

  bool shouldCallIdChange = false;

  // bool authStatusCalled = false;

  UserRepo() {
    auth.authStateChanges().listen((User? user) async {
      if (user != null) {
        debugPrint('AuthStateChanges(), Phone number confirmed');
        // authStatusCalled = true;
        UserApp? userApp = await firestore.getUser(
          user.phoneNumber!.replaceFirst('+62', '0'),
        );
        if (userApp != null) {
          debugPrint('AuthStateChanges() signed success $signedUser');
          signing(userApp);
        } else {
          // user is not registered
          if (onUnregisteredUser != null) {
            onUnregisteredUser!(user.phoneNumber!);
          }
          signedUser = null;
          shouldCallIdChange = true;
          debugPrint(
              'AuthStateChanges() Phone is not registered ${user.phoneNumber!}');
        }
      } else {
        debugPrint('AuthStateChanges() user = null');

        signedUser = null;
      }
    });
    auth.idTokenChanges().listen((user) async {
      //just called this listener when the auth status is never called
      if (!shouldCallIdChange) {
        return;
      }
      if (user != null) {
        debugPrint('idTokenChanges(), Phone number confirmed');
        if (signedUser != null) {
          debugPrint('idTokenChanges(), user already signed');
          return;
        }
        UserApp? userApp = await firestore.getUser(
          user.phoneNumber!.replaceFirst('+62', '0'),
        );

        if (userApp != null) {
          debugPrint('idTokenChanges() signed success $signedUser');
          signing(userApp);
        } else {
          // user is not registered
          if (onUnregisteredUser != null) {
            onUnregisteredUser!(user.phoneNumber!);
          }
          signedUser = null;
          debugPrint(
              'idTokenChanges() Phone is not registered ${user.phoneNumber!}');
        }
        return;
      }
      debugPrint("idTokenChanges() Phone not confirmed");
    });
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
      onSuccessSigning = null;
    }
    if (onSignedUser != null) {
      onSignedUser!(user);
    }
    FirebaseCrashlytics.instance
        .setUserIdentifier("${user.phone} - ${user.name}");
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
    // debugPrint("registerUser() $user");
    signing(await firestore.createUser(user));

    return Future.value(user);
  }

  @override
  void requestOTP(String phone, Function(Result) onResult) async {
    phone = phone.replaceFirst("0", "+62");

    try {
      await auth.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential);
          debugPrint("[VERIFICATION COMPLETED] CODE AUTOMATICALLY RETRIEVED");
          onResult(Result(message: "PROCEED"));
        },
        verificationFailed: (FirebaseAuthException e) async {
          debugPrint('[VERIFICATION_FAILED] ${e.code}');
          await FirebaseCrashlytics.instance.recordError(e, e.stackTrace,
              reason: 'FirebaseAuthException verificationFailed');

          FirebaseCrashlytics.instance
              .log("AUTH EXCEPTION Verification ${e.code}");

          onResult(Result(message: "VERIFICATION_FAILED"));
        },
        codeSent: (String id, int? token) {
          verificationId = id;
          resendToken = token;

          debugPrint('[CODE SENT]');
          onResult(Result(message: "SENT"));
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
        forceResendingToken: resendToken,
      );
    } catch (e) {
      debugPrint("SOME ERROR OCCURED ${e.toString()}");
    }
  }

  void checkOTPCode(String smsCode, Function(Result) onResult) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId!,
      smsCode: smsCode,
    );

    try {
      await auth.signInWithCredential(credential);
      onResult(Result(message: 'OK'));
    } on FirebaseAuthException catch (e) {
      await FirebaseCrashlytics.instance
          .recordError(e, e.stackTrace, reason: 'FirebaseAuthException');

      FirebaseCrashlytics.instance.log("AUTH EXCEPTION ${e.code}");

      debugPrint('AUTH EXCEPTION ${e.code}');

      if (e.code == "invalid-verification-code") {
        debugPrint('INVALID CODE');
        onResult(Result(message: "INVALID_CODE"));
        return;
      } else if (e.code == "invalid-verification-id") {
        debugPrint('INVALID VERIFICATION ID');
        onResult(Result(message: "INVALID_ID"));
        return;
      } else if (e.code == 'session-expired') {
        debugPrint('SESSION EXPIRED');
        onResult(Result(message: "EXPIRED"));
        return;
      } else {
        debugPrint('Unidentified error occurred in signInWithCredential');
        debugPrint(e.toString());
        return;
      }
    }
  }

  Future<void> signOut() async {
    if (signedUser != null) {
      await FirebaseAuth.instance.signOut();
      signedUser = null;
    }
    FirebaseCrashlytics.instance.setUserIdentifier("");

    if (onSigningOut != null) {
      onSigningOut!();
    }
  }
}