import 'package:countries_app/domain/entities/country.dart';
import 'package:countries_app/domain/repository/country_repository.dart';

class GetCountries {
  final CountryRepository repository;

  GetCountries(this.repository);

  Future<List<Country>> call() async {
    return await repository.getCountries();
  }
}