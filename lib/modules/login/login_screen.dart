import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kindergarten1/layout/kindergarten_layout.dart';
import 'package:kindergarten1/modules/login/cubit/cubit.dart';
import 'package:kindergarten1/modules/register/register_screen.dart';
import 'package:kindergarten1/shared/components/components.dart';
import 'package:kindergarten1/shared/network/local/cache_helper.dart';
import 'cubit/states.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=> LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginStates>(
        listener: (context,state){
          if(state is LoginErrorState)
            {
              showToast(text: state.error, state: ToastState.ERROR);
            }
          if(state is LoginSuccessState)
            {
              CacheHelper.saveData(
                  key: 'userId',
                  value: state.userId
              ).then((value) {
                Navigator.pushAndRemoveUntil(context,  MaterialPageRoute(builder: (context)=>KindergartenLayout()), (route) => false);
              });
            }


        },
        builder: (context,state){
          return Stack(
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
                    child: Form(
                      key: formKey,
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
                                    controller: emailController,
                                    typeOfKeyboard: TextInputType.emailAddress,
                                    textOfLabel: 'Enter E-mail',
                                    textIfNotValidate: 'Email must not empty',
                                    suffixIcon: Icons.email_outlined,
                                  ),
                                  elevation: 15,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                const SizedBox(height: 27,),
                                Material(
                                  child: defaultTextFromField(
                                    isPassword: LoginCubit.get(context).isPassword,
                                    controller: passwordController,
                                    typeOfKeyboard: TextInputType.visiblePassword,
                                    textOfLabel: 'Enter Password',
                                    textIfNotValidate: 'Password must not empty',
                                    suffixIcon: LoginCubit.get(context).suffix,

                                    onTap: (){
                                      LoginCubit.get(context).changePasswordVisibility();
                                    },

                                  ),
                                  elevation: 15,
                                  borderRadius: BorderRadius.circular(10),
                                ),

                                TextButton(
                                  child: Text(
                                    'Forget Password?',
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                  onPressed: () {},
                                ),
                                Center(
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
                                            LoginCubit.get(context).userLogin(
                                                email: emailController.text,
                                                password: passwordController.text,
                                            );

                                          }

                                      },
                                      child: Text(
                                        'Login',
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
                                Row(
                                  children: [
                                    SizedBox(width: 8,height: 40,),
                                    Text(
                                      'Don\'t have any account ?',
                                      style:  GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                    TextButton(
                                      child: Text(
                                        'Sign Up',
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: const Color.fromRGBO(255, 201, 1, 1),
                                          decoration: TextDecoration.none,
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterScreen()));
                                      },
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },

      ),
    );
  }
}
