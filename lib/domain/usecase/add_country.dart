import 'package:countries_app/domain/entities/country.dart';
import 'package:countries_app/domain/repository/country_repository.dart';

class AddCountry {
  final CountryRepository repository;

  AddCountry(this.repository);

  void call(Country country) {
    repository.addCountry(country);
  }
}