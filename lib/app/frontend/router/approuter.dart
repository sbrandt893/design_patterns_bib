import 'package:design_patterns_bib/app/frontend/screens/design_pattern_examples.dart/cake_decorator_view.dart';
import 'package:design_patterns_bib/app/frontend/screens/home/home_view.dart';
import 'package:design_patterns_bib/app/frontend/screens/settings/settings_view.dart';
import 'package:flutter/material.dart';

enum Routes {
  home,
  settings,
  cakeDecoratorView,
}

class Approuter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'home':
        return MaterialPageRoute(builder: (_) => const HomeView());
      case 'settings':
        return MaterialPageRoute(builder: (_) => const SettingsView());
      case 'cakeDecoratorView':
        return MaterialPageRoute(builder: (_) => CakeDecoratorView());
      default:
        return MaterialPageRoute(builder: (context) => const HomeView());
    }
  }
}
