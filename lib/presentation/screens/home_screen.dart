import 'package:countries_app/domain/entities/country.dart';
import 'package:countries_app/domain/usecase/add_country.dart';
import 'package:countries_app/domain/usecase/delete_country.dart';
import 'package:countries_app/domain/usecase/get_countries.dart';
import 'package:countries_app/domain/usecase/update_country.dart';
import 'package:countries_app/presentation/screens/details_screen.dart';
import 'package:countries_app/presentation/screens/form_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final GetCountries getCountries;
  final AddCountry addCountry;
  final UpdateCountry updateCountry;
  final DeleteCountry deleteCountry;

  const HomeScreen({
    required this.getCountries, 
    required this.addCountry, 
    required this.updateCountry, 
    required this.deleteCountry
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
      final countries = await widget.getCountries();
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
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FormScreen(addCountry: widget.addCountry, updateCountry: widget.updateCountry,),
      ),
    );

    if (result == true) {
      _loadCountries();
    }
  }

  Future<void> _navigateToDetails(int index) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailsScreen(
          country: _countries[index],
          index: index,
          updateCountry: widget.updateCountry, 
          deleteCountry: widget.deleteCountry, 
          addCountry: widget.addCountry
        ),
      ),
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