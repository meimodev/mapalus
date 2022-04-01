import 'dart:math';

import 'package:mapalus/data/models/result.dart';
import 'package:mapalus/data/models/user.dart';

abstract class UserRepoContract {
  Future<User> readSignedInUser();

  Future<User> signInUser(String phone, String code);

  Future<bool> checkIfRegistered(String phone);

  Future<User> registerUser(String phone, String name);

  Future<String> requestOTP(String phone);
}

class UserRepo extends UserRepoContract {
  User? signedUser;

  @override
  Future<User> readSignedInUser() {
    if (signedUser == null) {
      throw Result<User>(
        error: true,
        message: "NO_SIGNED_USER",
      );
    }

    return Future.value(
      signedUser,
    );
  }

  @override
  Future<User> signInUser(String phone, String code) async {
    //TODO verify the code first, than retrieve user with that phone
    if (phone == '081212341234' && code == '123456') {
      var _user = User(
        name: 'Jhon Manembo',
        phone: phone,
      );

      signedUser = _user;

      return Future.value(
        _user,
      );
    }
    throw Result(message: 'INVALID_USER');
  }

  @override
  Future<bool> checkIfRegistered(String phone) {
    //TODO Checking user existence logic
    return Future.value(
      Random(0).nextInt(10) % 2 == 0,
    );
  }

  @override
  Future<User> registerUser(String phone, String name) {
    //TODO register user logic here
    User user = User(phone: phone, name: name);
    signedUser = user;

    return Future.value(
      user,
    );
  }

  @override
  Future<String> requestOTP(String phone) {
    // TODO: Request otp logic
    return Future.value('123456');
  }
}