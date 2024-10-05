import 'package:countries_app/domain/interfaces/country_interface.dart';

/// Use case to delete a country from the repository.
///
/// This class is responsible for removing a country from the list by
/// calling the `deleteCountry` method of the repository. The presentation
/// layer interacts with the domain layer through use cases.
///
class DeleteCountryUseCase {
  final CountryInterface repository;

  DeleteCountryUseCase(this.repository);

  /// Executes the use case to delete a country at the given index.
  ///
  /// This function calls the `deleteCountry` method on the provided repository
  /// and deletes a Country by its [index].
  Future<void> call(int index) async {
    repository.deleteCountry(index);
  }
}