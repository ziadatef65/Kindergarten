import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kindergarten1/layout/cubit/cubit.dart';
import 'package:kindergarten1/layout/cubit/states.dart';
import 'package:line_icons/line_icons.dart';


class EditUserScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var ageController = TextEditingController();
  var genderController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  EditUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<KindergartenCubit, KindergartenStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = KindergartenCubit.get(context);
        var userModel = KindergartenCubit.get(context).userModel;
        var profileImage = KindergartenCubit.get(context).profileImage;
        nameController.text = userModel!.childFullName!;
        ageController.text = userModel.age!;
        genderController.text = userModel.gender!;
        return Scaffold(
          backgroundColor: Colors.white,
          body: Form(
            key: formKey,
            child: AnnotatedRegion<SystemUiOverlayStyle>(
              value: const SystemUiOverlayStyle(
                  statusBarColor: Color.fromRGBO(17, 136, 204, 0),
                  statusBarIconBrightness: Brightness.dark),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(190),
                        bottomLeft: Radius.circular(0),
                      ),
                      child: Container(
                        color: Colors.amber,
                        width: double.infinity,
                        height: 200,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              Stack(
                                  alignment: AlignmentDirectional.topStart,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.blueAccent,
                                      radius: 69,
                                      child: CircleAvatar(
                                        radius: 67,
                                        backgroundImage: profileImage == null
                                            ? NetworkImage(
                                                '${userModel.image}')
                                            : FileImage(profileImage)
                                                as ImageProvider,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        cubit.getProfileImage();
                                      },
                                      icon: const CircleAvatar(
                                        radius: 16,
                                        backgroundColor: Colors.blueAccent,
                                        child: CircleAvatar(
                                          radius: 14,
                                          backgroundColor:
                                              CupertinoColors.black,
                                          child: Icon(
                                            LineIcons.camera,
                                            size: 16,
                                            color: Colors.blueAccent,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]),
                              const SizedBox(
                                width: 5,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 40, left: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'Child Full-Name: ',
                                          style: GoogleFonts.cairo(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: CupertinoColors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 81,
                                          child: Tooltip(
                                            message:
                                                '${userModel.childFullName}',
                                            child: Text(
                                              ' ${userModel.childFullName}',
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.cairo(
                                                fontSize: 16,
                                                color: CupertinoColors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Age: ',
                                          style: GoogleFonts.cairo(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: CupertinoColors.white,
                                          ),
                                        ),
                                        Text(
                                          ' ${userModel.age}',
                                          style: GoogleFonts.cairo(
                                            fontSize: 16,
                                            color: CupertinoColors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Gender: ',
                                          style: GoogleFonts.cairo(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: CupertinoColors.white,
                                          ),
                                        ),
                                        Text(
                                          ' ${userModel.gender}',
                                          style: GoogleFonts.cairo(
                                            fontSize: 16,
                                            color: CupertinoColors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (state is UserUpdateLoading)
                      const Align(
                        alignment: AlignmentDirectional.topStart,
                        child: SizedBox(
                            width: 236,
                            child: LinearProgressIndicator(
                              minHeight: 5,
                              color: Colors.blueAccent,
                            )),
                      ),
                    const SizedBox(
                      height: 50,
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Name must not empty';
                                    }
                                  },
                                  controller: nameController,
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.blueAccent),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.amber),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    label: const Text(
                                      'Child Full-Name',
                                    ),
                                    floatingLabelStyle:
                                        const TextStyle(color: Colors.amber),
                                  )),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Age must not empty';
                                    }
                                  },
                                  controller: ageController,
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.blueAccent),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.amber),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    label: const Text(
                                      'Age',
                                    ),
                                    floatingLabelStyle:
                                        const TextStyle(color: Colors.amber),
                                  )),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                  controller: genderController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Gender must not empty';
                                    } else {
                                      if (value == 'male' ||
                                          value == 'female' ||
                                          value == 'Female' ||
                                          value == 'Male') {
                                        return null;
                                      } else {
                                        return 'Gender must be male or female';
                                      }
                                    }
                                  },
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.blueAccent),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.amber),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    label: const Text(
                                      'Gender',
                                    ),
                                    floatingLabelStyle:
                                        const TextStyle(color: Colors.amber),
                                  )),
                              const SizedBox(
                                height: 60,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      width: double.infinity,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.amber,
                                      ),
                                      child: TextButton(
                                          onPressed: () {
                                            if (formKey.currentState!
                                                .validate()) {
                                              cubit.updateUser(
                                                  name: nameController.text,
                                                  gender: genderController.text,
                                                  age: ageController.text);
                                            }
                                          },
                                          child: Text(
                                            'Update Info',
                                            style: GoogleFonts.cairo(
                                                color: Colors.white,
                                                fontSize: 20),
                                          )),
                                    ),
                                  ),
                                  if (cubit.profileImage != null)
                                    const SizedBox(
                                      width: 20,
                                    ),
                                  if (cubit.profileImage != null)
                                    Expanded(
                                      child: Container(
                                        width: double.infinity,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Colors.amber,
                                        ),
                                        child: TextButton(
                                            onPressed: () {
                                              if (formKey.currentState!
                                                  .validate()) {
                                                cubit.uploadProfileImage(
                                                    name: nameController.text,
                                                    gender:
                                                        genderController.text,
                                                    age: ageController.text);
                                              }
                                            },
                                            child: Text(
                                              'Update Image',
                                              style: GoogleFonts.cairo(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            )),
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
