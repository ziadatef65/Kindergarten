import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kindergarten1/layout/cubit/cubit.dart';
import 'package:kindergarten1/layout/kindergarten_layout.dart';
import 'package:kindergarten1/modules/login/login_screen.dart';
import 'package:kindergarten1/modules/on_boarding/on_boarding_screen1.dart';
import 'package:kindergarten1/modules/review/review_screen.dart';
import 'package:kindergarten1/modules/selected_course_screen/cubit/cubit.dart';
import 'package:kindergarten1/shared/block_observer.dart';
import 'package:kindergarten1/shared/components/constants.dart';
import 'package:kindergarten1/shared/network/local/cache_helper.dart';
import 'firebase_options.dart';
import 'model/cubit/cubit.dart';
import 'modules/admin/cubit/cubit.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  String childFullNames;
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  userId = CacheHelper.getData(key: 'userId');
  Widget widget;
  if (onBoarding != null) {
    if(userId != null)
    {
      widget = KindergartenLayout();
    }
    else
    {
      widget =LoginScreen();
    }
  } else {
    widget = OnBoardingScreen1();
  }

  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget? startWidget;

  MyApp({this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) =>
                KindergartenCubit()..getUserData()),
        BlocProvider(
            create: (BuildContext context) =>
                PlayerCubit('')),
        BlocProvider(
            create: (BuildContext context)=> AdminCubit()..getCourses(),
        ),
        BlocProvider(create: (context)=> ImageClassificationCubit()),


      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(),
        home:startWidget,
        // startWidget,
      ),
    );
  }
}
