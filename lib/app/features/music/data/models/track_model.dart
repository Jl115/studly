class Track {
  final String id;
  final String title;
  final String artist;
  final String album;
  final int duration; // Duration in seconds

  Track({
    required this.id,
    required this.title,
    required this.artist,
    required this.album,
    required this.duration,
  });

  factory Track.fromJson(Map<String, dynamic> json) {
    return Track(
      id: json['id'],
      title: json['title'],
      artist: json['artist'],
      album: json['album'],
      duration: json['duration'],
    );
  }
}
