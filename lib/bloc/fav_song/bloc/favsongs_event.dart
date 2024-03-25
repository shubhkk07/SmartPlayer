part of 'favsongs_bloc.dart';

@immutable
sealed class FavsongsEvent {}

final class FavouiteSongsList extends FavsongsEvent {}

final class FavouiteSongsListFromFirestore extends FavsongsEvent {}
