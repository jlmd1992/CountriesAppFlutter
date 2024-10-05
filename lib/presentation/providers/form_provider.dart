import 'package:countries_app/domain/entities/country_entity.dart';
import 'package:countries_app/domain/usecase/add_country_use_case.dart';
import 'package:countries_app/domain/usecase/update_country_use_case.dart';
import 'package:flutter/material.dart';

class FormProvider extends ChangeNotifier {
  final AddCountryUseCase addCountryUseCase;
  final UpdateCountryUseCase updateCountryUseCase;

  bool _isSaving = false;
  bool get isSaving => _isSaving;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  FormProvider({
    required this.addCountryUseCase,
    required this.updateCountryUseCase,
  });

  Future<void> addCountry(Country country) async {
    _isSaving = true;
    notifyListeners();
    try {
      await addCountryUseCase(country);
    } catch (error) {
      _errorMessage = 'Failed to add country';
    } finally {
      _isSaving = false;
      notifyListeners();
    }
  }

  Future<void> updateCountry(int index, Country country) async {
    _isSaving = true;
    notifyListeners();
    try {
      await updateCountryUseCase(index, country);
    } catch (error) {
      _errorMessage = 'Failed to update country';
    } finally {
      _isSaving = false;
      notifyListeners();
    }
  }
}