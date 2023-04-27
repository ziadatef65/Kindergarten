import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';


import '../../shared/components/components.dart';
import 'add_video_descriptions.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';



class AddVideoLinkScreen extends StatelessWidget {
  final nameOfcourse;
  final image;
  AddVideoLinkScreen(this.nameOfcourse,this.image);
  @override
  Widget build(BuildContext context) {
    var textController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocConsumer<AdminCubit, AdminStates>(
      listener: (context, state) {
        if(state is AddUrlSuccessState ) {
          showToast(text: 'The url has been added successfully',
              state: ToastState.SUCCESS);
          AdminCubit.get(context).clear(textController);
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
                        'Add Video Links',
                        style: GoogleFonts.cairo(
                            fontWeight: FontWeight.w900, fontSize: 24),
                      ),
                      Container(
                        height: 540,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(255, 251, 210, 10),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(

                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                               Text(
                                'Add Video Links',
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
                                      label:  Text('Add the video link',style: GoogleFonts.cairo(),),
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
                                            'Add',
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
                                      AdminCubit.get(context).addUrlToList(nameOfcourse,textController.text);
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(height: 10,),
                               Text('Some notes you will need it:',style: GoogleFonts.cairo(fontSize: 18,fontWeight: FontWeight.bold),),
                               Text(
                                '- Add each link individually.\n- After add each link click in the  button "Add" to complete this process well.\n- When finish to add all links that you need click the button "Next" to go to the next page. ',
                                style: GoogleFonts.cairo(fontSize: 16,),
                              ),
                              const  SizedBox(height: 30,),
                              Center(
                                child: InkWell(
                                  child: Container(
                                      height: 50,
                                      width: 280,
                                      decoration: BoxDecoration(
                                          color: const Color.fromRGBO(146, 218, 201, 10),
                                          border: Border.all(),
                                          borderRadius:
                                          BorderRadius.circular(
                                              15)),
                                      child: const  Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Next',
                                            style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 20),
                                          ),
                                        ],
                                      )
                                  ),
                                  onTap: () {

                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AddVideoDescriptions(nameOfcourse)));

                                  },
                                ),
                              ),
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