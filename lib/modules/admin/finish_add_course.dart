import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kindergarten1/layout/kindergarten_layout.dart';
import 'package:kindergarten1/modules/admin/cubit/cubit.dart';

class FinishAddCourse extends StatelessWidget {

  final nameOfcourse;

  FinishAddCourse(this.nameOfcourse);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            children: [
           const   Image(image: AssetImage('assets/images/6.png')),
           const   SizedBox(height: 10,),
              Text('                         Congratulations, \n The course has been added successfully',style: GoogleFonts.cairo(fontWeight: FontWeight.w900,fontSize: 20),)
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor:const Color.fromRGBO(146, 218, 201, 10),

        onPressed: (){



          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>KindergartenLayout()), (route) => false);
        },
        child: const Icon(Icons.navigate_next_outlined),
      ),
    );
  }
}
