import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hr_module/Widgets/spotify/spotifyData.dart';

class SpotifyPage extends StatelessWidget {
  const SpotifyPage({Key? key, required this.accessToken}) : super(key: key);

  final String accessToken;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Spotify Clone'),
      ),
      body: FutureBuilder<List<SpotifyData>>(
        future: fetchDataFromSpotifyApi(accessToken), // Pass the access token here
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final List<SpotifyData> data = snapshot.data ?? [];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Featured Playlists
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Featured Playlists',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                if (data.isNotEmpty)
                  SizedBox(
                    height: 200,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        for (var playlist in data)
                          PlaylistCard(playlist.playlistName, playlist.playlistImageUrl),
                      ],
                    ),
                  ),
                // Recent Tracks
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Recent Tracks',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                    ),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return TrackCard(
                        data[index].trackName,
                        data[index].artistName,
                        data[index].trackImageUrl,
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),

    );
  }
}



class PlaylistCard extends StatelessWidget {
  final String name;
  final String imageUrl;

  const PlaylistCard(this.name, this.imageUrl, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 120,
            width: 180,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

class TrackCard extends StatelessWidget {
  final String name;
  final String artist;
  final String imageUrl;

  const TrackCard(this.name, this.artist, this.imageUrl, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 120,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
              ),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  artist,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
