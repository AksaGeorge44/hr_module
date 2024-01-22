
// spotify_api.dart

import 'dart:convert';
import 'package:http/http.dart' as http;

class SpotifyData {
  final String playlistName;
  final String playlistImageUrl;
  final String trackName;
  final String artistName;
  final String trackImageUrl;

  SpotifyData({
    required this.playlistName,
    required this.playlistImageUrl,
    required this.trackName,
    required this.artistName,
    required this.trackImageUrl,
  });
}

Future<List<SpotifyData>> fetchDataFromSpotifyApi(String accessToken) async {
  try {
    final response = await http.get(
      Uri.parse('https://api.spotify.com/v1/me/playlists'),
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> playlistData = json.decode(response.body)['items'];
      return List<SpotifyData>.from(playlistData.map((item) {
        return SpotifyData(
          playlistName: item['name'],
          playlistImageUrl: item['images'][0]['url'],
          trackName: '', // You may want to modify this based on your actual requirements
          artistName: '',
          trackImageUrl: '',
        );
      }));
    } else {
      throw Exception('Failed to fetch data from Spotify API: ${response.reasonPhrase}');
    }
  } catch (error) {
    throw Exception('Error fetching data from Spotify API: $error');
  }
}

