import 'package:youtube_player_flutter/youtube_player_flutter.dart';

abstract class PlayerState {
   PlayerState();

  factory PlayerState.loading() =>  LoadingState();

  factory PlayerState.playing(YoutubePlayerController controller) =>
      PlayingState(controller);

  factory PlayerState.paused(YoutubePlayerController controller) =>
      PausedState(controller);

  factory PlayerState.stopped(YoutubePlayerController controller) =>
      StoppedState(controller);

}


class LoadingState extends PlayerState {
   LoadingState();
}

class PlayingState extends PlayerState {
  final YoutubePlayerController controller;

   PlayingState(this.controller);
}

class PausedState extends PlayerState {
  final YoutubePlayerController controller;

   PausedState(this.controller);
}

class StoppedState extends PlayerState {
  final YoutubePlayerController controller;

   StoppedState(this.controller);
}





