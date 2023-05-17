

import 'package:application_task/data/model/country.dart';

class Countries {
  final List<Country> countryList;

  Countries({required this.countryList});

  factory Countries.fromJson(List<dynamic> country) {

    List<Country> cty = List<Country>.empty(growable: true);
    country.forEach((json) {
      if (json['country_id'] != null) {
        final c = Country.fromJson(json);
        cty.add(c);
      }
    });
    return Countries(countryList: cty);
  }

}