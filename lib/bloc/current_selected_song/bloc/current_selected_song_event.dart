part of 'current_selected_song_bloc.dart';

@immutable
sealed class CurrentSelectedSongEvent {}

final class PlayNextSong extends CurrentSelectedSongEvent {
  final List<SongModel> songs;

  PlayNextSong({required this.songs});
}

final class PlayPreviousSong extends CurrentSelectedSongEvent {
  final List<SongModel> songs;

  PlayPreviousSong({required this.songs});
}

final class SelectSong extends CurrentSelectedSongEvent {
  final SongModel songModel;

  SelectSong({required this.songModel});
}
