import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kindergarten1/layout/cubit/cubit.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

var cubit = KindergartenCubit();
class PlayerCubit extends Cubit<YoutubePlayerController> {
  static PlayerCubit get(context) => BlocProvider.of(context);

  PlayerCubit(dynamic videoId)
      : super(YoutubePlayerController(
          initialVideoId: '$videoId',
          flags: const YoutubePlayerFlags(
            autoPlay: true,
            controlsVisibleAtStart: true,
            loop: false,
          ),
        ));







}


