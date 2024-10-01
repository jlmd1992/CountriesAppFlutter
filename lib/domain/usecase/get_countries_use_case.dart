import 'package:countries_app/domain/entities/country_entity.dart';
import 'package:countries_app/domain/interfaces/country_interface.dart';

/// Use case to get a list of countries from the repository.
///
/// This class is responsible for fetching a list of countries by
/// calling the `getCountries` method of the repository. The presentation
/// layer interacts with the domain layer through use cases.
///
class GetCountriesUseCase {
  final CountryInterface repository;

  GetCountriesUseCase(this.repository);

  /// Executes the use case to get the list of countries.
  ///
  /// This function calls the `getCountries` method on the provided repository
  /// and returns a list of [Country] objects.
  Future<List<Country>> call() async {
    return await repository.getCountries();
  }
}