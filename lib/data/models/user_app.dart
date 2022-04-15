class UserApp {
  String phone;
  String name;

  UserApp({required this.phone, required this.name});

  @override
  String toString() {
    return 'User{phone: $phone, name: $name}';
  }

  Map<String, dynamic> toMap() {
    return {'name': name, 'phone': phone};
  }
}