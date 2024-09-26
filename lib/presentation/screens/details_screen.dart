import 'package:countries_app/domain/entities/country.dart';
import 'package:countries_app/domain/usecase/add_country.dart';
import 'package:countries_app/domain/usecase/delete_country.dart';
import 'package:countries_app/domain/usecase/update_country.dart';
import 'package:countries_app/presentation/screens/form_screen.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {

  final Country country;
  final int index;
  final AddCountry addCountry;
  final UpdateCountry updateCountry;
  final DeleteCountry deleteCountry;

  const DetailsScreen({
    super.key, 
    required this.country, 
    required this.index,
    required this.updateCountry, 
    required this.deleteCountry, 
    required this.addCountry
  });

  Future<void> _showConfirmDialog(BuildContext context) async {
    final bool? result = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm delete'),
          content: Text('¿Are you sure to delete the country: "${country.name}"?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );

    if (result == true) {
      deleteCountry(index);
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FormScreen(
                          addCountry: addCountry,
                          country: country,
                          index: index,
                          updateCountry: updateCountry,
                        ),
                      ),
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