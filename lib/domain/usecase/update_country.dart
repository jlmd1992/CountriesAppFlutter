import 'package:countries_app/domain/entities/country.dart';
import 'package:countries_app/domain/repository/country_repository.dart';

class UpdateCountry {
  final CountryRepository repository;

  UpdateCountry(this.repository);

  void call(int index, Country country) {
    repository.editCountry(index, country);
  }
}