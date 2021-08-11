import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:travel/modules/Splash_Authentication/splash_auth_sc/SplashAuthenticationScreen.dart';
import 'package:travel/shared/components/constants.dart';
import 'package:travel/shared/cubit/cubit.dart';
import 'package:travel/shared/styles/thems.dart';

class BoardModel {
  final String image;
  final String title;
  final String body;

  BoardModel({required this.image, required this.title,required this.body});
}

class OnBoardScreen extends StatefulWidget {
  @override
  _OnBoardScreenState createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
 late List<BoardModel> list;

  @override
  void initState() {
    super.initState();

    list = [
      BoardModel(
        image: 'assets/images/on_board_travel.svg',
        title: languageModel(context).b1title!,
        body: languageModel(context).b1body!,
      ),
      BoardModel(
        image: 'assets/images/on_board_map.svg',
        title: languageModel(context).b2title!,
        body: languageModel(context).b2body!,
      ),
    ];
  }

  var isLast = false;
  final controller = PageController();

  void submit() {
    navigateAndFinish(
      context,
      SplashAuthenticationScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: appDirection(context),
      child: Scaffold(
        appBar: firstDefaultAppBar(
          leadingIcon: IconButton(
            onPressed: () {
              AppCubit.get(context).changeAppThemeMode();
            },
            icon: Icon(
              Icons.brightness_medium,
              color: ORANGE,
            ),
          ),
          context: context,
          actions: [
            FlatButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                submit();
              },
              child: Text(
                languageModel(context).skip!,
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600],
                ),
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: PageView.builder(
                    physics: BouncingScrollPhysics(),
                    onPageChanged: (i) {
                      if (i == (list.length - 1) && !isLast)
                        setState(() => isLast = true);
                      else if (isLast) setState(() => isLast = false);
                    },
                    controller: controller,
                    itemCount: list.length,
                    itemBuilder: (ctx, i) => Padding(
                      padding: EdgeInsets.zero,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 30),
                          Text(
                            list[i].title,
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.w800,
                              color: BLUE,
                            ),
                          ),
                          SizedBox(height: 15.0),
                          Text(
                            list[i].body,
                            style: TextStyle(fontSize: 14.0, color: GREY),
                          ),
                          SizedBox(height: 15.0),
                          Expanded(
                            child: SvgPicture.asset(
                              list[i].image,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SmoothPageIndicator(
                      controller: controller,
                      effect: ExpandingDotsEffect(
                        dotColor: Colors.grey,
                        activeDotColor: Colors.blue,
                        dotHeight: 10,
                        expansionFactor: 4,
                        dotWidth: 10,
                        spacing: 5.0,
                      ),
                      count: list.length,
                    ),
                    FloatingActionButton(
                      backgroundColor: ORANGE,
                      onPressed: () {
                        if (isLast) {
                          submit();
                        } else
                          controller.nextPage(
                            duration: Duration(milliseconds: 750),
                            curve: Curves.fastLinearToSlowEaseIn,
                          );
                      },
                      child: Icon(
                        Icons.arrow_forward_ios,
                      ),
                    ),
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
