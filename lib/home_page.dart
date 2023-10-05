// ignore_for_file: use_build_context_synchronously, prefer_typing_uninitialized_variables
import 'package:azure_auth/authorization.dart';
import 'package:azure_auth/constants.dart';
import 'package:azure_auth/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.title,
    required this.navigatorKey,
  });
  final String title;
  final navigatorKey;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final oauth = authorization(
    navigatorKey,
    AzureConstants.tenentId,
    AzureConstants.clientId,
    AzureConstants.scope,
  );

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
              AzureConstants.azureAD,
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
              title: const Text(AzureConstants.loginWebRedirect),
              onTap: () {
                login(true);
              },
            ),
          ListTile(
            leading: const Icon(Icons.data_array),
            title: const Text(AzureConstants.hasCachedAccountInformation),
            onTap: () => hasCachedAccountInformation(),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text(AzureConstants.logout),
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
          child: const Text(AzureConstants.ok),
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
      (r) => showMessage('${AzureConstants.accessTokenText} $r'),
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
        content: Text('${AzureConstants.hasCachedAccountInformation}: $hasCachedAccountInformation'),
      ),
    );
  }

  void logout() async {
    await oauth.logout();
    showMessage(AzureConstants.loggedOut);
  }
}
