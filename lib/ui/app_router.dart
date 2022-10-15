import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:hearbooks/ui/views/home_view.dart';
import 'package:hearbooks/ui/views/read_view.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomeView());
      case 'home':
        return MaterialPageRoute(builder: (_) => const HomeView());
      case 'reader':
        return fadeRouteTransition(builder: (_) => const ReadView());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route found for ${settings.name}')),
          ),
        );
    }
  }
}

Route fadeRouteTransition({required Widget Function(BuildContext) builder}) {
  return PageRouteBuilder(
    pageBuilder: (BuildContext context, _, __) {
      return builder(context);
    },
    transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
      return FadeTransition(opacity: animation, child: child);
    },
    transitionDuration: Duration.zero,
  );
}
