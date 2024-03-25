import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartlisten/bloc/add_remove_favourites/cubit/add_remove_favourites_cubit.dart';
import 'package:smartlisten/bloc/fav_song/bloc/favsongs_bloc.dart';
import 'package:smartlisten/bloc/song_bloc/bloc/song_bloc.dart';
import 'package:smartlisten/model/song_model.dart';

class FavouriteIconWidget extends StatefulWidget {
  final SongModel songModel;
  const FavouriteIconWidget({super.key, required this.songModel});

  @override
  State<FavouriteIconWidget> createState() => _FavouriteIconWidgetState();
}

class _FavouriteIconWidgetState extends State<FavouriteIconWidget> {
  @override
  void initState() {
    checkSongFavouriteOrNot();
    super.initState();
  }

  checkSongFavouriteOrNot() {
    if (context.read<FavsongsBloc>().favSongs != null) {
      context.read<FavsongsBloc>().favSongs?.contains(widget.songModel);
      context.read<AddRemoveFavouritesCubit>().checkSongIsFavourite(widget.songModel, isFavourite: true);
    } else {
      context.read<AddRemoveFavouritesCubit>().checkSongIsFavourite(widget.songModel);
    }
  }

  // @override
  // void dispose() {
  //   context.read<AddRemoveFavouritesCubit>().close();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    checkSongFavouriteOrNot();
    return BlocConsumer<AddRemoveFavouritesCubit, AddRemoveFavouritesState>(
      listenWhen: (previous, current) {
        if (previous is AddedToFavourites) {
          return true;
        }
        return false;
      },
      listener: (context, state) {
        // BlocProvider.of<FavsongsBloc>(context).add(FavouiteSongsList());
        BlocProvider.of<SongBloc>(context).add(FetchAllSongs());
      },
      builder: (context, state) {
        if (state is AddedToFavourites) {
          return IconButton(
              onPressed: () async {
                try {
                  context.read<AddRemoveFavouritesCubit>().removeFromFavourites(widget.songModel);
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
                  context.read<AddRemoveFavouritesCubit>().addToFavourites(widget.songModel);
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
