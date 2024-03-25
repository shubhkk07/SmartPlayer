import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartlisten/model/song_model.dart';
import 'package:smartlisten/repository/save_fav.dart/save_fav.dart';

part 'favsongs_event.dart';
part 'favsongs_state.dart';

class FavsongsBloc extends Bloc<FavsongsEvent, FavsongsState> {
  final FavSongsRepo _favSongsRepo = FavSongsRepo();

  List<SongModel>? favSongs;

  FavsongsBloc() : super(FavsongsInitial()) {
    on<FavouiteSongsList>((event, emit) async {
      emit(FavSongLoading());
      favSongs = await _favSongsRepo.getFavouriteSongsByUser();
      emit(FavSongLoaded(favSongs: favSongs ?? []));
    });
  }
}
