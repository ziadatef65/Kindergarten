<<<<<<< HEAD
import 'dart:io';
=======
>>>>>>> kindergarten/master
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
<<<<<<< HEAD
import 'package:image_picker/image_picker.dart';
import 'package:kindergarten1/layout/cubit/states.dart';
import 'package:kindergarten1/modules/admin/cubit/cubit.dart';
import 'package:kindergarten1/shared/components/components.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import '../../layout/cubit/cubit.dart';
import '../../model/cubit/cubit.dart';
import '../../model/cubit/states.dart';
import '../edit_user/edit_user_screen.dart';
import '../evaluation/evaluation_page.dart';

class QuizScreen extends StatelessWidget {
  final ImageClassificationCubit cubitImage = ImageClassificationCubit();

  @override
  Widget build(BuildContext context) {
    int index = 0;
    List<String> labels=[];
    var cubit = KindergartenCubit.get(context);
    return BlocConsumer<ImageClassificationCubit, ImageClassificationState>(
        bloc: cubitImage,
        listener: (context, state) {
          if(state is ImageClassificationSuccess){
            showToast(text: 'Image successfully uploaded', state: ToastState.SUCCESS);
          }
          if (state is ImageClassificationSuccess) {
            cubit.changeQuestion(index, context);
            labels.add(state.label);
            _imageFile = null;
            print(labels);
          }
          if (state is ImageClassificationError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
            print(state.message.toString());
          }
        },
        builder: (context, state) {
          var userModel = KindergartenCubit.get(context).userModel;
          return Scaffold(
            backgroundColor: Colors.white,
=======
import 'package:kindergarten1/modules/admin/cubit/cubit.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../edit_user/edit_user_screen.dart';


class QuizScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<KindergartenCubit, KindergartenStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var userModel = KindergartenCubit.get(context).userModel;
          var cubit = KindergartenCubit.get(context);

          int index=0;
          return Scaffold(
            backgroundColor: CupertinoColors.white,
>>>>>>> kindergarten/master
            appBar: AppBar(
                systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                ),
                backgroundColor: Colors.white,
                elevation: 0,
                leadingWidth: double.infinity,
                actions: [
                  IconButton(
                    icon: LineIcon.userEdit(
                      color: Colors.amber,
                      size: 30,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditUserScreen()));
                    },
                  ),
                ],
                leading: Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage('${userModel?.image}'),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Text('Hello, ${userModel?.childFullName}',
                              style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black)),
                          Text('${userModel?.age}',
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                                color: Colors.grey,
                              )),
                        ],
                      )
                    ],
                  ),
                )),
<<<<<<< HEAD
            body:
           cubit.index >= 5 ? Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text('The quiz has been finished you can click next to review your son answers',textAlign: TextAlign.center,style: GoogleFonts.cairo(fontSize: 20,fontWeight: FontWeight.bold),),
                ),
                SizedBox(height: 20,),
                if(cubit.index >=  5)
                  InkWell(
                    onTap: () {
                      KindergartenCubit.get(context).getUserData();
                      Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (context) => EvaluationPage()));
                      List<String> trueAnswer = ['apple', 'banana', 'carrot', 'grapes', 'lemon'];
                      ImageClassificationCubit.get(context).compareListss(labels,trueAnswer);
                      ImageClassificationCubit.get(context).countBooleans(ImageClassificationCubit.get(context).result);
                    },
                    child: Container(
                      height: 45,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(15)),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(' Next ',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)),
                          Icon(CupertinoIcons.arrow_right)
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ):
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20, top:8),
=======
            body: Padding(
              padding: const EdgeInsets.only(right: 20, left: 20, top: 1),
>>>>>>> kindergarten/master
              child: Column(
                children: [
                  Material(
                    borderRadius: BorderRadius.circular(6),
                    elevation: 10,
<<<<<<< HEAD
                    child:
                Container(
=======
                    child: Container(
>>>>>>> kindergarten/master
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(6),
                          color: const Color.fromRGBO(146, 218, 201, 10)),
                      width: double.infinity,
                      height: 160,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
<<<<<<< HEAD
                              'Question-${cubit.index + 1}:',
                              style: GoogleFonts.cairo(
                                  textStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
=======
                              'Question-${cubit.index+1}:',
                              style: GoogleFonts.cairo(
                                  textStyle: TextStyle(fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),

>>>>>>> kindergarten/master
                            ),
                            Expanded(
                              child: Text(
                                AdminCubit.get(context).questions[cubit.index],
                                style: const TextStyle(
                                    fontSize: 22,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
<<<<<<< HEAD
                        )
=======
                        ),
>>>>>>> kindergarten/master
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
<<<<<<< HEAD
                    height: 415,
=======
                    height: 413,
>>>>>>> kindergarten/master
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(255, 238, 192, 10),
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Container(
<<<<<<< HEAD
                            height: 224,
                            width: 224,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                    image: _imageFile == null
                                        ? AssetImage(
                                            'assets/images/defaultImage.jpg')
                                        : FileImage(_imageFile!)
                                            as ImageProvider))),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      if (cubit.index <
                          AdminCubit.get(context).questions.length - 1)
=======
                          height: 280,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: const DecorationImage(
                                  image: AssetImage('assets/images/ss.png'))),
                        ),
                      ),
                      if(cubit.index < cubit.questions.length-1)
>>>>>>> kindergarten/master
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: InkWell(
                            onTap: () {
<<<<<<< HEAD
                              _pickImage(context);

=======
                              cubit.changeQuestion(index,context);
                              index = cubit.index;
                              print(index);
>>>>>>> kindergarten/master
                            },
                            child: Container(
                              height: 45,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(15)),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(' Upload photo',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                  Icon(LineIcons.upload)
                                ],
                              ),
                            ),
                          ),
                        ),
                    ]),
<<<<<<< HEAD
                  ),
                  SizedBox(
                    height: 10,
                  ),

=======
                  )
>>>>>>> kindergarten/master
                ],
              ),
            ),
          );
        });
  }
<<<<<<< HEAD

  File? _imageFile;

  void _pickImage(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(
        source: ImageSource.gallery, maxHeight: 224, maxWidth: 224);
    if (pickedFile != null) {
      _imageFile = File(pickedFile.path);
      cubitImage.classifyImage(_imageFile!);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('No image selected.'),
        ),
      );
    }
  }
=======
>>>>>>> kindergarten/master
}
