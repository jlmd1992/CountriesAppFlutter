import 'package:countries_app/domain/entities/country.dart';
import 'package:countries_app/domain/usecase/add_country.dart';
import 'package:countries_app/domain/usecase/update_country.dart';
import 'package:flutter/material.dart';

class FormScreen extends StatefulWidget {

  final Country? country;
  final int? index;
  final UpdateCountry updateCountry;
  final AddCountry addCountry;

  const FormScreen({
    super.key, 
    this.country, 
    this.index,
    required this.updateCountry, 
    required this.addCountry
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
        widget.addCountry(newCountry);
      } else {
        widget.updateCountry(widget.index!, newCountry);
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
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Name is required';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _capitalController,
                  decoration: const InputDecoration(labelText: 'Capital'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Capital is required';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Description is required';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _populationController,
                  decoration: const InputDecoration(labelText: 'Population')                  
                ),
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