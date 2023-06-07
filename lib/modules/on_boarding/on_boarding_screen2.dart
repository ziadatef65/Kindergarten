import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kindergarten1/modules/login/login_screen.dart';
import 'package:kindergarten1/shared/network/local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String image;
  final String text;

  BoardingModel(this.image, this.text);
}

List<BoardingModel> boarding = [
  BoardingModel(
    'assets/images/onBoarding1.png',
    'The Kindergarten application guarantees that your child will develop artistically and creatively, and you will definitely notice that with us.',
  ),
  BoardingModel('assets/images/onBoarding3.png',
      'The Kindergarten application provides an educational tool for the child through an entertaining, fun and unconventional atmosphere that helps him to absorb well'),
  BoardingModel('assets/images/onBoarding2.png',
      'The Kindergarten application provides the child with exploring the surrounding environment and learning the names of things through the mobile camera, which is inside the program.'),
];

var boardController = PageController(); // this variable to control the smooth page indicator
bool isLast = false;

void submit(BuildContext context,dynamic done1) {
  CacheHelper.saveData(key: 'onBoarding', value: true).then((dynamic value) {
    if (value = true) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
   done1 = true;
    }
  });
}

class OnBoardingScreen2 extends StatefulWidget {
  @override
  State<OnBoardingScreen2> createState() => _OnBoardingScreen2State();
}

class _OnBoardingScreen2State extends State<OnBoardingScreen2> {
  @override
  Widget build(BuildContext context,) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () => submit(context,true),
              child: Text(
                'Skip',
                style: GoogleFonts.poppins(color: Colors.white, fontSize: 16),
              ))
        ],
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        elevation: 0,
      ),
      backgroundColor: const Color.fromRGBO(17, 136, 204, 10),
      body: Padding(
        padding: const EdgeInsets.only(left: 40, right: 40, bottom: 40),
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: boardController,
                itemBuilder: (context, index) =>
                    buildBoardingItem(context, boarding[index]),
                itemCount: boarding.length,
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
              ),
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: boarding.length,
                  effect: ExpandingDotsEffect(
                    dotWidth: 15,
                    dotHeight: 15,
                    spacing: 10,
                    expansionFactor: 4,
                    activeDotColor: Colors.white,
                  ),
                ),
                const Spacer(),
                Container(
                  width: 109,
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 13,
                      ),
                      Text(
                        'Next',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Color.fromRGBO(17, 136, 204, 10),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          if (isLast) {
                            submit(context,true);
                          } else {
                            boardController.nextPage(
                                duration: Duration(
                                  milliseconds: 750,
                                ),
                                curve: Curves.bounceOut);
                          }
                        },
                        icon: const Icon(Icons.send_rounded),
                        color: Color.fromRGBO(17, 136, 204, 10),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

/*
the following method used for to make items of onBoarding
screen by make class model, and give it 2 variable image and text,
and make a list of type of Boarding Model
 */
  Widget buildBoardingItem(context, BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image(
            image: AssetImage(model.image),
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            model.text,
            style: GoogleFonts.poppins(fontSize: 20, color: Colors.white),
          ),
        ],
      );
}
