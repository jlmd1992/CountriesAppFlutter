/// Main Entity for app, 3 properties are required and 1 optional
class Country {
  final String name;
  final String capital;
  final String description;
  final String? population;

  Country({
    required this.name,
    required this.capital,
    required this.description,
    this.population
  });

  /// Method to convert to class Country from json
  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name'],
      capital: json['capital'],
      description: json['description'],
      population: json['population'],
    );
  }
}