import 'package:countries_app/domain/usecase/add_country.dart';
import 'package:countries_app/domain/usecase/delete_country.dart';
import 'package:countries_app/domain/usecase/get_countries.dart';
import 'package:countries_app/domain/usecase/update_country.dart';
import 'package:countries_app/infrastructure/repository/country_repository_impl.dart';
import 'package:countries_app/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  final repository = CountryRepositoryImpl();
  runApp(MyApp(repository: repository));
}

class MyApp extends StatelessWidget {
  final CountryRepositoryImpl repository;

  late final GetCountries getPaises;
  late final AddCountry addCountry;
  late final UpdateCountry updateCountry;
  late final DeleteCountry deleteCountry;

  MyApp({super.key, required this.repository}){  
    getPaises = GetCountries(repository);
    addCountry = AddCountry(repository);
    updateCountry = UpdateCountry(repository);
    deleteCountry = DeleteCountry(repository);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Countries Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: HomeScreen(getCountries: getPaises, addCountry: addCountry, updateCountry: updateCountry, deleteCountry: deleteCountry),
    );
  }
}
