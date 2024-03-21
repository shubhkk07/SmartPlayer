import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartlisten/bloc/song_bloc/bloc/song_bloc.dart';
import 'package:smartlisten/model/song_model.dart';
import 'package:smartlisten/view/SongView/song_tile.dart';

class SongSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back_ios));
  }

  @override
  Widget buildResults(BuildContext context) {
    final allSongs = BlocProvider.of<SongBloc>(context).songs;

    final List<SongModel> filteredSongs = [];

    for (var song in allSongs) {
      if (song.trackName!.toLowerCase().contains(query.toLowerCase())) {
        filteredSongs.add(song);
      }
    }

    return ListView.builder(
        itemCount: filteredSongs.length,
        itemBuilder: (context, index) {
          return SongTile(song: filteredSongs[index]);
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final allSongs = BlocProvider.of<SongBloc>(context).songs;

    final List<SongModel> filteredSongs = [];

    for (var song in allSongs) {
      if (song.trackName!.toLowerCase().contains(query.toLowerCase())) {
        filteredSongs.add(song);
      }
    }

    if (query.isNotEmpty) {
      if (filteredSongs.isNotEmpty) {
        return ListView.builder(
            itemCount: filteredSongs.length,
            itemBuilder: (context, index) {
              return SongTile(song: filteredSongs[index]);
            });
      } else {
        return const Center(
          child: Text("No Results Found"),
        );
      }
    } else {
      return const SizedBox();
    }
  }
}
