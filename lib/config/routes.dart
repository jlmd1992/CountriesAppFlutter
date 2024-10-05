import 'package:countries_app/presentation/screens/details_screen.dart';
import 'package:countries_app/presentation/screens/form_screen.dart';
import 'package:countries_app/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String homeScreen = '/';
  static const String detailsScreen = '/details';
  static const String formScreen = '/form';

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeScreen:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen()
        );
      case detailsScreen:
        if (settings.arguments is Map) {
          final args = settings.arguments as Map;
          return MaterialPageRoute(
            builder: (_) => DetailsScreen(
              country: args['country'], 
              index: args['index'],
            ),
          );
        }
      case formScreen:
        if (settings.arguments is Map) {
          final args = settings.arguments as Map;
          return MaterialPageRoute(
            builder: (_) => FormScreen(
              country: args['country'], 
              index: args['index'],
            ),
          );
        }
      default:
        return _errorRoute();
    }
    return _errorRoute();
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(child: Text('Route not found')),
      ),
    );
  }
}