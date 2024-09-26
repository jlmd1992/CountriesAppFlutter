import 'package:countries_app/domain/repository/country_repository.dart';

class DeleteCountry {
  final CountryRepository repository;

  DeleteCountry(this.repository);

  void call(int index) {
    repository.deleteCountry(index);
  }
}