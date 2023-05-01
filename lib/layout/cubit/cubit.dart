import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kindergarten1/layout/cubit/states.dart';
import 'package:kindergarten1/model/cubit/cubit.dart';
import 'package:kindergarten1/models/objectives_model.dart';
import 'package:kindergarten1/modules/admin/cubit/cubit.dart';
import 'package:kindergarten1/modules/courses/courses_screen.dart';
import 'package:kindergarten1/modules/home/home_screen.dart';
import 'package:kindergarten1/modules/profile/profile_screen.dart';
import 'package:kindergarten1/modules/selected_course_screen/cubit/cubit.dart';
import 'package:kindergarten1/shared/components/constants.dart';
import 'package:video_player/video_player.dart';

import '../../models/courses_model.dart';
import '../../models/user_model.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../modules/admin/admin_dashboard.dart';
import '../../modules/evaluation/evaluation_page.dart';

class KindergartenCubit extends Cubit<KindergartenStates> {
  KindergartenCubit() : super(KindergartenInitialState());

  static KindergartenCubit get(context) => BlocProvider.of(context);

  List<ObjectivesModel> objectivesList = [
    ObjectivesModel(
      'Numbers Course',
      'assets/images/objectivesMath.jpg',
      const Color.fromRGBO(146, 218, 201, 10),
      '. The ability to know numbers from 0 to 10 \n. The ability to write the number and know its form  \n. The ability to use numbers in future calculations',
    ),
    ObjectivesModel(
      'Alphabet Course',
      'assets/images/objectivesAlphabet.jpg',
      CupertinoColors.white,
      '. The ability to know numbers from 0 to 10 \n. The ability to write the number and know its form  \n. The ability to use numbers in future calculations',
    ),
    ObjectivesModel(
      'Fruits Course',
      'assets/images/objectivesFruits.jpg',
      const Color.fromRGBO(255, 251, 229, 10),
      '. The ability to know numbers from 0 to 10 \n. The ability to write the number and know its form  \n. The ability to use numbers in future calculations',
    ),
  ];

  int currentIndex = 0;
  List<Widget> screens = [
    HomeScreen(),
    CoursesScreen(),
    ProfileScreen(),
    AdminDashboard(),
  ];

  void changeBottomNavBar(dynamic index) {
    currentIndex = index;
    emit(ChangeBottomNavState());
  }

  var boardController = PageController();
  bool isLast = false;

  void onPageChanged(int index) {
    if (index == objectivesList.length - 1) {
      isLast = true;
      emit(OnPageChanged());
    } else {
      isLast = false;
      emit(OnPageChanged());
    }
  }

  UserModel? userModel;

  void getUserData() {
    emit(GetUserLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get()
        .then((dynamic value) {
      userModel = UserModel.fromJson(value.data());
      emit(GetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetUserErrorState(error.toString()));
    });
  }

  // method to get a profile image from edit_user_screen
  File? profileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(ProfileImagePickedSuccessState());
    } else {
      print('No image selected');
      emit(ProfileImagePickedErrorState());
    }
  }

  //end method

  //method to upload photo to storage

  void uploadProfileImage({
    required String name,
    required String gender,
    required String age,
  }) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((dynamic value) {
        //emit(UploadProfileImageSuccessState());
        updateUser(
          name: name,
          gender: gender,
          age: age,
          image: value,
        );
      }).catchError((error) {
        emit(UploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(UploadProfileImageErrorState());
    });
  }

  void updateUser({
    required String name,
    required String gender,
    required String age,
    String? image,
  }) {
    emit(UserUpdateLoading());

    UserModel model = UserModel(
      childFullName: name,
      gender: gender,
      age: age,
      image: image ?? userModel!.image,
      email: userModel!.email,
      userId: userModel!.userId,
      isAdmin: userModel!.isAdmin!,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.userId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(UserUpdateError());
    });
  }

  // list to get data to course item
  List<CoursesModel> coursesList = [
    CoursesModel('Number Course', 'assets/images/objectivesMath.jpg',
        const Color.fromRGBO(146, 218, 201, 10)),
    CoursesModel('Alphabet Course', 'assets/images/objectivesAlphabet.jpg',
        Colors.white),
    CoursesModel('Fruits Course', 'assets/images/objectivesFruits.jpg',
        const Color.fromRGBO(255, 251, 229, 10)),
    CoursesModel('Number Course', 'assets/images/objectivesMath.jpg',
        const Color.fromRGBO(146, 218, 201, 10)),
    CoursesModel('Alphabet Course', 'assets/images/objectivesAlphabet.jpg',
        Colors.white),
    CoursesModel('Fruits Course', 'assets/images/objectivesFruits.jpg',
        const Color.fromRGBO(255, 251, 229, 10)),
  ];

  //end



////
  int index = 0;

  void changeQuestion(int currentIndex, context) {
    if (currentIndex < AdminCubit.get(context).questions.length - 1) {
      index++;

    }
    emit(NextQuestionState());

  }
//////
  zeroOfIndex(){
    index=0;
    emit(ZeroIndex());
  }
//////

void updateUserScore (value){
    FirebaseFirestore.instance.collection('users').doc(userModel!.userId).update({'scorePercentage':value}).then((value) {
emit(ScorePercentageSuccessState());
    }).catchError((error){
emit(ScorePercentageErrorState());
    });
}
////////////


}

