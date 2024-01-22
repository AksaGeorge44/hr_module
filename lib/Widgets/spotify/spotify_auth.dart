import 'dart:async';
import 'dart:convert';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:http/http.dart' as http;

class SpotifyAuth {
  final String clientId;
  final String clientSecret;
  final String redirectUri;

  SpotifyAuth({
    required this.clientId,
    required this.clientSecret,
    required this.redirectUri,
  });

  Future<String?> authenticate() async {
    final authorizationUrl = buildAuthorizationUrl();

    final flutterWebviewPlugin = FlutterWebviewPlugin();
    flutterWebviewPlugin.launch(authorizationUrl);

    print('WebView launched: $authorizationUrl');

    final completer = Completer<String>();
    bool isCompleted = false;

    final onUrlChangedSubscription = flutterWebviewPlugin.onUrlChanged.listen((String url) async {
      print('URL changed: $url');

      if (url.startsWith(redirectUri)) {
        flutterWebviewPlugin.close();

        final String authorizationCode = getAuthorizationCodeFromUrl(Uri.parse(url));

        try {
          final String accessToken = await exchangeAuthorizationCodeForToken(authorizationCode);
          completer.complete(accessToken);
        } catch (error) {
          completer.completeError(error);
        }
      }
    });

    try {
      return await completer.future;
    } catch (error) {
      print('Authentication failed: $error');
      return null;
    } finally {
      onUrlChangedSubscription.cancel();
    }
  }

  String buildAuthorizationUrl() {
    return 'https://accounts.spotify.com/authorize?client_id=$clientId&redirect_uri=$redirectUri&response_type=code&scope=user-read-private%20user-read-email';
  }

  String getAuthorizationCodeFromUrl(Uri uri) {
    return uri.queryParameters['code'] ?? '';
  }

  Future<String> exchangeAuthorizationCodeForToken(String authorizationCode) async {
    try {
      final response = await http.post(
        Uri.parse('https://accounts.spotify.com/api/token'),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {
          'grant_type': 'authorization_code',
          'code': authorizationCode,
          'redirect_uri': redirectUri,
          'client_id': clientId,
          'client_secret': clientSecret,
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return data['access_token'];
      } else {
        throw 'Token exchange failed: ${response.reasonPhrase}';
      }
    } catch (error) {
      throw 'Token exchange error: $error';
    }
  }
}
