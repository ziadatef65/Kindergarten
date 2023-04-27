import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kindergarten1/layout/cubit/cubit.dart';
import 'package:kindergarten1/modules/admin/cubit/cubit.dart';
import 'package:line_icons/line_icon.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../edit_user/edit_user_screen.dart';
import '../selected_course_screen/cubit/cubit.dart';

class SelectedVideoScreen extends StatelessWidget {
  final alphabetListVideo;
  final nameOfCourse;
  final colorOfCourse;
  final index;

  SelectedVideoScreen(this.alphabetListVideo, this.colorOfCourse, this.index, this.nameOfCourse );

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
          statusBarColor: CupertinoColors.white,
          statusBarIconBrightness: Brightness.dark),
      child: Scaffold(
        backgroundColor: colorOfCourse,
        body: BlocProvider(
          create: (BuildContext context) => PlayerCubit( AdminCubit.get(context).urls[index]  ),
          child: BlocBuilder<PlayerCubit, YoutubePlayerController>(
              builder: (context, controller) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if(nameOfCourse != 'الحروف الأبجدية')
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Container(
                      width: double.infinity,
                      color: colorOfCourse,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8,top: 20),
                        child:
                        Text(
                          nameOfCourse,
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                  ),

                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 222.6,
                          width: double.infinity,
                          child: YoutubePlayer(
                            controller: controller,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 390,
                          width: double.infinity,
                          decoration: BoxDecoration(border: Border.all(width: 1)),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Video-${index + 1}',
                                        style: GoogleFonts.poppins(
                                          fontSize: 24,
                                        ),
                                      ),


                                    ],
                                  ),
                                  SizedBox(height: 5,),
                                  Container(
                                    width: double.infinity,
                                    height: 1,
                                    color: Colors.black,
                                  ),
                                  SizedBox(height: 5,),
                                  Text(
                                    'Description :',
                                    style: GoogleFonts.poppins(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 15,),
                                  Text(
                                    '${AdminCubit.get(context).description[index]}',
                                    style: GoogleFonts.poppins(
                                      fontSize: 18,

                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
