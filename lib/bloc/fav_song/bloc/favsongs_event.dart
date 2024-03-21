part of 'favsongs_bloc.dart';

@immutable
sealed class FavsongsEvent {}

final class FavouiteSongsList extends FavsongsEvent {
  final List<SongModel> favSongsList;

  FavouiteSongsList({required this.favSongsList});
}
