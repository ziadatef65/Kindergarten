import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kindergarten1/models/user_model.dart';
import 'package:kindergarten1/modules/register/cubit/states.dart';
import 'package:kindergarten1/shared/components/constants.dart';

class RegisterCubit extends Cubit<RegisterStates>{
  RegisterCubit(): super(RegisterInitialState());
  static RegisterCubit get(context)=> BlocProvider.of(context);


// this method used to make user register
//start
  void userRegister(
  {
  required String childFullName,
  required String email,
  required String age,
  required String gender,
  required String password,
  })
  {
    emit(RegisterLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
    ).then((value) {
      userCreate(
          childFullName: childFullName,
          email: email,
          age: age,
          gender: gender,
          userId: value.user!.uid,
      );
    }).catchError((error){
      emit(RegisterErrorState(error.toString()));
    });

  }
  //end



// this method used to create user
//start
void userCreate({
  required String childFullName,
  required String email,
  required String age,
  required String gender,
  required String userId,
})
{
  UserModel model = UserModel(
    childFullName: childFullName,
    age: age,
    gender: gender,
    userId: userId,
    email: email,
    image: 'https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg',

  );
FirebaseFirestore.instance
    .collection('users')
    .doc(userId).set(model.toMap()).then((value) {
emit(CreateUserSuccessState());
}).catchError((error){
  emit(CreateUserErrorState(error.toString()));
});
}
//end







}