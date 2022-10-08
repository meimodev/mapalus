class PricingModifier {
  int distancePrice;

  int weightPrice;

  /*Per 2 Kilometer*/
  int distanceUnit;

  /*Per 7 Kilogram*/
  int weightUnit;

  PricingModifier({
    required this.distancePrice,
    required this.weightPrice,
    required this.distanceUnit,
    required this.weightUnit,
  });

  factory PricingModifier.fromJson(Map<String, dynamic> map) => PricingModifier(
        distancePrice: map['distance_price'],
        weightPrice: map['weight_price'],
        distanceUnit: map['distance_unit'],
        weightUnit: map['weight_unit'],
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
