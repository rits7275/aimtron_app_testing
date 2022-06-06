import 'package:aimtron_app/pages/login_utils/login_page.dart';
import 'package:flutter/material.dart';

import 'onboarding_contents.dart';
import 'size_config.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = PageController();
  int _currentPage = 0;
  List colors = [
    Color.fromARGB(188, 48, 86, 255),
    Color.fromARGB(218, 241, 91, 49),
    Color.fromARGB(218, 186, 241, 34),
    Color.fromARGB(255, 250, 250, 250)
  ];

  AnimatedContainer _buildDots({int? index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(50),
        ),
        color: const Color(0xFF000000),
      ),
      margin: const EdgeInsets.only(right: 5),
      height: 10,
      curve: Curves.easeInOut,
      width: _currentPage == index ? 20 : 10,
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double width = SizeConfig.screenW!;
    double height = SizeConfig.screenH!;
    double blockH = SizeConfig.blockH!;
    double blockV = SizeConfig.blockV!;

    return Scaffold(
      backgroundColor: colors[_currentPage],
      body: new GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: PageView.builder(
                  controller: _controller,
                  onPageChanged: (value) =>
                      setState(() => _currentPage = value),
                  itemCount: contents.length,
                  itemBuilder: (context, i) {
                    return Container(
                      // color: colors[i],
                      child: Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Column(
                          children: [
                            Image.asset(
                              contents[i].image,
                              height: SizeConfig.blockV! * 35,
                            ),
                            SizedBox(
                              height: (height >= 840) ? 60 : 30,
                            ),
                            Text(
                              contents[i].title,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: "Mulish",
                                fontWeight: FontWeight.w600,
                                fontSize: (width <= 550) ? 30 : 35,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              contents[i].desc,
                              style: TextStyle(
                                fontFamily: "Mulish",
                                fontWeight: FontWeight.w300,
                                fontSize: (width <= 550) ? 17 : 25,
                              ),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        contents.length,
                        (int index) => _buildDots(index: index),
                      ),
                    ),
                    _currentPage + 1 == contents.length
                        ? Padding(
                            padding: const EdgeInsets.all(30),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginPage(),
                                  ),
                                );
                              },
                              child: Text("START"),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.black,
                                shape: new RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                padding: (width <= 550)
                                    ? EdgeInsets.symmetric(
                                        horizontal: 100, vertical: 20)
                                    : EdgeInsets.symmetric(
                                        horizontal: width * 0.2, vertical: 25),
                                textStyle: TextStyle(
                                    fontSize: (width <= 550) ? 13 : 17),
                              ),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    _controller.jumpToPage(2);
                                  },
                                  child: Text(
                                    "SKIP",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  style: TextButton.styleFrom(
                                    elevation: 0,
                                    textStyle: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: (width <= 550) ? 13 : 17,
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    _controller.nextPage(
                                      duration: Duration(milliseconds: 250),
                                      curve: Curves.easeInOut,
                                    );
                                  },
                                  child: Text("NEXT"),
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.black,
                                    shape: new RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    elevation: 1,
                                    padding: (width <= 550)
                                        ? EdgeInsets.symmetric(
                                            horizontal: 30, vertical: 20)
                                        : EdgeInsets.symmetric(
                                            horizontal: 30, vertical: 25),
                                    textStyle: TextStyle(
                                        fontSize: (width <= 550) ? 13 : 17),
                                  ),
                                ),
                              ],
                            ),
                          )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
