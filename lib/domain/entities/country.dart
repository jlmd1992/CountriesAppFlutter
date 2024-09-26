
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
}