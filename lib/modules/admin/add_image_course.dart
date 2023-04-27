import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/components/components.dart';
import 'add_video_links.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class AddVideoScreen extends StatelessWidget {
final name;
AddVideoScreen(this.name);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    return BlocConsumer<AdminCubit, AdminStates>(
      listener: (context, state) {
        if (state is UpdateSuccessState){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddVideoLinkScreen(name,AdminCubit.get(context).profileImage)));
        }
        if(state is UpdateSuccessState )
        {
          showToast(text: 'Course image has been added successfully' , state: ToastState.SUCCESS);
        }
      },
      builder: (context, state) {
        var profileImage = AdminCubit.get(context).profileImage;
        var CourseModel = AdminCubit.get(context).courseModel;
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
                        'Add Course Image',
                        style: GoogleFonts.cairo(
                            fontWeight: FontWeight.w900, fontSize: 24),
                      ),
                      Container(
                        height: 500,
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
                                'Upload image of course',
                                style: GoogleFonts.cairo(
                                    fontWeight: FontWeight.w900, fontSize: 18),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 300,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: const Color.fromRGBO(255, 238, 192, 1),
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      const  SizedBox(
                                        height: 3,
                                      ),
                                      //here we will add the photo when it upload
                                      if (profileImage == null)
                                      SizedBox(height: 200,),
                                      if (profileImage != null)
                                        Container(
                                        height: 200,
                                        width: double.infinity,
                                        child: Image(
                                          image:  profileImage == null ? NetworkImage('${CourseModel?.image}'): FileImage(profileImage) as ImageProvider,),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [

                                          SizedBox(width: 8,),
                                          InkWell(
                                            child: Container(
                                                height: 50,
                                                width: 280,
                                                decoration: BoxDecoration(
                                                    color: const Color.fromRGBO(146, 218, 201, 10),
                                                    border: Border.all(),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                child:   Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'Upload',
                                                      style: GoogleFonts.cairo(
                                                          color: Colors.black87,
                                                          fontSize: 20),
                                                    ),
                                                    Icon(Icons.upload_outlined)
                                                  ],
                                                )
                                            ),
                                            onTap: () {
                                              AdminCubit.get(context).getProfileImage();
                                            },
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 30,),
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
                                        AdminCubit.get(context).uploadProfileImage(name);
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
