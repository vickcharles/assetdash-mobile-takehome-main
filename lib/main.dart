import 'package:flutter/material.dart';
import 'screens/investments_screen.dart';

void main() {
  runApp(const MyApp());
}

// class MyAppColor extends ColorScheme {
//   MyAppColor({required Color primary}) : super(primary: primary,   secondary: primary,  surface: primary, background: primary, error: primary, onPrimary: primary, onSecondary: primary, onSurface: primary, onBackground: primary, onError: primary, brightness: Brightness.light)
// };

class MyApp extends StatelessWidget {
  final myColorScheme = const ColorScheme(
    primary: Color(0xFF21ce9a),
    secondary: Colors.white,
    surface: Color(0xFF999999),
    background: Color(0xFF222222),
    error: Colors.red,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: Colors.red,
    onBackground: Colors.red,
    onError: Colors.white,
    brightness: Brightness.light,
  );

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AssetsDash mobile takehome',
      theme: ThemeData(
        fontFamily: 'Inter',
        textTheme: const TextTheme(),
        colorScheme: myColorScheme,
      ),
      home: const InvestmentsScreen(),
    );
  }
}
