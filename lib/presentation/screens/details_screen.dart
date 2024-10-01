import 'package:countries_app/config/routes.dart';
import 'package:countries_app/domain/entities/country_entity.dart';
import 'package:countries_app/domain/usecase/add_country_use_case.dart';
import 'package:countries_app/domain/usecase/delete_country_use_case.dart';
import 'package:countries_app/domain/usecase/update_country_use_case.dart';
import 'package:countries_app/presentation/widgets/alert_dialog_confirm.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {

  final Country country;
  final int index;
  final AddCountryUseCase addCountryUseCase;
  final UpdateCountryUseCase updateCountryUseCase;
  final DeleteCountryUseCase deleteCountryUseCase;

  const DetailsScreen({
    super.key, 
    required this.country, 
    required this.index,
    required this.updateCountryUseCase, 
    required this.deleteCountryUseCase, 
    required this.addCountryUseCase
  });

  Future<void> _showConfirmDialog(BuildContext context) async {
    final bool? result = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialogConfirm(country: country);
      },
    );

    if (result == true) {
      deleteCountryUseCase(index);
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(country.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Capital: ${country.capital}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Description: ${country.description}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('Population: ${country.population}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      Routes.formScreen,
                      arguments: {
                        'addCountryUseCase': addCountryUseCase,
                        'country': country,
                        'index': index,
                        'updateCountryUseCase': updateCountryUseCase,
                      },
                    ).then((result) {
                      if (result == true) {
                        Navigator.pop(context, true);
                      }
                    });
                  },
                  child: const Text('Edit'),
                ),
                ElevatedButton(
                  onPressed: () => _showConfirmDialog(context),
                  child: const Text('Delete', style: TextStyle(color: Colors.red)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}