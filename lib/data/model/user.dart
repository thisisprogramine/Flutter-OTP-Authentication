
import 'package:application_task/data/model/country.dart';

class User {
  final String name;
  final String gender;
  final double probability;
  final int count;

  const User({
    required this.name,
    required this.gender,
    required this.probability,
    required this.count,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      gender: json['gender'],
      probability: json['probability'],
      count: json['count'],
    );
  }
}
