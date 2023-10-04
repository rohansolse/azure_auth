import 'package:aad_oauth/aad_oauth.dart';
import 'package:azure_auth/constants.dart';
import 'package:aad_oauth/model/config.dart';
import 'package:flutter/material.dart';

authorization(navigatorKey) {
  final Config config = Config(
    tenant: AzureConstants.tenentId,
    clientId: AzureConstants.clientId,
    scope: AzureConstants.scope,
    navigatorKey: navigatorKey,
    loader: const SizedBox(),
  );
  final AadOAuth oauth = AadOAuth(config);
  return oauth;
}
