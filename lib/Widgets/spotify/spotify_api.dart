import 'dart:convert';

import 'package:http/http.dart' as http;

class SpotifyAPI {
  final String accessToken;

  SpotifyAPI({required this.accessToken});

  Future<List<String>> getFeaturedPlaylists() async {
    final response = await http.get(
      Uri.parse('https://api.spotify.com/v1/browse/featured-playlists'),
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      print('API Response: $data'); // Add this line
      final List<dynamic> playlists = data['playlists']['items'];
      final List<String> playlistNames = playlists.map((playlist) => playlist['name'].toString()).toList();
      return playlistNames;
    } else {
      print('Failed to fetch featured playlists: ${response.body}');
      return [];
    }

  }
}
