import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartlisten/bloc/add_remove_favourites/cubit/add_remove_favourites_cubit.dart';
import 'package:smartlisten/bloc/audio_control/bloc/audio_control_bloc.dart';
import 'package:smartlisten/bloc/current_selected_song/bloc/current_selected_song_bloc.dart';
import 'package:smartlisten/bloc/song_bloc/bloc/song_bloc.dart';
import 'package:smartlisten/view/SongView/fav_icon_widget.dart';

class DetailView extends StatelessWidget {
  const DetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.all(20),
        child: BlocConsumer<CurrentSelectedSongBloc, CurrentSelectedSongState>(
          listener: (context, state) {
            context
                .read<AudioControlBloc>()
                .add(PlaySong(currentSong: context.read<CurrentSelectedSongBloc>().currentSelectedSong!));
          },
          builder: (context, state) {
            if (state is LoadingNewSong) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is SelectedSongFetched) {
              return Column(
                children: [
                  ListTile(
                    leading: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back_ios)),
                    title: Text(
                      state.songModel.trackName ?? "Unknown",
                      maxLines: 1,
                      overflow: TextOverflow.clip,
                    ),
                    titleAlignment: ListTileTitleAlignment.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        backgroundBlendMode: BlendMode.color,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            offset: const Offset(
                              5.0,
                              5.0,
                            ),
                            blurRadius: 10.0,
                            spreadRadius: 12.0,
                          ),
                          const BoxShadow(color: Colors.white, spreadRadius: 0),
                        ]),
                    child: Column(
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image(image: NetworkImage(state.songModel.artworkUrl100 ?? "", scale: 0.3))),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: ListTile(
                                isThreeLine: true,
                                title: Text(
                                  state.songModel.trackName ?? "",
                                  overflow: TextOverflow.clip,
                                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w600),
                                ),
                                subtitle: Text(
                                  state.songModel.artistName ?? "",
                                  style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.black.withOpacity(0.5)),
                                  maxLines: 2,
                                ),
                              ),
                            ),
                            BlocProvider(
                              create: (context) => AddRemoveFavouritesCubit(),
                              child: FavouriteIconWidget(
                                songModel: state.songModel,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  StreamBuilder(
                      stream: BlocProvider.of<AudioControlBloc>(context).positionStream,
                      builder: ((context, snapshot) {
                        if (snapshot.hasData) {
                          final currrentDuration = ((snapshot.data?.inSeconds ?? 0) / 100).toStringAsPrecision(2);
                          return Column(
                            children: [
                              Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [Text(currrentDuration), const Text("0.30")],
                                  )),
                              SliderTheme(
                                data: SliderTheme.of(context)
                                    .copyWith(thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 5)),
                                child: Slider(
                                    activeColor: Colors.green,
                                    inactiveColor: Colors.black,
                                    value: (snapshot.data?.inSeconds)?.toDouble() ?? 0,
                                    max: 30,
                                    min: 0,
                                    // activeColor: Theme.of(context).colorScheme.background,
                                    onChangeEnd: (value) {},
                                    onChanged: (val) {
                                      BlocProvider.of<AudioControlBloc>(context).seekTo(Duration(seconds: val.toInt()));
                                    }),
                              )
                            ],
                          );
                        } else {
                          return const SizedBox();
                        }
                      })),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                          padding: const EdgeInsets.all(1),
                          // style: AppTheme.lightTheme.iconButtonTheme.style,
                          onPressed: () {
                            //pass song list here
                            context
                                .read<CurrentSelectedSongBloc>()
                                .add(PlayPreviousSong(songs: BlocProvider.of<SongBloc>(context).songs));
                          },
                          icon: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  offset: const Offset(
                                    1.0,
                                    1.0,
                                  ),
                                  blurRadius: 10.0,
                                  spreadRadius: 7.0,
                                ),
                                const BoxShadow(color: Colors.white, spreadRadius: 0),
                              ]),
                              child: const Icon(Icons.skip_previous_rounded))),
                      BlocBuilder<AudioControlBloc, AudioControlState>(
                        buildWhen: (previous, current) {
                          if (previous is AudioPlayedState && current is AudioPlayedState) {
                            return false;
                          } else {
                            return true;
                          }
                        },
                        builder: (context, state) {
                          return IconButton(
                              padding: const EdgeInsets.all(1),
                              onPressed: () async {
                                if (state is AudioPausedState) {
                                  BlocProvider.of<AudioControlBloc>(context).add(ResumeSong());
                                } else {
                                  BlocProvider.of<AudioControlBloc>(context).add(PauseSong());
                                }
                              },
                              icon: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      offset: const Offset(
                                        1.0,
                                        1.0,
                                      ),
                                      blurRadius: 10.0,
                                      spreadRadius: 7.0,
                                    ),
                                    const BoxShadow(color: Colors.white, spreadRadius: 0),
                                  ]),
                                  child: state is AudioPlayedState
                                      ? const Icon(Icons.pause)
                                      : const Icon(Icons.play_arrow_rounded)));
                        },
                      ),
                      IconButton(
                          padding: const EdgeInsets.all(1),
                          onPressed: () {
                            context
                                .read<CurrentSelectedSongBloc>()
                                .add(PlayNextSong(songs: BlocProvider.of<SongBloc>(context).songs));
                          },
                          icon: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  offset: const Offset(
                                    1.0,
                                    1.0,
                                  ),
                                  blurRadius: 10.0,
                                  spreadRadius: 7.0,
                                ),
                                const BoxShadow(color: Colors.white, spreadRadius: 0),
                              ]),
                              child: const Icon(Icons.skip_next_rounded)))
                    ],
                  )
                ],
              );
            } else {
              return const Center(child: Text('Something went wrong'));
            }
          },
        ),
      ),
    );
  }
}
