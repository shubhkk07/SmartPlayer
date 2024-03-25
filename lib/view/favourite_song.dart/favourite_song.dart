import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartlisten/bloc/fav_song/bloc/favsongs_bloc.dart';
import 'package:smartlisten/view/SongView/song_tile.dart';

class FavouriteSongs extends StatefulWidget {
  const FavouriteSongs({super.key});

  @override
  State<FavouriteSongs> createState() => _FavouriteSongsState();
}

class _FavouriteSongsState extends State<FavouriteSongs> {
  @override
  void initState() {
    context.read<FavsongsBloc>().add(FavouiteSongsList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text("Favourite Songs"),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(20),
        child: BlocBuilder<FavsongsBloc, FavsongsState>(
          builder: (context, state) {
            if (state is FavSongLoaded) {
              if (state.favSongs.isNotEmpty) {
                return ListView.builder(
                    itemCount: state.favSongs.length,
                    itemBuilder: (context, index) {
                      return SongTile(song: state.favSongs.elementAt(index));
                    });
              } else {
                return const Center(
                  child: Text("No Favourites Song"),
                );
              }
            } else if (state is FavSongLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return const Center(
                child: Text("No Favourite Songs"),
              );
            }
          },
        ),
      ),
    );
  }
}
