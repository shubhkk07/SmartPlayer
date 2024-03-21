part of 'add_remove_favourites_cubit.dart';

@immutable
sealed class AddRemoveFavouritesState {}

final class AddRemoveFavouritesInitial extends AddRemoveFavouritesState {}

final class AddedToFavourites extends AddRemoveFavouritesState {
  final SongModel songModel;

  AddedToFavourites({required this.songModel});
}

final class RemoveFromFavourites extends AddRemoveFavouritesState {
  final SongModel songModel;

  RemoveFromFavourites({required this.songModel});
}
