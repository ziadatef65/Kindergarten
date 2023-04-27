import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kindergarten1/layout/cubit/cubit.dart';
import 'package:kindergarten1/layout/cubit/states.dart';
import 'package:kindergarten1/modules/admin/cubit/cubit.dart';
import 'package:kindergarten1/modules/selected_course_screen/selected_course_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../shared/components/components.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<KindergartenCubit,KindergartenStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit = KindergartenCubit.get(context);
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 55,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          CupertinoIcons.search,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        'Search',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'The Objectives',
                        style: GoogleFonts.poppins(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const Spacer(),
                    SmoothPageIndicator(
                      effect: const SwapEffect(
                        activeDotColor: Colors.amber,
                        dotHeight: 15,
                        dotColor: Colors.grey,
                        dotWidth: 15,
                        spacing: 19,
                      ) ,

                        controller: cubit.boardController,
                        count: cubit.objectivesList.length,
                    ),
                    const SizedBox(width: 13,)
                  ],
                ),
                SizedBox(
                 height: 450,
                 width: 400,
                 child: PageView.builder(
                   physics: const BouncingScrollPhysics(),
                   controller: cubit.boardController,
                   onPageChanged: (int index){
                     cubit.onPageChanged(index);
                   },
                   itemCount: cubit.objectivesList.length,
                   itemBuilder: (context,index)=>Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Container(
                       width: 360,
                       height: 450,
                       decoration: BoxDecoration(
                         color: cubit.objectivesList[index].colorOfContainer,
                         borderRadius: BorderRadius.circular(12),
                         border: Border.all(
                           color: Colors.black,
                         ),
                       ),
                       child: Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Text(
                               cubit.objectivesList[index].titleOfCourse,
                               style: GoogleFonts.poppins(
                                 fontSize: 22,
                                 fontWeight: FontWeight.bold,
                                 color: Colors.black,
                               ),
                             ),
                             const SizedBox(
                               height: 10,
                             ),
                             Container(
                               width: double.infinity,
                               height: 200,
                               decoration: BoxDecoration(
                                 shape: BoxShape.rectangle,
                                 borderRadius: BorderRadius.circular(12),
                                 image:  DecorationImage(
                                   fit: BoxFit.cover,
                                   image: AssetImage(
                                       cubit.objectivesList[index].image),
                                 ),
                               ),
                             ),
                             const SizedBox(
                               height: 10,
                             ),
                             Text(
                               cubit.objectivesList[index].contentOfObjectives,
                               style: GoogleFonts.poppins(
                                 fontSize: 16,
                                 color: Colors.black,
                               ),
                             )
                           ],
                         ),
                       ),
                     ),
                   ),
                 ),
               ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  height: 468,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(201, 236, 204, 10),
                    border: Border.all(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              'Courses',
                              style: GoogleFonts.poppins(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const Spacer(),
                            TextButton(
                              onPressed: () {
                                cubit.currentIndex=1;
                                cubit.changeBottomNavBar(cubit.currentIndex);
                              },
                              child: Text(
                                'View all',
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      if (AdminCubit.get(context).course.length > 0)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),

                        child: SizedBox(
                          height: 360,

                          child: ListView.separated(
                              itemBuilder: (context,index){
                                return courseItem(
                                  onTap: (){
                                    AdminCubit.get(context).getUrls(AdminCubit.get(context).course[index].nameOfCourse);
                                    AdminCubit.get(context).getDescription(AdminCubit.get(context).course[index].nameOfCourse);
                                    if(AdminCubit.get(context).urls.isNotEmpty)
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SelectedCourseScreen('${AdminCubit.get(context).course[index].nameOfCourse}','${AdminCubit.get(context).course[index].image}',cubit.coursesList[index].colorOfCourse)));
                                  },
                                    colorOfCourseItem: cubit.coursesList[index].colorOfCourse,
                                    nameOfCourse: AdminCubit.get(context).course[index].nameOfCourse!,
                                    imageOfCourse: AdminCubit.get(context).course[index].image!,
                                );
                              },
                              separatorBuilder:(context,index)=> const SizedBox(
                                height: 40,
                              ),
                              itemCount: AdminCubit.get(context).course.length,
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },

    );
  }
}
