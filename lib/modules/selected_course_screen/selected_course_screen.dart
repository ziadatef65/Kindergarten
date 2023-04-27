import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kindergarten1/layout/cubit/cubit.dart';
import 'package:kindergarten1/layout/cubit/states.dart';
import 'package:kindergarten1/modules/admin/cubit/cubit.dart';
import 'package:kindergarten1/modules/quiz/quiz_screen.dart';
import 'package:kindergarten1/modules/selected_video_screen/selected_course_screen.dart';
import 'package:line_icons/line_icon.dart';
import '../edit_user/edit_user_screen.dart';

class SelectedCourseScreen extends StatelessWidget {
  final nameOfCourse;
  final imageOfCourse;
  Color colorOfCourse;

  SelectedCourseScreen(
    this.nameOfCourse,
    this.imageOfCourse,
    this.colorOfCourse,

  );

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<KindergartenCubit, KindergartenStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = KindergartenCubit.get(context).userModel;
        var cubit = KindergartenCubit.get(context);
        return Scaffold(
          backgroundColor: CupertinoColors.white,
          appBar: AppBar(
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Colors.white,
              ),
              backgroundColor: Colors.white,
              elevation: 0,
              leadingWidth: double.infinity,
              actions: [
                IconButton(
                  icon: LineIcon.userEdit(
                    color: Colors.amber,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditUserScreen()));
                  },
                ),
              ],
              leading: Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage('${userModel?.image}'),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Text('Hello, ${userModel?.childFullName}',
                            style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.black)),
                        Text('${userModel?.age}',
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              color: Colors.grey,
                            )),
                      ],
                    )
                  ],
                ),
              )),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Container(
                height: 1300,
                decoration: BoxDecoration(
                  color: colorOfCourse,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(width: 1),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                        Text(
                          nameOfCourse,
                          style: GoogleFonts.poppins(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                      const SizedBox(
                        height: 5,
                      ),

                        Material(
                            elevation: 10,
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              height: 230,
                              width: 330,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                      image: NetworkImage('$imageOfCourse'),
                                      fit: BoxFit.cover)),
                            )),

                      const SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Material(
                                  elevation: 10,
                                  borderRadius: BorderRadius.circular(6),
                                  child: Container(
                                    height: 65,
                                    decoration: BoxDecoration(
                                        color: CupertinoColors.white,
                                        border: Border.all(width: 1),
                                        borderRadius: BorderRadius.circular(6)),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10,
                                          bottom: 10,
                                          left: 30,
                                          right: 5),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Video-${index + 1}',
                                            style: GoogleFonts.cairo(
                                              fontSize: 18,
                                            ),
                                          ),
                                          const Spacer(),
                                          IconButton(
                                            icon: const Icon(
                                                Icons.keyboard_arrow_right),
                                            onPressed: () {
                                              {
                                                print(index);
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            SelectedVideoScreen(
                                                              AdminCubit.get(
                                                                      context).urls?[index],
                                                              colorOfCourse,
                                                              index,
                                                              nameOfCourse,
                                                            )));
                                              }

                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 12,
                            );
                          },
                          itemCount: AdminCubit.get(context).urls.length-1,
                        ),
                      ),

                      if(nameOfCourse != 'Arabic alphabet')
                        Material(
                          elevation: 10,
                          borderRadius: BorderRadius.circular(6),
                          child: Container(
                              height: 65,
                              decoration: BoxDecoration(
                                  color: CupertinoColors.white,
                                  border: Border.all(width: 1),
                                  borderRadius: BorderRadius.circular(6)),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, bottom: 10, left: 30, right: 5),
                                child: Row(
                                  children: [
                                    Text(
                                      'Quiz of $nameOfCourse',
                                      style: GoogleFonts.cairo(
                                        fontSize: 18,
                                      ),
                                    ),
                                    const Spacer(),
                                    IconButton(
                                      icon: const Icon(Icons.keyboard_arrow_right),
                                      onPressed: () {
                                        AdminCubit.get(context).getQuestions(nameOfCourse);
                                        if(AdminCubit.get(context).questions.isNotEmpty)
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    QuizScreen()));
                                      },
                                    )
                                  ],
                                ),
                              )),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
