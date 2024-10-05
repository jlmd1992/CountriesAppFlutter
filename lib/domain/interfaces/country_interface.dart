
import '../entities/country_entity.dart';

/// Interface to implement main methods to interact with the source data
abstract class CountryInterface {

  /// Get countries list
  /// 
  /// return a list of [Country]
  Future<List<Country>> getCountries();

  /// Add a new country to the list
  /// 
  /// param: [Country] the new country to add
  Future<void> addCountry(Country country);

  /// Update a Country in the list
  /// 
  /// param: [index] index of the Country and [Country] the country to update
  Future<void> editCountry(int index, Country country);

  /// Delete a Country from the list
  /// 
  /// param: [index] index of the Country to delete
  Future<void> deleteCountry(int index);
}