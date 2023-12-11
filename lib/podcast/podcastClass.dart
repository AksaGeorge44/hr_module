class Podcast {
  String title;
  String description;
  String imageUrl;
  String podcastUrl;

  Podcast({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.podcastUrl,
  });

  factory Podcast.fromJson(Map<String, dynamic> data) {
    return Podcast(
      title: data['trackName'],
      description: data['description'],
      imageUrl: data['artworkUrl600'],
      podcastUrl: data['feedUrl'],
    );
  }
}