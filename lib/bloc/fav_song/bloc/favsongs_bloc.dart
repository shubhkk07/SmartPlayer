import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartlisten/model/song_model.dart';
import 'package:smartlisten/repository/save_fav.dart/save_fav.dart';
import 'package:smartlisten/view/favourite_song.dart/favourite_song.dart';

part 'favsongs_event.dart';
part 'favsongs_state.dart';

class FavsongsBloc extends Bloc<FavsongsEvent, FavsongsState> {
  final FavSongsRepo _favSongsRepo = FavSongsRepo();

  List<SongModel> favSongs = [];

  FavsongsBloc() : super(FavsongsInitial()) {
    on<FavouiteSongsList>((event, emit) async {
      emit(FavSongLoading());
      if (favSongs.isNotEmpty) {
        emit(FavSongLoaded(favSongs: favSongs));
      } else {
        final songs = await _favSongsRepo.getFavouriteSongsByUser();
        favSongs.addAll(songs);
        emit(FavSongLoaded(favSongs: favSongs));
      }
    });

    on<FavouiteSongsListFromFirestore>((event, emit) async {
      final songs = await _favSongsRepo.getFavouriteSongsByUser();
      favSongs.addAll(songs);
      emit(FavSongLoaded(favSongs: favSongs));
    });
  }
}
