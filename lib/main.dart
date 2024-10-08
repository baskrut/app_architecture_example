import 'package:app_architecture_example/ui/pages/home_page.dart';
import 'package:app_architecture_example/ui/pages/login_page.dart';
import 'package:app_architecture_example/ui/styling/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: appTheme,
      routes: {
        HomePage.id: (context) => const HomePage(),
        LoginPage.id: (context) => const LoginPage(),
      },
    );
  }
}
