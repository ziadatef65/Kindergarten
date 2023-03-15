import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kindergarten1/layout/cubit/cubit.dart';
import 'package:line_icons/line_icon.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../edit_user/edit_user_screen.dart';
import '../selected_course_screen/cubit/cubit.dart';

class SelectedVideoScreen extends StatelessWidget {
  final alphabetListVideo;
  final nameOfCourse;
  final colorOfCourse;
  final index;
  final imageOfcourse;

  SelectedVideoScreen(this.alphabetListVideo,this.nameOfCourse,this.colorOfCourse,this.index,this.imageOfcourse);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
          statusBarColor: CupertinoColors.white,
          statusBarIconBrightness: Brightness.dark),
      child: Scaffold(
        backgroundColor: colorOfCourse,
        body: Container(
          child: BlocProvider(
            create: (BuildContext context) => PlayerCubit(alphabetListVideo),
            child: BlocBuilder<PlayerCubit, YoutubePlayerController>(
                builder: (context, controller) {
              return Column(

                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Container(

                      width: double.infinity,
                      color: colorOfCourse,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          nameOfCourse,
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 480,
                    child: Stack(
                      children: [
                        Container(
                          height: 200,
                          width: double.infinity,
                          decoration:BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(imageOfcourse),
                              fit: BoxFit.fitWidth,
                            )
                          ) ,
                        ),


                        Align(
                          alignment: AlignmentDirectional.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Container(
                              decoration: BoxDecoration(

                                  color: colorOfCourse,
                                  border: Border.all(width: 1),
                                  borderRadius: BorderRadius.circular(30)),
                              height: 300,
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Video-${index +1}',
                                      style: GoogleFonts.poppins(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,

                                      ),
                                    ),
                                    SizedBox(height: 20,),
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(30),
                                          border: Border.all(width: 5)
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(25),

                                        child: YoutubePlayer(
                                          controller: controller,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
