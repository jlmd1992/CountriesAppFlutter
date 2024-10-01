import 'package:flutter/material.dart';

class InputFormCountry extends StatelessWidget {

  final TextEditingController _controller;
  final String type;
  final bool isRequired;

  const InputFormCountry({
    super.key,
    required TextEditingController controller,
    required this.type, 
    this.isRequired = true,
  }) : _controller = controller;  

  @override
  Widget build(BuildContext context) {

    return TextFormField(
      controller: _controller,
      decoration: InputDecoration(labelText: type),
      validator: (value) {
        if (isRequired && (value == null || value.isEmpty)) {
          return '$type is required';
        }
        return null;
      },
    );
  }
}