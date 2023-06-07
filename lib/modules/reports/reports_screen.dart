
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kindergarten1/layout/cubit/cubit.dart';
import 'package:kindergarten1/layout/cubit/states.dart';
import 'package:kindergarten1/model/cubit/cubit.dart';
import 'package:kindergarten1/model/cubit/states.dart';
import 'package:kindergarten1/modules/admin/cubit/cubit.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<KindergartenCubit,KindergartenStates>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
            backgroundColor: Colors.white,
            body:
            KindergartenCubit.get(context).userModel?.results?.length ==0 ?
            Center(child: Container(child: Text('No answers yet',style: TextStyle(color: Colors.black87,fontWeight: FontWeight.bold,fontSize: 28),),))
                :Padding(
              padding: const EdgeInsets.only(top: 60,left: 20,right: 20,bottom: 20),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(),
                          color: const Color.fromRGBO(146, 218, 201, 10)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Text('Your son Score:',style: GoogleFonts.abel(fontWeight: FontWeight.bold,fontSize: 24),),
                                const SizedBox(height: 20,),
                                if(KindergartenCubit.get(context).userModel!.scorePercentage == 100)
                                  Text('5/5',style: GoogleFonts.abel(fontSize: 40,fontWeight: FontWeight.bold),),
                                if(KindergartenCubit.get(context).userModel!.scorePercentage == 20)
                                  Text('1/5',style: GoogleFonts.abel(fontSize: 40,fontWeight: FontWeight.bold),),
                                if(KindergartenCubit.get(context).userModel!.scorePercentage == 0)
                                  Text('0/5',style: GoogleFonts.abel(fontSize: 40,fontWeight: FontWeight.bold),),
                                if(KindergartenCubit.get(context).userModel!.scorePercentage == 40)
                                  Text('2/5',style: GoogleFonts.abel(fontSize: 40,fontWeight: FontWeight.bold),),
                                if(KindergartenCubit.get(context).userModel!.scorePercentage == 60)
                                  Text('3/5',style: GoogleFonts.abel(fontSize: 40,fontWeight: FontWeight.bold),),
                                if(KindergartenCubit.get(context).userModel!.scorePercentage == 80)
                                  Text('4/5',style: GoogleFonts.abel(fontSize: 40,fontWeight: FontWeight.bold),),
                              ],
                            ),
                            const Spacer(),
                            CircularPercentIndicator(
                              animation: true,
                              progressColor:
                              const Color.fromRGBO(255, 251,229,10),
                              radius: 40,
                              lineWidth: 7,
                              animationDuration: 4000,
                              percent: (KindergartenCubit.get(context).userModel!.scorePercentage !* 0.01),
                              center: Text(
                                  '${KindergartenCubit.get(context).userModel!.scorePercentage!.toInt()}%'),
                              circularStrokeCap:
                              CircularStrokeCap.round,
                            ),

                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Text(' Report:',style: GoogleFonts.cairo(fontSize: 30,fontWeight: FontWeight.bold,),),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(),
                        color:const Color.fromRGBO(146, 218, 201, 10),
                      ),
                      height: 400,
                      width: double.infinity,
                      child: Padding(
                          padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20),
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if(KindergartenCubit.get(context).userModel?.results?[0]==true && KindergartenCubit.get(context).userModel?.results?[1]==true && KindergartenCubit.get(context).userModel?.results?[2]==true && KindergartenCubit.get(context).userModel?.results?[3]==true && KindergartenCubit.get(context).userModel?.results?[4]==true)
                                  Center(
                                    child:Text('No wrong answers your child have the complete sign',textAlign: TextAlign.center,style: GoogleFonts.cairo(fontWeight: FontWeight.bold,fontSize: 24,color:const Color.fromRGBO(255, 251,229,1), ),),
                                  ),
                                if(KindergartenCubit.get(context).userModel?.results?[0]==true && KindergartenCubit.get(context).userModel?.results?[1]==true && KindergartenCubit.get(context).userModel?.results?[2]==true && KindergartenCubit.get(context).userModel?.results?[3]==true && KindergartenCubit.get(context).userModel?.results?[4]==true)
                                  const SizedBox(height: 160,),
                                const SizedBox(height: 20,),
                                if(KindergartenCubit.get(context).userModel?.results?[0]== false)
                                  Text('The first question is wrong, so the child must review video number 1',style: GoogleFonts.cairo(fontWeight: FontWeight.bold,fontSize: 18,color:const Color.fromRGBO(255, 251,229,1)),),
                                if(KindergartenCubit.get(context).userModel?.results?[0]== false)
                                  const  SizedBox(height: 10,),
                                if(KindergartenCubit.get(context).userModel?.results?[1]== false)
                                  Text('The second question is wrong, so the child must review video number 2',style: GoogleFonts.cairo(fontWeight: FontWeight.bold,fontSize: 18,color:const Color.fromRGBO(255, 251,229,1)),),
                                if(KindergartenCubit.get(context).userModel?.results?[1]== false)
                                  const SizedBox(height: 10,),
                                if(KindergartenCubit.get(context).userModel?.results?[2]== false)
                                  Text('The third question is wrong, so the child must review video number 3',style: GoogleFonts.cairo(fontWeight: FontWeight.bold,fontSize: 18,color:const Color.fromRGBO(255, 251,229,1)),),
                                if(KindergartenCubit.get(context).userModel?.results?[2]== false)
                                  const   SizedBox(height: 10,),
                                if(KindergartenCubit.get(context).userModel?.results?[3]== false)
                                  Text('The question number four is wrong, so the child must review video number 7',style: GoogleFonts.cairo(fontWeight: FontWeight.bold,fontSize: 18,color:const Color.fromRGBO(255, 251,229,1)),),
                                if(KindergartenCubit.get(context).userModel?.results?[3]== false)
                                  const  SizedBox(height: 10,),
                                if(KindergartenCubit.get(context).userModel?.results?[4]== false)
                                  Text('The question number five is wrong, so the child must review video number 12',style: GoogleFonts.cairo(fontWeight: FontWeight.bold,fontSize: 18,color:const Color.fromRGBO(255, 251,229,1)),),
                                if(KindergartenCubit.get(context).userModel?.results?[4]== false)
                                  const   SizedBox(height: 10,),

                              ],
                            ),
                          )
                      ) ,
                    ),
                    const SizedBox(height: 20,),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(),
                        color:const Color.fromRGBO(255, 251,229,10),
                      ),
                      height: 400,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20),
                        child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context,index){
                              return Container(
                                height: 80,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: KindergartenCubit.get(context).userModel?.results?[index] == false ? const Color.fromRGBO(255, 204, 203, 10):const Color.fromRGBO(146, 218, 201, 10),
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(),
                                ),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(20),
                                      child:    Text('Question-${index+1}',style: GoogleFonts.aBeeZee(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                                    ),
                                    const Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.all(20),
                                      child:
                                      Text('${ KindergartenCubit.get(context).userModel?.results?[index]}',style: GoogleFonts.aBeeZee(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                                    ),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder:(context,index) => const SizedBox(height: 15),
                            itemCount:KindergartenCubit.get(context).userModel?.results?.length == 0 ? 0:KindergartenCubit.get(context).userModel!.results!.length ,
                        ),
                      ) ,
                    ),



                  ],
                ),
              ),
            )
        );
      },

    );
  }
}
