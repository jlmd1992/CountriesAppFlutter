import 'dart:convert';
import 'package:countries_app/domain/entities/country_entity.dart';
import 'package:countries_app/domain/interfaces/country_interface.dart';
import 'package:flutter/services.dart';

/// Repository to manage the Country list 
/// with the CRUD functions
class CountryRepository implements CountryInterface {

  List<Country> _countries = [];

  /// This function load a Country list from json of the assets.
  Future<void> loadCountriesFromJson() async {
    try {
      final String response = await rootBundle.loadString('assets/countries.json');
      final List<dynamic> data = json.decode(response);

      _countries = data.map((countryJson) {
        return Country.fromJson(countryJson);
      }).toList();
    } catch (e) {
      throw Exception('Error when loading data, repository');
    }
  }

  /// This function add a new [Country] to the list.
  @override
  Future<void> addCountry(Country country) async {
    
    _countries.add(country);
  }

  /// This function delete a [Country] by its [index].
  @override
  Future<void> deleteCountry(int index) async {
    
    _countries.removeAt(index);
  }

  /// This function update/edit a [Country] by its [index]
  @override
  Future<void> editCountry(int index, Country country) async {
    
    _countries[index] = country;
  }

  /// This function get/load a Country list.
  @override
  Future<List<Country>> getCountries() async {
    if (_countries.isEmpty) {
      await loadCountriesFromJson();
    }
    return _countries;
  }
}