import 'package:countries_app/domain/entities/country_entity.dart';
import 'package:countries_app/domain/usecase/add_country_use_case.dart';
import 'package:countries_app/domain/usecase/update_country_use_case.dart';
import 'package:countries_app/presentation/widgets/input_form_country.dart';
import 'package:flutter/material.dart';

class FormScreen extends StatefulWidget {

  final Country? country;
  final int? index;
  final UpdateCountryUseCase updateCountryUseCase;
  final AddCountryUseCase addCountryUseCase;

  const FormScreen({
    super.key, 
    this.country, 
    this.index,
    required this.updateCountryUseCase, 
    required this.addCountryUseCase
  });

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {

  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _capitalController;
  late TextEditingController _descriptionController;
  late TextEditingController _populationController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.country?.name ?? '');
    _capitalController = TextEditingController(text: widget.country?.capital ?? '');
    _descriptionController = TextEditingController(text: widget.country?.description ?? '');
    _populationController = TextEditingController(text: widget.country?.population ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _capitalController.dispose();
    _descriptionController.dispose();
    _populationController.dispose();
    super.dispose();
  }

  void _saveForm() async {
    if (_formKey.currentState!.validate()) {
      final newCountry = Country(
        name: _nameController.text,
        capital: _capitalController.text,
        description: _descriptionController.text,
        population: _populationController.text,
      );

      if (widget.index == null) {
        widget.addCountryUseCase(newCountry);
      } else {
        widget.updateCountryUseCase(widget.index!, newCountry);
      }

      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.country == null ? 'Add Country' : 'Edit Country'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                InputFormCountry(controller: _nameController, type: 'Name',),
                InputFormCountry(controller: _capitalController, type: 'Capital',),
                InputFormCountry(controller: _descriptionController, type: 'Description',),
                InputFormCountry(controller: _populationController, type: 'Population', isRequired: false),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _saveForm,
                  child: Text(widget.index == null ? 'Add' : 'Save'),
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