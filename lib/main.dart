import 'package:countries_app/config/routes.dart';
import 'package:countries_app/domain/usecase/add_country_use_case.dart';
import 'package:countries_app/domain/usecase/delete_country_use_case.dart';
import 'package:countries_app/domain/usecase/get_countries_use_case.dart';
import 'package:countries_app/domain/usecase/update_country_use_case.dart';
import 'package:countries_app/infrastructure/repository/country_repository.dart';
import 'package:countries_app/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  final repository = CountryRepository();
  runApp(MyApp(repository: repository));
}

class MyApp extends StatelessWidget {
  final CountryRepository repository;

  late final GetCountriesUseCase getCountries;
  late final AddCountryUseCase addCountry;
  late final UpdateCountryUseCase updateCountry;
  late final DeleteCountryUseCase deleteCountry;

  MyApp({super.key, required this.repository}){  
    getCountries = GetCountriesUseCase(repository);
    addCountry = AddCountryUseCase(repository);
    updateCountry = UpdateCountryUseCase(repository);
    deleteCountry = DeleteCountryUseCase(repository);
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
      onGenerateRoute: Routes.generateRoute, 
      initialRoute: Routes.homeScreen,
      home: HomeScreen(getCountriesUseCase: getCountries, addCountryUseCase: addCountry, updateCountryUseCase: updateCountry, deleteCountryUseCase: deleteCountry),
    );
  }
}
