
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kindergarten1/modules/admin/cubit/states.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../../models/course_model.dart';

class AdminCubit extends Cubit<AdminStates>{
  AdminCubit(): super(AdminInitialState());
  static AdminCubit get(context) => BlocProvider.of(context);
  CourseModel? courseModel;

  File? profileImage;
  final picker = ImagePicker();
  Future<void> getProfileImage() async
  {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if(pickedFile != null)
    {
      profileImage = File(pickedFile.path);
      emit(ProfilePickedSuccessState());
    }else{
      print('No image selected.');
      emit(ProfilePickedErrorState());
    }
  }


//////////////////////////////////////////////////////////////////
  void uploadProfileImage(
      String? nameOfCourse,
      )
  {
    emit(UploadLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('courses/${Uri.file(profileImage!.path).pathSegments.last}').putFile(profileImage!).then((value){
      value.ref.getDownloadURL().then((dynamic value) {
        updateProfileImage(
          nameOfCourse: nameOfCourse,
          image:value,
        );
      }).catchError((error){
        emit(UploadProfileImageSuccessState());
      });
    }).catchError((error){
      emit(UploadProfileImageErrorState());
    });
  }

//////////////////////////////////////
  void courseCreate({
    required String nameOfCourse,
     String? image,
  }){

    CourseModel model = CourseModel(
      nameOfCourse: nameOfCourse,
      image:'https://img.freepik.com/free-vector/error-404-concept-landing-page_52683-21190.jpg',
    );
    FirebaseFirestore.instance
        .collection('courses')
        .doc(nameOfCourse).set(model.toMap()).then((value) {
          emit(CreateCourseSuccessState(nameOfCourse));
    }).catchError((error){
      emit(CreateCourseErrorState(error));
    });
  }




/////////////////////////

  void updateProfileImage({
    String? nameOfCourse,
    String? image,
  })
  {
    CourseModel model = CourseModel(
      nameOfCourse: nameOfCourse,
      image:image?? courseModel!.image,
    );
    FirebaseFirestore.instance.collection('courses').doc(nameOfCourse).update(model.toMap()).then((dynamic value) {
    courseModel!.image = value;
    emit(UpdateSuccessState());
    }).catchError((error){
      emit(UpdateSuccessState());
    });
  }
  ////////////////////////////

  final CollectionReference coursesRef =
  FirebaseFirestore.instance.collection('courses');
  void addUrlToList(String courseName,String url,) async {
    await coursesRef
        .doc(courseName)
        .update({'urls': FieldValue.arrayUnion([url])}).then((value){
          emit(AddUrlSuccessState());
    }).catchError((error){
      emit(AddUrlErrorState());
    });
  }

////////////////////////////////////
  final CollectionReference courseDescription =
  FirebaseFirestore.instance.collection('courses');
  void addCourseDescriptionToList(String courseName,String description,) async {
    await courseDescription
        .doc(courseName)
        .update({'description': FieldValue.arrayUnion([description])}).then((value){
      emit(AddDescriptionSuccessState());
    }).catchError((error){
      emit(AddDescriptionErrorState());
    });
  }

  ///////////////////////////////////////
  final CollectionReference quizQuestions =
  FirebaseFirestore.instance.collection('courses');
  void addQuizQuestions(String courseName,String question,) async {
    await quizQuestions
        .doc(courseName)
        .update({'questions': FieldValue.arrayUnion([question])}).then((value){
      emit(AddQuestionSuccessState());
    }).catchError((error){
      emit(AddQuestionErrorState());
    });
  }
//////////////////////////////////////////

  List<CourseModel> course = [];
  void getCourses() {
    FirebaseFirestore.instance
        .collection('courses')
        .get()
        .then((value) {
      value.docs.forEach((dynamic element) {
        course.add(CourseModel.fromJson(element.data()));
      });
      emit(GetCoursesSuccessState());
    })
        .catchError((error) {
      emit(GetCoursesErrorStat(error.toString()));
    });
  }
  /////////////////////////////////
  List urls = [];
  void getUrls(String? nameOfCourse) {
    FirebaseFirestore.instance
        .collection('courses')
    .doc(nameOfCourse)
        .get()
        .then((dynamic doc) {
       urls = doc.data()!['urls'];
       urls.forEach((dynamic url) {
         urls.add(url.toString());
         print(urls);
       });
       emit( GetUrlsSuccessState());
    })
        .catchError((error) {
      emit( GetUrlsErrorStat(error.toString()));
    });
  }




  ///////////////////////////////////////////
  List description = [];
  void getDescription(String? nameOfCourse) {
    FirebaseFirestore.instance
        .collection('courses')
        .doc(nameOfCourse)
        .get()
        .then((dynamic doc) {
      description = doc.data()!['description'];
      description.forEach((dynamic desc) {
        description.add(desc.toString());
        print(description);
      });
      emit( GetDescriptionSuccessState());
    })
        .catchError((error) {
      print(error);
      emit( GetDescriptionErrorState(error.toString())

      );
    });
  }


  ///////////////////////////////////////////
  List questions = [];
  void getQuestions(String? nameOfCourse) {
    FirebaseFirestore.instance
        .collection('courses')
        .doc(nameOfCourse)
        .get()
        .then((dynamic doc) {
      questions = doc.data()!['questions'];
      questions.forEach((dynamic question) {
        questions.add(question.toString());
        print(questions);
      });
      emit( GetQuestionSuccessState());
    }).catchError((error) {
      print(error);
      emit( GetQuestionErrorState(error.toString())

      );
    });
  }
  ////////////////////
void clear(TextEditingController t){
    t.clear();
    emit(ClearDone());
}
}