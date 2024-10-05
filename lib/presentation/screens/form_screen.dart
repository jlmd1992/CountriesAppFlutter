import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:countries_app/domain/entities/country_entity.dart';
import 'package:countries_app/presentation/providers/form_provider.dart';
import 'package:countries_app/presentation/widgets/input_form_country.dart';

class FormScreen extends StatelessWidget {

  final Country? country;
  final int? index;

  FormScreen({
    super.key, 
    this.country, 
    this.index,
  });

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    final formProvider = context.watch<FormProvider>();

    final TextEditingController nameController = TextEditingController(text: country?.name ?? '');
    final TextEditingController capitalController = TextEditingController(text: country?.capital ?? '');
    final TextEditingController descriptionController = TextEditingController(text: country?.description ?? '');
    final TextEditingController populationController = TextEditingController(text: country?.population ?? '');

    Future<void> saveForm() async {
      if (_formKey.currentState!.validate()) {
        final newCountry = Country(
          name: nameController.text,
          capital: capitalController.text,
          description: descriptionController.text,
          population: populationController.text,
        );

        if (index == null) {
          await formProvider.addCountry(newCountry);
        } else {
          await formProvider.updateCountry(index!, newCountry);
        }
        Navigator.pop(context, true);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(country == null ? 'Add Country' : 'Edit Country'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                InputFormCountry(controller: nameController, type: 'Name',),
                InputFormCountry(controller: capitalController, type: 'Capital',),
                InputFormCountry(controller: descriptionController, type: 'Description',),
                InputFormCountry(controller: populationController, type: 'Population', isRequired: false),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: formProvider.isSaving ? null : saveForm,
                  child: formProvider.isSaving
                      ? const CircularProgressIndicator(
                          color: Colors.blue,
                        )
                      : Text(index == null ? 'Add' : 'Save'),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        )
      ),
    );
  }
}