import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:oauth2_client/spotify_oauth2_client.dart';

// Access Token Response Model
class AccessTokenResponse {
  final String accessToken;
  final String refreshToken;

  AccessTokenResponse({
    required this.accessToken,
    required this.refreshToken,
  });

  factory AccessTokenResponse.fromJson(Map<String, dynamic> json) {
    return AccessTokenResponse(
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
    );
  }

  Map<String, dynamic> toJson() => {
    "access_token": accessToken,
    "refresh_token": refreshToken,
  };

}

// Playlist Item Model
class PlaylistItem {
  // Add your necessary fields here (e.g., name, description, images)
  // ...
}

String Access_Token = "";
String Refresh_Token = "";

Future<void> RemoteService() async {
  // Client Configuration
  const String clientId = "f0afec21668146c3bc22a74c717590b5";
  const String clientSecret = "9ecaa1d53d78486b808c41b408a5fc0e";
  const String customUriScheme = "my.music.app"; // Change to your app's scheme
  const String redirectUri = "my.music.app://callback"; // Change to your app's callback URI

  // Spotify OAuth2 Client
  SpotifyOAuth2Client client = SpotifyOAuth2Client(
    customUriScheme: customUriScheme,
    redirectUri: redirectUri,
  );

  // User authorization request
  try {
    var authResp = await client.requestAuthorization(
      clientId: clientId,
      customParams: {'show_dialog': 'true'},
      scopes: [
        'user-read-private',
        'user-read-playback-state',
        'user-modify-playback-state',
        'user-read-currently-playing',
        'user-read-email',
      ],
    );

    // Get authorization code
    var authCode = authResp.code;

    // Request access token
    var tokenResponse = await client.requestAccessToken(
      code: authCode.toString(),
      clientId: clientId,
      clientSecret: clientSecret,
    );

    // Extract access and refresh tokens
    AccessTokenResponse accessToken = AccessTokenResponse.fromJson(tokenResponse as Map<String, dynamic>);
    // Store access and refresh tokens globally
    Access_Token = accessToken.accessToken;
    Refresh_Token = accessToken.refreshToken;

    print('Successfully authorized!');
  } catch (error) {
    print('Error during authorization: $error');
  }
}

Future<List<PlaylistItem>> FetchFeaturedPlaylists() async {
  if (Access_Token.isEmpty) {
    print('Please authorize first!');
    return [];
  }

  // Build request headers
  var headers = {
    "content-type": "application/json",
    "authorization": "Bearer $Access_Token",
  };

  // Fetch featured playlists data
  try {
    var response = await http.get(
      Uri.parse("https://api.spotify.com/v1/browse/featured-playlists"),
      headers: headers,
    );

    // Decode JSON data
    var featuredData = json.decode(response.body);

    // Extract playlists
    var featuredPlaylist = featuredData["playlists"];
    List<PlaylistItem> listOfFeaturedItems = [];

    for (var item in featuredPlaylist["items"]) {
      // Use appropriate fields from the item to create PlaylistItem objects
      // ...
      listOfFeaturedItems.add(PlaylistItem(/* ... */));
    }

    return listOfFeaturedItems;
  } catch (error) {
    print('Error fetching playlists: $error');
    return [];
  }
}
