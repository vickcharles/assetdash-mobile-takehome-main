import 'package:assetdash_takehome/presentation/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  final myColorScheme = const ColorScheme(
    primary: Color(0xFF21ce9a),
    secondary: Colors.white,
    surface: Color(0xFF999999),
    background: Color(0xFF222222),
    error: Colors.red,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: Color(0xFF999999),
    onBackground: Color(0xFF222222),
    onError: Colors.red,
    brightness: Brightness.light,
  );

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AssetsDash mobile takehome',
      theme: ThemeData(
        fontFamily: 'Poppins',
        textTheme: TextTheme(
          labelMedium: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: myColorScheme.secondary,
          ),
          headline5: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: myColorScheme.surface,
          ),
          headline6: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: myColorScheme.surface,
          ),
        ),
        colorScheme: myColorScheme,
      ),
      home: const InvestmentsScreen(),
    );
  }
}
