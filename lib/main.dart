import 'package:flutter/material.dart';
import 'package:hearbooks/locator.dart';
import 'package:hearbooks/ui/views/home_view.dart';

import 'ui/app_router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(),
        initialRoute: '/',
        home: const HomeView(),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
