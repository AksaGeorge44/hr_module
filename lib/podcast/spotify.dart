import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String clientId = 'f0afec21668146c3bc22a74c717590b5';
  final String redirectUri = 'http://localhost:3000/callback';

  Future<void> _authenticateWithSpotify() async {
    final url =
        'https://accounts.spotify.com/authorize?client_id=$clientId&redirect_uri=$redirectUri&response_type=code&scope=user-read-private%20user-read-email';
    final result = await FlutterWebAuth.authenticate(
      url: url,
      callbackUrlScheme: redirectUri,
    );

    // Extract the authorization code from the result and use it to get an access token
    // (Note: In a production app, you would securely handle the client secret and token exchange server-side).
    final authorizationCode = Uri.parse(result).queryParameters['code'];
    final accessToken = await _exchangeCodeForAccessToken(authorizationCode!);

    // Now you can use the accessToken to make requests to the Spotify API
    print('Access Token: $accessToken');
  }

  Future<String> _exchangeCodeForAccessToken(String code) async {
    final tokenUrl = 'https://accounts.spotify.com/api/token';
    final response = await http.post(
      Uri.parse(tokenUrl),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'client_id': clientId,
        'client_secret': 'YOUR_SPOTIFY_CLIENT_SECRET',
        'redirect_uri': redirectUri,
        'code': code,
        'grant_type': 'authorization_code',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data['access_token'];
    } else {
      throw Exception('Failed to exchange code for access token');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Spotify Authentication'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _authenticateWithSpotify,
          child: Text('Authenticate with Spotify'),
        ),
      ),
    );
  }
}
