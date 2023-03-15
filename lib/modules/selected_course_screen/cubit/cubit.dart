import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kindergarten1/modules/selected_course_screen/cubit/states.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PlayerCubit extends Cubit<YoutubePlayerController> {
  static PlayerCubit get(context) => BlocProvider.of(context);

  PlayerCubit(String videoId)
      : super(YoutubePlayerController(
          initialVideoId: '${videoId}',
          flags: const YoutubePlayerFlags(
            autoPlay: true,
            controlsVisibleAtStart: true,
            loop: true,

          ),
        ));


  List<String> alphabetListVideos = [
    'hKEVDFIiqg4',
    '3UE2hhKHh5Y',
    'Gdt4IleVyA4',
    '_EILnBlzC-Y',
    'uRmw621DWak',
    'xxYLTePonE8',
    's9U_LUtQ_tw',
    'g186xKVq9p8',
    '4q6bKzMY3fw',
    'hKiovTfNF9c',
  ];


}
