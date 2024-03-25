import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartlisten/model/song_model.dart';
import 'package:smartlisten/repository/song_repo/song_repo.dart';

part 'song_event.dart';
part 'song_state.dart';

class SongBloc extends Bloc<SongEvent, SongState> {
  final SongRepo songRepo = SongRepo();
  final List<SongModel> songs = [];

  SongBloc() : super(SongInitial()) {
    on<FetchNewSongs>((event, emit) async {
      try {
        await getAllSongs(event.term);
        emit(SongListLoaded(songList: songs));
      } catch (e) {
        print(e.toString());
        emit(SongListErrorState(e.toString()));
      }
    });

    on<FetchAllSongs>((event, emit) {
      emit(SongLoading());
      emit(SongListLoaded(songList: songs, songModel: event.songModel));
    });
  }

  getAllSongs(String? term) async {
    final songsList = await songRepo.getSongs(term: term);
    songs.addAll(songsList);
  }
}
