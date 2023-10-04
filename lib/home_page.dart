// ignore_for_file: use_build_context_synchronously, prefer_typing_uninitialized_variables
import 'package:azure_auth/authorization.dart';
import 'package:azure_auth/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title, required this.navigatorKey});
  final String title;
  final navigatorKey;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final oauth = authorization(navigatorKey);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text(
              'AzureAD OAuth',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.launch),
            title: const Text('Login${kIsWeb ? ' (web popup)' : ''}'),
            onTap: () {
              login(false);
            },
          ),
          if (kIsWeb)
            ListTile(
              leading: const Icon(Icons.launch),
              title: const Text('Login (web redirect)'),
              onTap: () {
                login(true);
              },
            ),
          ListTile(
            leading: const Icon(Icons.data_array),
            title: const Text('HasCachedAccountInformation'),
            onTap: () => hasCachedAccountInformation(),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              logout();
            },
          ),
        ],
      ),
    );
  }

  void showError(dynamic ex) {
    showMessage(ex.toString());
  }

  void showMessage(String text) {
    var alert = AlertDialog(content: Text(text), actions: <Widget>[
      TextButton(
          child: const Text('Ok'),
          onPressed: () {
            Navigator.pop(context);
          })
    ]);
    showDialog(context: context, builder: (BuildContext context) => alert);
  }

  void login(bool redirect) async {
    final result = await oauth.login();
    result.fold(
      (l) => showError(l.toString()),
      (r) => showMessage('Logged in successfully, your access token: $r'),
    );
    var accessToken = await oauth.getAccessToken();
    if (accessToken != null) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(accessToken)));
    }
  }

  void hasCachedAccountInformation() async {
    var hasCachedAccountInformation = await oauth.hasCachedAccountInformation;
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('HasCachedAccountInformation: $hasCachedAccountInformation'),
      ),
    );
  }

  void logout() async {
    await oauth.logout();
    showMessage('Logged out');
  }
}