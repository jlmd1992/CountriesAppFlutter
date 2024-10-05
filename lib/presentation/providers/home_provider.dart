import 'package:countries_app/domain/entities/country_entity.dart';
import 'package:countries_app/domain/usecase/get_countries_use_case.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  final GetCountriesUseCase getCountriesUseCase;

  HomeProvider({
    required this.getCountriesUseCase
  });

  List<Country> _countries = [];
  List<Country> get countries => _countries;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _hasError = false;
  bool get hasError => _hasError;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> loadCountries() async {
    _isLoading = true;
    notifyListeners();
    try {
      _countries = await getCountriesUseCase();
    } catch (error) {
      _errorMessage = 'Failed to load countries';
      _hasError = true;
    } finally {
      _isLoading = false;
      _hasError = false;
      notifyListeners();
    }
  }
}