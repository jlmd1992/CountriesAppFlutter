
import '../entities/country.dart';

abstract class CountryRepository {
  Future<List<Country>> getCountries();

  void addCountry(Country country);

  void editCountry(int index, Country country);

  void deleteCountry(int index);
}