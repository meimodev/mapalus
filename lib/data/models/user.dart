class User {
  String phone;
  String name;

  User(this.phone, this.name);

  @override
  String toString() {
    return 'User{phone: $phone, name: $name}';
  }
}