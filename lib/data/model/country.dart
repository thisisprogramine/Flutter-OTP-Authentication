
class Country {
  final String country_id;
  final double probability;


  const Country({
    required this.country_id,
    required this.probability
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      country_id: json['country_id'],
      probability: json['probability'],
    );
  }
}

