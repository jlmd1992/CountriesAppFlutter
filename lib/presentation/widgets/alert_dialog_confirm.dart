import 'package:countries_app/domain/entities/country_entity.dart';
import 'package:flutter/material.dart';

class AlertDialogConfirm extends StatelessWidget {
  const AlertDialogConfirm({
    super.key,
    required this.country,
  });

  final Country country;

  @override
  Widget build(BuildContext context) {
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
  }
}