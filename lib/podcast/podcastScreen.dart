import 'package:flutter/material.dart';
import 'package:hr_module/podcast/podcastClass.dart';
import 'package:hr_module/podcast/service.dart';

class PodcastsScreen extends StatefulWidget {
  const PodcastsScreen({Key? key}) : super(key: key);

  @override
  _PodcastsScreenState createState() => _PodcastsScreenState();
}

class _PodcastsScreenState extends State<PodcastsScreen> {
  List<Podcast> podcasts = [];

  @override
  void initState() {
    super.initState();
    _fetchPodcasts();
  }

  void _fetchPodcasts() async {
    final podcastService = PodcastService();
    final fetchedPodcasts = await podcastService.fetchPodcasts('coding');
    setState(() {
      podcasts = fetchedPodcasts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Podcasts'),
      ),
      body: podcasts.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: podcasts.length,
        itemBuilder: (context, index) => PodcastCard(podcast: podcasts[index]),
      ),
    );
  }
}

class PodcastCard extends StatelessWidget {
  final Podcast podcast;

  const PodcastCard({
    Key? key,
    required

    this.podcast,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.network(podcast.imageUrl),
            const SizedBox(height: 16.0),
            Text(podcast.title, style: const TextStyle(fontSize: 20.0)),
            const SizedBox(height: 8.0),
            Text(podcast.description, style: const TextStyle(fontSize: 16.0)),
          ],
        ),
      ),
    );
  }
}