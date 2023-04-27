import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kindergarten1/modules/login/cubit/states.dart';

import '../../../shared/components/constants.dart';

class LoginCubit extends Cubit<LoginStates>
{
  LoginCubit():super(LoginInitialState());
  static LoginCubit get(context) => BlocProvider.of(context);

  void userLogin({
  required String email,
    required String password,
}){
    emit(LoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
    ).then((value) {
      userId = value.user!.uid;
      emit(LoginSuccessState(value.user!.uid));
    }).catchError((error){
      emit(LoginErrorState(error.toString()));
    });


}

  IconData suffix = Icons.visibility;
  bool isPassword = true;
  void changePasswordVisibility()
  {
    isPassword = !isPassword;
    suffix=isPassword?Icons.visibility :Icons.visibility_off;
    emit(ChangePasswordVisibilityState());
  }


}