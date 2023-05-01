import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
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
            body: Padding(
              padding: const EdgeInsets.only(right: 20, left: 20, top: 1),
              child: Column(
                children: [
                  Material(
                    borderRadius: BorderRadius.circular(6),
                    elevation: 10,
                    child: Container(
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
                              'Question-${cubit.index+1}:',
                              style: GoogleFonts.cairo(
                                  textStyle: TextStyle(fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),

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
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 413,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(255, 238, 192, 10),
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Container(
                          height: 280,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: const DecorationImage(
                                  image: AssetImage('assets/images/ss.png'))),
                        ),
                      ),
                      if(cubit.index < cubit.questions.length-1)
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: InkWell(
                            onTap: () {
                              cubit.changeQuestion(index,context);
                              index = cubit.index;
                              print(index);
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
                  )
                ],
              ),
            ),
          );
        });
  }
}
