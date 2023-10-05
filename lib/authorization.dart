import 'package:aad_oauth/aad_oauth.dart';
import 'package:aad_oauth/model/config.dart';
import 'package:flutter/material.dart';

authorization(navigatorKey, String tenant, String clientId, String scope) {
  final Config config = Config(
    tenant: tenant,
    clientId: clientId,
    scope: scope,
    navigatorKey: navigatorKey,
    loader: const SizedBox(),
  );
  final AadOAuth oauth = AadOAuth(config);
  return oauth;
}
