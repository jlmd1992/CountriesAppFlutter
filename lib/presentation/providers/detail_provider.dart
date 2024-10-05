import 'package:countries_app/domain/entities/country_entity.dart';
import 'package:countries_app/domain/usecase/add_country_use_case.dart';
import 'package:countries_app/domain/usecase/delete_country_use_case.dart';
import 'package:countries_app/domain/usecase/update_country_use_case.dart';
import 'package:flutter/material.dart';

class DetailProvider extends ChangeNotifier {
  final AddCountryUseCase addCountryUseCase;
  final UpdateCountryUseCase updateCountryUseCase;
  final DeleteCountryUseCase deleteCountryUseCase;

  bool _isDeleting = false;
  bool get isDeleting => _isDeleting;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  DetailProvider({
    required this.addCountryUseCase,
    required this.updateCountryUseCase,
    required this.deleteCountryUseCase,
  });

  Future<void> deleteCountry(int index) async {
    _isDeleting = true;
    notifyListeners();
    try {
      await deleteCountryUseCase(index);
    } catch (error) {
      _errorMessage = 'Failed to delete country';
    } finally {
      _isDeleting = false;
      notifyListeners();
    }
  }

  Future<void> updateCountry(int index, Country country) async {
    try {
      await updateCountryUseCase(index, country);
    } catch (error) {
      _errorMessage = 'Failed to update country';
      notifyListeners();
    }
  }
}