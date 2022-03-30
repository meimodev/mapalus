import 'package:mapalus/data/models/user.dart';

abstract class UserRepoContract {
  Future<User?> readSignedInUser();
}

class UserRepo extends UserRepoContract {
  @override
  Future<User?> readSignedInUser() {
    return Future.value(User('1234', 'Jhonny Estelle'));
  }
}