class UserApp {
  String phone;
  String name;
  List<String> orders;

  UserApp({
    required this.phone,
    required this.name,
    this.orders = const [],
  });

  UserApp.fromMap(Map<String, dynamic> data)
      : phone = data["phone"],
        name = data["name"],
        orders = List<String>.from(data["orders"]);

  @override
  String toString() {
    return 'User{phone: $phone, name: $name, orders: $orders}';
  }

  Map<String, dynamic> toMap() {
    return {'name': name, 'phone': phone, 'orders': orders};
  }
}