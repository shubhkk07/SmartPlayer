import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartlisten/bloc/add_remove_favourites/cubit/add_remove_favourites_cubit.dart';
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
    context.read<AddRemoveFavouritesCubit>().checkSongIsFavourite(widget.songModel);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddRemoveFavouritesCubit, AddRemoveFavouritesState>(
      listener: (context, state) {
        print("state changes");
        context.read<SongBloc>().add(FetchAllSongs());
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
