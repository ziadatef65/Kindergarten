import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kindergarten1/layout/cubit/cubit.dart';
import 'package:kindergarten1/layout/cubit/states.dart';
import 'package:kindergarten1/modules/edit_user/edit_user_screen.dart';
import 'package:kindergarten1/modules/login/login_screen.dart';
import 'package:kindergarten1/shared/components/constants.dart';
import 'package:line_icons/line_icon.dart';

import '../shared/network/local/cache_helper.dart';


class KindergartenLayout extends StatelessWidget {



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
                    icon: LineIcon.userEdit(color: Colors.amber,size: 30,),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>EditUserScreen()));
                    },
                  ),
                  TextButton(
                    child: Text('Logout',style: GoogleFonts.cairo(color: Colors.amber,fontWeight: FontWeight.bold),),
                    onPressed: (){
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
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeBottomNavBar(index);
              },
              elevation: 0,
              backgroundColor: Colors.white,
              selectedItemColor: Colors.amber,
              unselectedItemColor: Colors.black,
              items:  [
                BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.home, size: 30), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.video_collection_sharp,
                      size: 30,
                    ),
                    label: 'Courses'),
                BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.profile_circled, size: 30),
                    label: 'Profile'),
                if(userModel?.isAdmin == true)
                BottomNavigationBarItem(
                    icon: Icon(Icons.admin_panel_settings, size: 30),
                    label: 'Admin'),
              ],
            ));
      },
    );
  }
}
