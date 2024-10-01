import 'package:countries_app/config/routes.dart';
import 'package:countries_app/domain/entities/country_entity.dart';
import 'package:countries_app/domain/usecase/add_country_use_case.dart';
import 'package:countries_app/domain/usecase/delete_country_use_case.dart';
import 'package:countries_app/domain/usecase/get_countries_use_case.dart';
import 'package:countries_app/domain/usecase/update_country_use_case.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final GetCountriesUseCase getCountriesUseCase;
  final AddCountryUseCase addCountryUseCase;
  final UpdateCountryUseCase updateCountryUseCase;
  final DeleteCountryUseCase deleteCountryUseCase;

  const HomeScreen({
    required this.getCountriesUseCase, 
    required this.addCountryUseCase, 
    required this.updateCountryUseCase, 
    required this.deleteCountryUseCase
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<Country> _countries = [];
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _loadCountries();
  }

  Future<void> _loadCountries() async {
    try {
      final countries = await widget.getCountriesUseCase();
      setState(() {
        _countries = countries;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _hasError = true;
      });
    }
  }

  Future<void> _navigateToForm() async {
    final result = await Navigator.pushNamed(
      context,
      Routes.formScreen,
      arguments: {
        'addCountryUseCase': widget.addCountryUseCase,
        'updateCountryUseCase': widget.updateCountryUseCase,
      },
    );

    if (result == true) {
      _loadCountries();
    }
  }

  Future<void> _navigateToDetails(int index) async {
    final result = await Navigator.pushNamed(
      context,
      Routes.detailsScreen,
      arguments: {
          'country': _countries[index],
          'index': index,
          'updateCountryUseCase': widget.updateCountryUseCase, 
          'deleteCountryUseCase': widget.deleteCountryUseCase, 
          'addCountryUseCase': widget.addCountryUseCase
      }
    );

    if (result == true) {
      _loadCountries();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Latin America Countries'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _hasError
              ? const Center(child: Text('Error loading data'))
              : Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: ListView.builder(
                    itemCount: _countries.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(_countries[index].name),
                          subtitle: Text(_countries[index].capital),
                          onTap: () => _navigateToDetails(index),
                        ),
                      );
                    },
                  ),
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToForm,
        child: const Icon(Icons.add),
      ),
    );
  }
}