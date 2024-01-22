import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hr_module/Widgets/spotify/spotify_ui.dart';
import 'spotify_auth.dart';
import 'package:http/http.dart' as http;


class SpotifyApp extends StatelessWidget {
  final SpotifyAuth spotifyAuth = SpotifyAuth(
    clientId: '49fa6755a0534241a67a11291068a491',
    clientSecret: 'd75fed40f0cf457a8de64fe2ddb70532',
    redirectUri: 'http://localhost:8888/callback', // Use the same redirect URI as in your Spotify Developer Dashboard
  );

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Spotify Clone'),
        ),
        body:  Center(
          child: ElevatedButton(
            onPressed: () async {
              try {
                final accessToken = await spotifyAuth.authenticate();
                if (accessToken != null) {
                  print('Access Token: $accessToken');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  SpotifyPage(accessToken: '$accessToken'),
                    ),
                  );
                }
              } catch (error) {
                // Handle authentication error
                print('Authentication error: $error');
              }
            },
            child: const Text('Authenticate with Spotify'),
          ),
        ),
      ),
    );
  }

  Future<void> fetchUserProfile(String accessToken) async {
    try {
      final response = await http.get(
        Uri.parse('https://api.spotify.com/v1/me'),
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        print('User Profile: $data');
      } else {
        print('Failed to get user profile: ${response.reasonPhrase}');
      }
    } catch (error) {
      print('Error fetching user profile: $error');
    }
  }

  Future<void> fetchUserPlaylists(String accessToken) async {
    try {
      print('Fetching playlists with Access Token: $accessToken');
      final response = await http.get(
        Uri.parse('https://api.spotify.com/v1/me/playlists'),
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> playlists = data['items'];
        print('User Playlists: $playlists');
      } else {
        print('Failed to get user playlists: ${response.reasonPhrase}');
        // Handle the error here and possibly show an error message to the user
      }
    } catch (error) {
      print('Error fetching user playlists: $error');
      // Handle the error here and possibly show an error message to the user
    }
  }
}
