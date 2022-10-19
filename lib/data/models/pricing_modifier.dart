class PricingModifier {
  double distancePrice;

  double weightPrice;

  /*Per 2 Kilometer*/
  double distanceUnit;

  /*Per 7 Kilogram*/
  double weightUnit;

  PricingModifier({
    required this.distancePrice,
    required this.weightPrice,
    required this.distanceUnit,
    required this.weightUnit,
  });

  factory PricingModifier.fromJson(Map<String, dynamic> map) => PricingModifier(
    distancePrice:double.parse( map['distance_price'].toString()),
        weightPrice: double.parse(map['weight_price'].toString()),
        distanceUnit: double.parse(map['distance_unit'].toString()),
        weightUnit: double.parse(map['weight_unit'].toString()),
      );

  Map<String, dynamic> get toMap => {
        'distance_price': distancePrice,
        'weight_price': weightPrice,
        'distance_unit': distanceUnit,
        'weight_unit': weightUnit,
      };

  @override
  String toString() {
    return 'PricingModifier{distancePrice: $distancePrice, weightPrice: $weightPrice, distanceUnit: $distanceUnit, weightUnit: $weightUnit}';
  }
}
