import 'package:countries_app/config/routes.dart';
import 'package:countries_app/domain/usecase/add_country_use_case.dart';
import 'package:countries_app/domain/usecase/delete_country_use_case.dart';
import 'package:countries_app/domain/usecase/get_countries_use_case.dart';
import 'package:countries_app/domain/usecase/update_country_use_case.dart';
import 'package:countries_app/infrastructure/repository/country_repository.dart';
import 'package:countries_app/presentation/providers/detail_provider.dart';
import 'package:countries_app/presentation/providers/form_provider.dart';
import 'package:countries_app/presentation/providers/home_provider.dart';
import 'package:countries_app/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  final repository = CountryRepository();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeProvider(getCountriesUseCase: GetCountriesUseCase(repository))),
        ChangeNotifierProvider(create: (_) => FormProvider(addCountryUseCase: AddCountryUseCase(repository), updateCountryUseCase: UpdateCountryUseCase(repository))),
        ChangeNotifierProvider(create: (_) => DetailProvider(addCountryUseCase: AddCountryUseCase(repository), updateCountryUseCase: UpdateCountryUseCase(repository), deleteCountryUseCase: DeleteCountryUseCase(repository))),
      ],
      child: const MyApp()
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      home: const HomeScreen(),
    );
  }
}
