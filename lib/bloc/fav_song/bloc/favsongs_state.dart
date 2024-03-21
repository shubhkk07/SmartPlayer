part of 'favsongs_bloc.dart';

@immutable
sealed class FavsongsState {}

final class FavsongsInitial extends FavsongsState {}

final class FavSongLoading extends FavsongsState {}

final class FavSongLoaded extends FavsongsState {}
