class User {
  String phone;
  String name;

  User({required this.phone, required this.name});

  @override
  String toString() {
    return 'User{phone: $phone, name: $name}';
  }
}