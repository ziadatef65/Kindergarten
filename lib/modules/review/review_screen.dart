import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icon.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/components/constants.dart';
import '../../shared/network/local/cache_helper.dart';
import '../admin/cubit/cubit.dart';
import '../edit_user/edit_user_screen.dart';
import '../login/login_screen.dart';

class ReviewScreen extends StatelessWidget {
  final  List list;
  ReviewScreen(this.list);
@override
  Widget build(BuildContext context) {
   return BlocConsumer<KindergartenCubit, KindergartenStates>(
        listener: (context, index) {},
        builder: (context, index) {
          var cubit = KindergartenCubit.get(context);
          var userModel = KindergartenCubit.get(context).userModel;
          return Scaffold(
            backgroundColor: Colors.white,
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
                  TextButton(
                    child: Text(
                      'Logout',
                      style: GoogleFonts.cairo(
                          color: Colors.amber, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      AdminCubit
                          .get(context)
                          .course
                          .clear();
                      CacheHelper.removeData(key: 'userId')?.then((value) {
                        if (value!) {
                          userId = null;
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()),
                                  (route) => false);
                        }
                      });
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
              padding: const EdgeInsets.all(20),
              child: Container(
                width: double.infinity,
                height: 700,
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(15),
                  color: const Color.fromRGBO(255, 251,229 , 10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                      itemBuilder: (context,index){
                        return Container(
                          height: 80,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: list[index] == false ? const Color.fromRGBO(255, 204, 203, 10):const Color.fromRGBO(146, 218, 201, 10),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child:    Text('Question-${index+1}',style: GoogleFonts.aBeeZee(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                              ),
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: Text('${list[index]}',style: GoogleFonts.aBeeZee(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                              ),
                            ],
                          ),
                        );

                      },
                      separatorBuilder:(context,index) => const SizedBox(height: 15),
                      itemCount:list.length,
                  ),
                ),
              ),
            ),
          );
        });
     }
}

