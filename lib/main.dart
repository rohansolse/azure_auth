import 'package:azure_auth/constants.dart';
import 'package:azure_auth/home_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        title: AzureConstants.appTitle,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(title: AzureConstants.homeTitle, navigatorKey: navigatorKey),
        navigatorKey: navigatorKey,
      ),
    );
  }
}
