import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartlisten/model/song_model.dart';
import 'package:smartlisten/repository/save_fav.dart/save_fav.dart';

part 'add_remove_favourites_state.dart';

class AddRemoveFavouritesCubit extends Cubit<AddRemoveFavouritesState> {
  AddRemoveFavouritesCubit() : super(AddRemoveFavouritesInitial());

  final FavSongsRepo _favSongsRepo = FavSongsRepo();

  void addToFavourites(SongModel song) {
    try {
      _favSongsRepo.addToFavouriteSongs(song);
      emit(AddedToFavourites(songModel: song));
    } catch (e) {
      throw e.toString();
    }
  }

  void removeFromFavourites(SongModel song) {
    try {
      _favSongsRepo.removeFromFavouriteSongs(song);
      emit(RemoveFromFavourites(songModel: song));
    } catch (e) {
      throw e.toString();
    }
  }

  void checkSongIsFavourite(SongModel songModel) async {
    final val = await _favSongsRepo.checkSongIsFavourite(songModel);
    if (val) {
      emit(AddedToFavourites(songModel: songModel));
    }
  }
}
