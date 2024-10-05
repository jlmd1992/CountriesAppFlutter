import 'package:countries_app/domain/entities/country_entity.dart';
import 'package:countries_app/domain/interfaces/country_interface.dart';

/// Use case to update a country from the repository.
///
/// This class is responsible for update a country by
/// calling the `addCountry` method of the repository. The presentation
/// layer interacts with the domain layer through use cases.
///
class UpdateCountryUseCase {
  final CountryInterface repository;

  UpdateCountryUseCase(this.repository);

  /// Executes the use case to update a country at the given index.
  ///
  /// This function calls the `editCountry` method on the provided repository
  /// and update a [Country] by its [index].
  Future<void> call(int index, Country country) async {
    repository.editCountry(index, country);
  }
}