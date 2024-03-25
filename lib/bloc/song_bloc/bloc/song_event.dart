part of 'song_bloc.dart';

@immutable
sealed class SongEvent {}

final class FetchNewSongs extends SongEvent {
  final String? term;

  FetchNewSongs({this.term});
}

final class FetchAllSongs extends SongEvent {
  final SongModel? songModel;

  FetchAllSongs({required this.songModel});
}
