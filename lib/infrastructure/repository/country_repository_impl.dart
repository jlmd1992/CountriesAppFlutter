import 'dart:convert';
import 'package:countries_app/domain/entities/country.dart';
import 'package:flutter/services.dart';
import '../../domain/repository/country_repository.dart';

class CountryRepositoryImpl implements CountryRepository {

  List<Country> _countries = [];

  Future<void> loadCountriesFromJson() async {
    try {
      final String response = await rootBundle.loadString('assets/countries.json');
      final List<dynamic> data = json.decode(response);

      _countries = data.map((countryJson) {
        return Country(
          name: countryJson['name'],
          capital: countryJson['capital'],
          description: countryJson['description'],
          population: countryJson['population']
        );
      }).toList();
    } catch (e) {
      throw Exception('Error when loading data, repository');
    }
  }

  @override
  Future<void> addCountry(Country country) async {
    
    _countries.add(country);
  }

  @override
  Future<void> deleteCountry(int index) async {
    
    _countries.removeAt(index);
  }

  @override
  Future<void> editCountry(int index, Country country) async {
    
    _countries[index] = country;
  }

  @override
  Future<List<Country>> getCountries() async {
    if (_countries.isEmpty) {
      await loadCountriesFromJson();
    }
    return _countries;
  }
}