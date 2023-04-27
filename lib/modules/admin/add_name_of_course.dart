import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/components/components.dart';
import 'add_image_course.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class AddCourseName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var textController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocConsumer<AdminCubit, AdminStates>(
      listener: (context, state) {
        if (state is CreateCourseSuccessState)
          {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>AddVideoScreen(textController.text)));
          }
        if(state is CreateCourseSuccessState )
          {
            showToast(text: 'Course name has been added successfully' , state: ToastState.SUCCESS);
          }
      },
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                       Text(
                        'Add Course Name',
                        style: GoogleFonts.cairo(
                            fontWeight: FontWeight.w900, fontSize: 24),
                      ),
                      Container(
                        height: 400,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(201, 236, 204, 10),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                               Text(
                                'Add Course Name Here',
                                style: GoogleFonts.cairo(
                                    fontWeight: FontWeight.w900, fontSize: 18),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'This field must not be empty';
                                    }
                                    return null;
                                  },
                                  controller: textController,
                                  decoration: InputDecoration(
                                      label:  Text('Add name of course',style: GoogleFonts.cairo(),),
                                      floatingLabelStyle:
                                      const TextStyle(color: Colors.black87),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(15),
                                          borderSide: const BorderSide(
                                              color: Colors.white, width: 2)),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(15),
                                          borderSide: const BorderSide(
                                              color: Colors.black, width: 1)))),
                              const SizedBox(
                                height: 20,
                              ),
                              Center(
                                child: InkWell(
                                  child: Container(
                                      height: 50,
                                      width: 280,
                                      decoration: BoxDecoration(
                                          color:  const Color.fromRGBO(255, 238, 192, 1),
                                          border: Border.all(),
                                          borderRadius:
                                          BorderRadius.circular(
                                              15)),
                                      child:   Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Next',
                                            style: GoogleFonts.cairo(
                                                color: Colors.black87,
                                                fontSize: 20),
                                          ),
                                        ],
                                      )
                                  ),
                                  onTap: () {
                                    if(formKey.currentState!.validate())
                                    {
                                      AdminCubit.get(context).courseCreate(nameOfCourse: textController.text,);

                                    }
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
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