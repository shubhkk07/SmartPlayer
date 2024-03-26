import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartlisten/bloc/add_remove_favourites/cubit/add_remove_favourites_cubit.dart';
import 'package:smartlisten/bloc/fav_song/bloc/favsongs_bloc.dart';
import 'package:smartlisten/bloc/song_bloc/bloc/song_bloc.dart';
import 'package:smartlisten/model/song_model.dart';

class FavouriteIconWidget extends StatelessWidget {
  final SongModel songModel;
  const FavouriteIconWidget({super.key, required this.songModel});

  @override
  Widget build(BuildContext context) {
    context.read<AddRemoveFavouritesCubit>().checkSongIsFavourite(songModel, songs: context.read<FavsongsBloc>().favSongs);
    return BlocConsumer<AddRemoveFavouritesCubit, AddRemoveFavouritesState>(
      listenWhen: (previous, current) {
        if (previous is AddedToFavourites && current is RemoveFromFavourites) {
          return true;
        }
        return false;
      },
      listener: (context, state) {
        if (BlocProvider.of<FavsongsBloc>(context).state is FavSongLoaded) {
          BlocProvider.of<FavsongsBloc>(context).add(FavouiteSongsList());
          BlocProvider.of<SongBloc>(context).add(FetchAllSongs(songModel: songModel));
        }
      },
      buildWhen: (previous, current) {
        if (previous != current) {
          return true;
        } else {
          return false;
        }
      },
      builder: (context, state) {
        if (state is AddedToFavourites) {
          return IconButton(
              onPressed: () async {
                try {
                  context.read<AddRemoveFavouritesCubit>().removeFromFavourites(songModel);
                  context.read<FavsongsBloc>().favSongs.remove(songModel);
                } catch (e) {
                  throw e.toString();
                }
              },
              icon: const Icon(
                Icons.favorite,
                color: Colors.red,
              ));
        } else {
          return IconButton(
              onPressed: () async {
                try {
                  context.read<AddRemoveFavouritesCubit>().addToFavourites(songModel);
                  context.read<FavsongsBloc>().favSongs.add(songModel);
                } catch (e) {
                  throw e.toString();
                }
              },
              icon: const Icon(Icons.favorite_border_outlined));
        }
      },
    );
  }
}
