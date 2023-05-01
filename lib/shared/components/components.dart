import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kindergarten1/models/courses_model.dart';
import 'package:line_icons/line_icon.dart';

import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../modules/admin/add_name_of_course.dart';

//the default color of application
defaultColor() => const Color.fromRGBO(17, 136, 204, 10);

// method return text from field
defaultTextFromField({
  bool isPassword = false,
  required TextEditingController controller,
  required TextInputType typeOfKeyboard,
  Function()? suffixIconPressedFunction,
  Function()? onTap,
  Function(dynamic)? onChanged,
  IconData? suffixIcon,
  IconData? prefixIcon,
  String? textIfNotValidate,
  String? hintText,
  String? textOfLabel,
  Function(String?)? onFieldSubmitted,
}) =>
    TextFormField(
      obscureText: isPassword ? true : false,
      validator: (value) {
        if (value!.isEmpty) {
          return textIfNotValidate;
        } else if (typeOfKeyboard == TextInputType.text) {
          if (value == 'male' || value == 'female') {
            return null;
          } else {
            return 'Gender must be male or female';
          }
        }

        return null;
      },
      onFieldSubmitted: onFieldSubmitted,
      onTap: onTap,
      onChanged: onChanged,
      controller: controller,
      keyboardType: typeOfKeyboard,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        fillColor: Colors.white,
        filled: true,
        contentPadding: EdgeInsets.all(20),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10),
        ),
        hintText: hintText,
        hintStyle: GoogleFonts.poppins(
          fontSize: 20,
          color: defaultColor(),
          decoration: TextDecoration.none,
        ),
        labelText: textOfLabel,
        labelStyle: GoogleFonts.poppins(
          fontSize: 16,
          color: defaultColor(),
          decoration: TextDecoration.none,
        ),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 23),
          child: InkWell(
              child: Icon(
            suffixIcon,
            size: 30,
            color: defaultColor(),
          )),
        ),
        floatingLabelStyle: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.amber,
          decoration: TextDecoration.none,
        ),
      ),
    );

//this method to return course item
courseItem({
  required Color colorOfCourseItem,
  required String nameOfCourse,
  required String imageOfCourse,
  Function()? onTap,

}) {
  return InkWell(
    onTap:onTap,
    child: Material(
      borderRadius: BorderRadius.circular(6),
      elevation: 15,
      child: Container(
        width: 329,
        height: 92,
        decoration: BoxDecoration(
          color: colorOfCourseItem,
          border: Border.all(color: Colors.black, width: 1.3),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                nameOfCourse,
                style: GoogleFonts.cairo(
                  fontSize: 20,
                ),
              ),
            ),
            const Spacer(),
            Container(
              width: 127,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(6),
                    bottomRight: Radius.circular(6)),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage('${imageOfCourse}'),
                ),
              ),
            ),

          ],
        ),
      ),
    ),
  );
}

// show toast if state is true or warning or false
void showToast({
  required String text,
  required ToastState state,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );

enum ToastState { SUCCESS, ERROR, WARNING }

Color? chooseToastColor(ToastState state) {
  Color color;
  switch (state) {
    case ToastState.SUCCESS:
      color = Colors.green;
      break;
    case ToastState.ERROR:
      color = Colors.red;
      break;
    case ToastState.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

// this method to return the quiz item in profile
  quizItem({
  required String nameOfQuiz,
   required double percentOfProgressOfCourse,
   required String percent,
})
{
  return Material(
    borderRadius: BorderRadius.circular(6),
    elevation: 10,
    child: Container(
      width: 330,
      height: 100,
      decoration: BoxDecoration(
        border: Border.all(width: 1),
        color: const Color.fromRGBO(255, 251,229,10),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 15,right: 15,left: 15),
        child: Column(
          children: [
            Row(
              children: [
                Text('Quiz “${nameOfQuiz}”',style: GoogleFonts.cairo(fontSize: 24),),
                Spacer(),
                CircularPercentIndicator(
                  animation: true,
                  progressColor: Color.fromRGBO(201, 236, 204, 10),
                  radius: 33,
                  lineWidth: 6,
                  animationDuration: 4000,
                  percent: percentOfProgressOfCourse,
                  center: Text('${percent}'),
                  circularStrokeCap: CircularStrokeCap.round,
                ),
              ],
            ),

          ],
        ),
      ),
    ),
  );

}
itemOfDashboard(Color c,text,context ){
  return Material(
    borderRadius: BorderRadius.circular(10),
    elevation: 5,
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(10),
        color: c ,
      ),
      height: 480,
      width: 330,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                  '${text}',
                  style: GoogleFonts.cairo(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  )
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                height: 320,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(width: 2,),
                ),
                child:  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          'some notes will need it: ',
                          style: GoogleFonts.cairo(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          )
                      ),
                      Text(
                          ' - first add name of course and add image that realted to the content of course. \n - second add the description of video and the video url and not forget to add the title of video.',
                          style: GoogleFonts.cairo(
                            fontSize: 20,
                          ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 60,
                  width: 260,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(15)
                  ),
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> AddCourseName()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Next',style: GoogleFonts.cairo(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w600),),
                      ],
                    ),
                  ),
                )
              ],
            )

          ],
        ),
      ),
    ),
  );
}
