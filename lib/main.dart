import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:stock_app/data/source/local/company_listing_entity.dart';
import 'package:stock_app/util/color_schemes.dart';

void main() {
  Hive.registerAdapter(CompanyListingEntityAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: darkColorScheme,
      ),
      themeMode: ThemeMode.system,
      home: Scaffold(
        appBar: AppBar(),
        body: Container(),
      ),
    );
  }
}
