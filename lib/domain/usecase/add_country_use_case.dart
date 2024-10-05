import 'package:countries_app/domain/entities/country_entity.dart';
import 'package:countries_app/domain/interfaces/country_interface.dart';

/// Use case to add a country from the repository.
///
/// This class is responsible for save a country by
/// calling the `addCountry` method of the repository. The presentation
/// layer interacts with the domain layer through use cases.
///
class AddCountryUseCase {
  final CountryInterface repository;

  AddCountryUseCase(this.repository);

  /// Executes the use case to save the country.
  ///
  /// This function calls the `addCountry` method on the provided repository
  /// and add a new [Country] to the list.
  Future<void> call(Country country) async {
    repository.addCountry(country);
  }
}