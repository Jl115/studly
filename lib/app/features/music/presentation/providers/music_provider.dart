import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../../data/models/track_model.dart';

class MusicProvider extends ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();
  List<Track> _playlist = [];
  Track? _currentTrack;
  bool _isPlaying = false;

  List<Track> get playlist => _playlist;
  Track? get currentTrack => _currentTrack;
  bool get isPlaying => _isPlaying;

  Future<void> loadPlaylist(List<Track> tracks) async {
    _playlist = tracks;
    notifyListeners();
  }

  Future<void> playTrack(Track track) async {
    _currentTrack = track;
    await _audioPlayer.play(UrlSource(track.id)); // Assuming track.id is a URL
    _isPlaying = true;
    notifyListeners();
  }

  Future<void> pause() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  Future<void> resume() async {
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
    _isPlaying = false;
    _currentTrack = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
