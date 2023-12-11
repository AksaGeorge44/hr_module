import 'dart:convert';

import 'package:hr_module/podcast/podcastClass.dart';
import 'package:http/http.dart' as http;

class PodcastService {
  static const String baseUrl = 'https://itunes.apple.com/search';

  Future<List<Podcast>> fetchPodcasts(String searchTerm) async {
    final response = await http.get(Uri.parse('$baseUrl?term=$searchTerm&media=podcast'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final results = data['results'] as List<dynamic>;
      return results.map((podcastData) => Podcast.fromJson(podcastData)).toList();
    } else {
      throw Exception('Failed to fetch podcasts');
    }
  }
}