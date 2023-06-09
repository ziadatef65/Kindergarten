import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kindergarten1/layout/cubit/cubit.dart';
import 'package:kindergarten1/modules/reports/reports_screen.dart';
import 'package:kindergarten1/modules/selected_course_screen/cubit/cubit.dart';
import 'package:kindergarten1/shared/components/components.dart';

import '../../layout/cubit/states.dart';

class ProfileScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<KindergartenCubit,KindergartenStates>(
      listener: (context,state){},
      builder: (context,state){
        var userModel = KindergartenCubit.get(context).userModel;
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Material(
                  elevation: 20,
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: 370,
                    height: 570,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      color: const Color.fromRGBO(201, 236, 204, 10),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Material(
                            borderRadius: BorderRadius.circular(6),
                            elevation: 10,
                            child: Container(
                              width: 330,
                              height: 190,
                              decoration: BoxDecoration(
                                border: Border.all(width: 1),
                                color: CupertinoColors.white,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text('Father Name: ',style:GoogleFonts.cairo(fontSize: 24,color: Colors.amber),),
                                        Text(userModel!.childFullName!.split(" ").elementAt(1).toUpperCase(),style:GoogleFonts.cairo(fontSize:18,)),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text('Child Name: ',style:GoogleFonts.cairo(fontSize: 24,color: Colors.amber),),
                                        Text(userModel!.childFullName!.split(" ").elementAt(0).toUpperCase(),style:GoogleFonts.cairo(fontSize:20,)),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text('Email: ',style:GoogleFonts.cairo(fontSize: 24,color: Colors.amber),),
                                        SizedBox(height: 40,width:200,child: Tooltip(message: '${userModel!.email}' ,child: Text('${userModel!.email}',overflow: TextOverflow.ellipsis,style:GoogleFonts.cairo(fontSize:20,)))),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10,),
                          quizItem(
                              nameOfQuiz:"Alphabet" ,
                              percentOfProgressOfCourse: (userModel.scorePercentage! * 0.01),
                              percent: '${userModel.scorePercentage!.toInt()}%',
                          ),
                          const SizedBox(height: 10,),
                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> const ReportsScreen()));
                            },
                            child: Material(
                              elevation: 10,
                              borderRadius: BorderRadius.circular(6),
                              child: Container(
                                width: double.infinity,
                                height: 75,
                                decoration: BoxDecoration(
                                  color:const Color.fromRGBO(255, 251,229,10),
                                  border: Border.all(
                                  ),
                                  borderRadius: BorderRadius.circular(6)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Row(
                                    children: [Text('Reports',style: GoogleFonts.cairo(fontSize: 24,),),
                                    const Spacer(),
                                     const Icon(Icons.family_restroom) ,
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

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
