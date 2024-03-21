part of 'audio_control_bloc.dart';

@immutable
sealed class AudioControlEvent {}

final class PlaySong extends AudioControlEvent {
  final SongModel currentSong;
  PlaySong({required this.currentSong});
}

final class PauseSong extends AudioControlEvent {}

final class ResumeSong extends AudioControlEvent {}

final class SongCompleted extends AudioControlEvent {}

final class UpdateTimeDuration extends AudioControlEvent {}

final class UpdateSeekPositionDuration extends AudioControlEvent {}
