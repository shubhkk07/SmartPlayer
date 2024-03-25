part of 'song_bloc.dart';

@immutable
sealed class SongState {}

final class SongInitial extends SongState {}

final class SongLoading extends SongState {}

final class SongListLoaded extends SongState {
  final List<SongModel> songList;
  final SongModel? songModel;

  SongListLoaded({this.songModel, required this.songList});
}

final class SongListErrorState extends SongState {
  final String error;
  SongListErrorState(this.error);
}
