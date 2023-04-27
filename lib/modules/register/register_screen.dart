import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kindergarten1/layout/cubit/cubit.dart';
import 'package:kindergarten1/layout/kindergarten_layout.dart';
import 'package:kindergarten1/modules/register/cubit/cubit.dart';
import 'package:kindergarten1/modules/register/cubit/states.dart';
import 'package:kindergarten1/shared/components/constants.dart';

import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../shared/components/constants.dart';
import '../../shared/components/constants.dart';
import '../../shared/components/constants.dart';
import '../../shared/network/local/cache_helper.dart';

class RegisterScreen extends StatelessWidget {
var  emailController = TextEditingController();
var  passwordController = TextEditingController();
var  ageController = TextEditingController();
var  genderController = TextEditingController();
var  childFullNameController = TextEditingController();
var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterStates>(
        listener: (context,state){
          if (state is CreateUserSuccessState)
            {
              CacheHelper.saveData(key: 'userId', value: state.uId).then((value){
                userId = state.uId;
                KindergartenCubit.get(context).getUserData();


              });
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>KindergartenLayout()), (route) => false);
            }
        },
        builder: (context,state){
          return Form(
            key: formKey,
            child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/onBoardingScreen1.png'),
                    ),
                  ),
                ),
                Scaffold(
                  backgroundColor: Colors.transparent,
                  body: AnnotatedRegion<SystemUiOverlayStyle>(
                    value: const SystemUiOverlayStyle(
                        statusBarColor: Color.fromRGBO(17, 136, 204, 0),
                        statusBarIconBrightness: Brightness.light),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Container(
                                width: 110,
                                height: 110,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('assets/images/appLogo.png'),
                                  ),
                                ),
                              ),
                              Text(
                                'Kindergarten',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 36,
                                  color: Colors.white,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 3),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Material(
                                  child: defaultTextFromField(
                                    controller: childFullNameController,
                                    typeOfKeyboard: TextInputType.name,
                                    textOfLabel: 'Child Full-Name',
                                    textIfNotValidate: 'Name must not empty',
                                  ),
                                  elevation: 15,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                const SizedBox(height: 20,),
                                Material(
                                  child: defaultTextFromField(
                                    controller: emailController,
                                    typeOfKeyboard: TextInputType.emailAddress,
                                    textOfLabel: 'Enter E-mail',
                                    textIfNotValidate: 'Email must not empty',
                                  ),
                                  elevation: 15,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                const SizedBox(height: 20,),
                                Material(
                                  child: defaultTextFromField(
                                    controller: ageController,
                                    typeOfKeyboard: TextInputType.numberWithOptions(),
                                    textOfLabel: 'Age',
                                    textIfNotValidate: 'Age must not empty',
                                  ),
                                  elevation: 15,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                const SizedBox(height:20,),
                                Material(
                                  child: defaultTextFromField(
                                    controller: genderController,
                                    typeOfKeyboard: TextInputType.text,
                                    textOfLabel: 'Enter Gender',
                                    textIfNotValidate: 'Gender must not empty',
                                  ),
                                  elevation: 15,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                const SizedBox(height: 20,),
                                Material(
                                  child: defaultTextFromField(
                                    controller: passwordController,
                                    typeOfKeyboard: TextInputType.visiblePassword,
                                    textOfLabel: 'Enter Password',
                                    textIfNotValidate: 'Password must not empty',
                                  ),
                                  elevation: 15,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                SizedBox(height: 80,),
                                Center(
                                  child: Material(
                                    elevation: 20,
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      width: 360,
                                      height: 60,
                                      decoration: BoxDecoration(
                                          color: const Color.fromRGBO(255, 201, 1, 1),
                                          borderRadius: BorderRadius.circular(10)),
                                      child: TextButton(
                                        onPressed: () {
                                          if(formKey.currentState!.validate())
                                            {
                                              RegisterCubit.get(context).userRegister(
                                                  childFullName: childFullNameController.text,
                                                  email: emailController.text,
                                                  age: ageController.text,
                                                  gender: genderController.text,
                                                  password: passwordController.text,
                                              );

                                            }
                                        },
                                        child: Text(
                                          'Register',
                                          style: GoogleFonts.poppins(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                            decoration: TextDecoration.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                if(state is RegisterLoadingState)
                                  LinearProgressIndicator(),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },

      ),
    );
  }
}
