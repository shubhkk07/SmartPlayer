import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartlisten/bloc/add_remove_favourites/cubit/add_remove_favourites_cubit.dart';
import 'package:smartlisten/bloc/current_selected_song/bloc/current_selected_song_bloc.dart';
import 'package:smartlisten/model/song_model.dart';
import 'package:smartlisten/view/SongView/detail.dart';
import 'package:smartlisten/view/SongView/fav_icon_widget.dart';

class SongTile extends StatelessWidget {
  final SongModel song;
  const SongTile({super.key, required this.song});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      isThreeLine: true,
      leading: CircleAvatar(
        backgroundImage: NetworkImage(song.artworkUrl30 ?? ''),
      ),
      title: Text(
        song.trackName ?? "Unknown",
        style: Theme.of(context).textTheme.titleMedium,
        maxLines: 1,
      ),
      subtitle: Text(
        song.artistName ?? "unknown",
        maxLines: 2,
      ),
      trailing: BlocProvider(
        create: (context) => AddRemoveFavouritesCubit(),
        child: FavouriteIconWidget(
          songModel: song,
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BlocProvider(
                      create: (context) => CurrentSelectedSongBloc()..add(SelectSong(songModel: song)),
                      child: const DetailView(),
                    )));
      },
    );
  }
}
