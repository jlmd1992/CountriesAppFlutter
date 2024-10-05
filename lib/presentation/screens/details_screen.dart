import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:countries_app/config/routes.dart';
import 'package:countries_app/domain/entities/country_entity.dart';
import 'package:countries_app/presentation/providers/detail_provider.dart';
import 'package:countries_app/presentation/widgets/alert_dialog_confirm.dart';

class DetailsScreen extends StatelessWidget {

  final Country country;
  final int index;

  const DetailsScreen({
    super.key, 
    required this.country, 
    required this.index,
  });

  Future<void> _showConfirmDialog(BuildContext context) async {
    final bool? result = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialogConfirm(country: country);
      },
    );

    if (result == true) {
      await context.read<DetailProvider>().deleteCountry(index);
      Navigator.pop(context, true);
    }
  }

  void _goToForm(BuildContext context){
    Navigator.pushNamed(
      context,
      Routes.formScreen,
      arguments: {
        'country': country,
        'index': index,
      },
    ).then((result) {
      if (result == true) {
        Navigator.pop(context, true);
      }
    });
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
                  onPressed: () => _goToForm(context),
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