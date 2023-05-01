import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kindergarten1/model/cubit/cubit.dart';
import 'package:kindergarten1/modules/admin/cubit/cubit.dart';
import 'package:kindergarten1/modules/courses/courses_screen.dart';
import 'package:kindergarten1/modules/home/home_screen.dart';
import 'package:kindergarten1/modules/profile/profile_screen.dart';
import 'package:kindergarten1/modules/review/review_screen.dart';
import 'package:kindergarten1/modules/selected_course_screen/selected_course_screen.dart';
import 'package:line_icons/line_icon.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../model/cubit/states.dart';
import '../quiz/quizes_screen.dart';

class EvaluationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ImageClassificationCubit, ImageClassificationState>(
        listener: (context, state) {},
        builder: (context, state) {
          print(ImageClassificationCubit.get(context).result);
          var userModel = KindergartenCubit.get(context).userModel;
          var cubit = KindergartenCubit.get(context);
          int index = 0;
          KindergartenCubit.get(context).updateUserScore(((ImageClassificationCubit.get(context).trueCounter * 100)/5));
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(

                backgroundColor: Colors.white,
                elevation: 0,
                leadingWidth: double.infinity,
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
              padding: const EdgeInsets.only(top: 20,left: 20,right: 20),
              child: Column(
                children: [
                  Material(
                    borderRadius: BorderRadius.circular(6),
                    elevation: 10,
                    child: Container(
                      height: 230,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(),
                          color: Color.fromRGBO(146, 218, 201, 10)),
                      child: Padding(
                        padding: const EdgeInsets.all(18),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ImageClassificationCubit.get(context).trueCounter>2 ?
                                Text(
                                  'Congratulations! You have passed this \ntest with ',
                                  style: GoogleFonts.cairo(
                                      textStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 18)),
                                ) :
                                Text(
                                  'some bad news You have failed in the \ntest with ',
                                  style: GoogleFonts.cairo(
                                      textStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 18)),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      '${(ImageClassificationCubit.get(context).trueCounter * 100) / 5}%.',
                                      style: GoogleFonts.cairo(
                                          textStyle: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20)),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Row(
                                  children: [
                                    CircularPercentIndicator(
                                      animation: true,
                                      progressColor:
                                          Color.fromRGBO(14, 129, 180, 10),
                                      radius: 40,
                                      lineWidth: 7,
                                      animationDuration: 4000,
                                      percent: ((ImageClassificationCubit.get(
                                                          context)
                                                      .trueCounter *
                                                  100) /
                                              5) /
                                          100,
                                      center: Text(
                                          '${ImageClassificationCubit.get(context).trueCounter}/5'),
                                      circularStrokeCap:
                                          CircularStrokeCap.round,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Your score',
                                      style: GoogleFonts.cairo(
                                          textStyle: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 18)),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Material(
                    borderRadius: BorderRadius.circular(6),
                    elevation: 10,
                    child: Container(
                      height: 105,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(),
                          color: Color.fromRGBO(255, 204, 203, 10)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${ImageClassificationCubit.get(context).trueCounter}',
                              style: GoogleFonts.cairo(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text(
                              'Correct Answers',
                              style: GoogleFonts.cairo(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Material(
                    borderRadius: BorderRadius.circular(6),
                    elevation: 10,
                    child: Container(
                      height: 105,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(),
                          color: Color.fromRGBO(255, 204, 203, 10)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${ImageClassificationCubit.get(context).falseCounter}',
                              style: GoogleFonts.cairo(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text(
                              'Wrong Answers',
                              style: GoogleFonts.cairo(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 67,
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(6),
                              color: Color.fromRGBO(146, 218, 201, 10)),
                          child: TextButton(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.refresh_sharp,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text('Try Quiz Again',
                                    style: GoogleFonts.cairo(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    )),
                              ],
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => QuizScreen()));
                              cubit.zeroOfIndex();
                              ImageClassificationCubit.get(context)
                                  .labels
                                  .clear();
                              ImageClassificationCubit.get(context)
                                  .result
                                  .clear();
                              ImageClassificationCubit.get(context)
                                  .trueCounter = 0;
                              ImageClassificationCubit.get(context)
                                  .falseCounter = 0;
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Container(
                          height: 67,
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(6),
                              color: Color.fromRGBO(146, 218, 201, 10)),
                          child: TextButton(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.reviews,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text('Review answers',
                                    style: GoogleFonts.cairo(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    )),
                              ],
                            ),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> ReviewScreen(ImageClassificationCubit.get(context).result)));
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
         ],
              ),
            ),
          );
        });
  }
}
