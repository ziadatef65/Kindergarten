import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kindergarten1/layout/cubit/cubit.dart';
import 'package:kindergarten1/layout/cubit/states.dart';
import 'package:kindergarten1/modules/selected_course_screen/selected_course_screen.dart';
import 'package:kindergarten1/shared/components/components.dart';
import 'package:line_icons/line_icon.dart';

import '../edit_user/edit_user_screen.dart';

class CoursesScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<KindergartenCubit,KindergartenStates>(
      listener: (context,state){},
      builder: (context,state){
        var userModel = KindergartenCubit.get(context).userModel;
        var cubit = KindergartenCubit.get(context);
        return  Scaffold(

          backgroundColor: CupertinoColors.white,
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
                width: double.infinity,
                height: 570,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(201, 236, 204,10),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: CupertinoColors.black,width: 2)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Courses',
                        style: GoogleFonts.cairo(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 360,
                        child: ListView.separated(
                          itemBuilder: (context,index){
                            return courseItem(
                              onTap: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SelectedCourseScreen('${cubit.coursesList[index].nameOfCourse}','${cubit.coursesList[index].imageOfCourse}',cubit.coursesList[index].colorOfCourse)));
                              },
                              colorOfCourseItem: cubit.coursesList[index].colorOfCourse,
                              nameOfCourse: cubit.coursesList[index].nameOfCourse,
                              imageOfCourse: cubit.coursesList[index].imageOfCourse,
                            );
                          },
                          separatorBuilder:(context,index)=> const SizedBox(
                            height: 40,
                          ),
                          itemCount: cubit.coursesList.length,
                        ),
                      ),
                    ],
                  ),
                )
            ),
          ),
        );
      },

    );
  }
}
