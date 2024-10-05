import 'package:countries_app/domain/entities/country_entity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:countries_app/config/routes.dart';
import 'package:countries_app/presentation/providers/home_provider.dart';

class HomeScreen extends StatelessWidget {

  const HomeScreen({super.key});

  Future<void> _navigateToForm(BuildContext context) async {
    final result = await 
    Navigator.pushNamed(
      context,
      Routes.formScreen,
      arguments: {
        'country': null,
        'index': null,
      },
    );

    if (result == true) {
      context.read<HomeProvider>().loadCountries();
    }
  }

  @override
  Widget build(BuildContext context) {

    final homeProvider = context.watch<HomeProvider>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!homeProvider.isLoading && homeProvider.countries.isEmpty) {
        context.read<HomeProvider>().loadCountries();
      }
    });
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Latin America Countries'),
      ),
      body: homeProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : homeProvider.hasError
              ? const Center(child: Text('Error loading data'))
              : Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: ListView.builder(
                    itemCount: homeProvider.countries.length,
                    itemBuilder: (context, index) {
                      final country = homeProvider.countries[index];
                      return _CountryCard(country: country, index: index);
                    },
                  ),
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToForm(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _CountryCard extends StatelessWidget{

  final Country country;
  final int index;

  const _CountryCard({
    required this.country, 
    required this.index
  });

  Future<void> _navigateToDetails(BuildContext context, int index) async {
    final homeProvider = context.read<HomeProvider>();
    final country = homeProvider.countries[index];

    final result = await Navigator.pushNamed(
      context,
      Routes.detailsScreen,
      arguments: {
        'country': country,
        'index': index,
      },
    );

    if (result == true) {
      homeProvider.loadCountries();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(country.name),
        subtitle: Text(country.capital),
        onTap: () => _navigateToDetails(context, index),
      )
    );
  }
}