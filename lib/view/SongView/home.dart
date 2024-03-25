import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartlisten/bloc/add_remove_favourites/cubit/add_remove_favourites_cubit.dart';
import 'package:smartlisten/bloc/song_bloc/bloc/song_bloc.dart';
import 'package:smartlisten/model/song_model.dart';
import 'package:smartlisten/view/Profile/profile.dart';
import 'package:smartlisten/view/SongView/search_algo/song_search_delegate.dart';
import 'package:smartlisten/view/SongView/song_tile.dart';

import '../../constants/famous_artist.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      minimum: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Latest Arrivals",
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()));
                  },
                  child: const CircleAvatar(
                    backgroundColor: Colors.blue,
                    // user.displayName.substring(1,2)
                    child: Icon(Icons.personal_injury_outlined),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            canRequestFocus: false,
            onTap: () {
              showSearch(context: context, delegate: SongSearchDelegate());
            },
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 2, horizontal: 15),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                labelText: "Search for a song...",
                prefixIcon: const Icon(Icons.search),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black.withOpacity(0.1)), borderRadius: BorderRadius.circular(30))),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: BlocBuilder<SongBloc, SongState>(
              builder: (context, state) {
                if (state is SongInitial || state is SongLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is SongListLoaded) {
                  return NotificationListener(
                    onNotification: (notification) {
                      if (notification is ScrollEndNotification && notification.metrics.extentAfter == 0) {
                        if (state.songList.length < FamousArtist.artists.length * 10) {
                          final element = ((state.songList.length / 10) - 1).toInt();
                          BlocProvider.of<SongBloc>(context).add(FetchNewSongs(term: FamousArtist.artists[element]));
                        }
                      }
                      return false;
                    },
                    child: ListView.builder(
                        itemCount: state.songList.length,
                        itemBuilder: (context, index) {
                          final song = state.songList[index];
                          // return SongTile(song: song);
                          // BlocListener<AddRemoveFavouritesCubit, AddRemoveFavouritesState>(
                          //   listenWhen: (previous, current) {
                          //     if (previous is AddedToFavourites) {
                          //       return true;
                          //     }
                          //     return false;
                          //   },
                          //   listener: (context, state) {
                          //     context.read<AddRemoveFavouritesCubit>().checkSongIsFavourite(song);
                          //   },
                          //   child:

                          return BlocBuilder<SongBloc, SongState>(
                            buildWhen: (previous, current) {
                              if (current is SongListLoaded) {
                                return state.songModel == song ? true : false;
                              } else {
                                return false;
                              }
                            },
                            builder: (context, state) {
                              return SongTile(song: song);
                            },
                          );
                        }),
                  );
                } else {
                  return const Center(
                    child: Text("Something went wrong"),
                  );
                }
              },
            ),
          )
        ],
      ),
    ));
  }
}
