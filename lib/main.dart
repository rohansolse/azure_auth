import 'package:azure_auth/azure_auth.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AAD OAuth Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AzureAuth(title: 'AAD OAuth Home', navigatorKey: navigatorKey),
      navigatorKey: navigatorKey,
    );
  }
}
