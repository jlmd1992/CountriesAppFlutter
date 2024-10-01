
import '../entities/country_entity.dart';

abstract class CountryInterface {
  Future<List<Country>> getCountries();

  void addCountry(Country country);

  void editCountry(int index, Country country);

  void deleteCountry(int index);
}