import 'package:flutter/material.dart';
import 'package:travel/models/language/language_model.dart';
import 'package:travel/modules/onboard/on_board_screen.dart';
import 'package:travel/shared/cubit/cubit.dart';
import 'package:travel/shared/di/di.dart';
import 'package:travel/shared/network/local/cache_helper.dart';
import 'package:travel/shared/styles/styles.dart';
import 'package:travel/shared/styles/thems.dart';

import '../styles/icon_broken.dart';
import 'animation_route.dart';

class CurrentLanguages {
  String? code;
  String? title;
  String? image;

  CurrentLanguages({
    this.title,
    this.code,
    this.image,
  });
}

var languagesList = [
  CurrentLanguages(
    code: 'en',
    title: 'English',
    image: 'assets/images/usa.jpg',
  ),
  CurrentLanguages(
    code: 'ar',
    title: 'العربية',
    image: 'assets/images/egypt.png',
  ),
];

String? userId = '';

AppBar firstDefaultAppBar({
  Widget? title,
  bool leading = false,
  bool notifications = false,
  bool search = false,
  bool theme = false,
  Widget? leadingIcon,
  List<Widget>? actions,
  required BuildContext context,
}) =>
    AppBar(
      titleSpacing: 20.0,
      leading: leadingIcon != null
          ? leadingIcon
          : leading
              ? leadingButton(context)
              : null,
      title: title,
      actions: actions ??
          [
            if (search) searchButton(context),
            if (notifications) notificationsButton(context),
            if (theme) themeButton(context),
          ],
    );

AppBar secondDefaultAppBar({
  required BuildContext context,
  bool leading = false,
  Widget? leadingIcon,
  Widget? title,
}) {
  return AppBar(
    leading: leadingIcon != null
        ? leadingIcon
        : leading
            ? Padding(
                padding: const EdgeInsetsDirectional.only(start: 10.0),
                child: leadingButton(context),
              )
            : null,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        title!,
      ],
    ),
    elevation: 0.0,
  );
}

Widget searchButton(context) => IconButton(
      icon: Icon(
        IconBroken.Search,
        // color: greyDarkColor(context),
      ),
      onPressed: () {},
    );

Widget notificationsButton(context) => IconButton(
      icon: Icon(
        IconBroken.Notification,
        color: greyDarkColor(context),
      ),
      onPressed: () {},
    );

Widget leadingButton(context, {bool color = false}) => IconButton(
      icon: Icon(
        appDirection(context) == TextDirection.ltr
            ? IconBroken.Arrow___Left_2
            : IconBroken.Arrow___Right_2,
        color: color ? Colors.white : BLUE,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
void navigateToSlideTransitionBottom(context, widget) => Navigator.push(
    context,
    SlideTransitionBottomRoute(
      page: widget,
    ));

void navigateToSlideTransition(context, widget) => Navigator.of(context).push(
      SlideTransitionRoute(
        page: widget,
      ),
    );

void navigateToScaleTransition(context, widget) =>
    Navigator.of(context).push(ScaleTransitionRoute(page: widget));

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
    (Route<dynamic> route) => false);

Widget themeButton(context) => IconButton(
      onPressed: () {
        AppCubit.get(context).changeAppThemeMode();
      },
      icon: Icon(
        Icons.brightness_medium,
        color: ORANGE,
      ),
    );

Widget buildLanguageItem(
        {CurrentLanguages? model, context, bool fromSettings = false}) =>
    InkWell(
      onTap: () {
        AppCubit.get(context)
            .changeAppDirection(
          code: model!.code,
          fromSettings: fromSettings,
        )
            .then((value) {
          if (fromSettings) {
            Navigator.pop(context);
          } else {
            navigateAndFinish(
              context,
              OnBoardScreen(),
            );
          }
        });
      },
      borderRadius: BorderRadius.circular(
        10.0,
      ),
      child: Row(
        children: [
          Container(
            width: 60.0,
            height: 40.0,
            decoration: BoxDecoration(
              color: ORANGE,
              borderRadius: BorderRadius.circular(
                3.0,
              ),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  model!.image!,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 20.0,
          ),
          Text(
            model.title!,
            style: black16(),
          ),
          Spacer(),
          if (getCurrentAppLanguage(context) == model.code && fromSettings)
            Icon(
              appDirection(context) == TextDirection.rtl
                  ? IconBroken.Arrow___Left_Circle
                  : IconBroken.Arrow___Right_Circle,
              color: ORANGE,
            ),
        ],
      ),
    );

LanguageModel languageModel(context) => AppCubit.get(context).languageModel;

TextDirection appDirection(context) => AppCubit.get(context).textDirection;

bool isAppDark(context) => AppCubit.get(context).isDark;

Future<bool?> getThemeMode() async => await di<CacheHelper>().get('themeMode');

Color? greyDarkColor(context) {
  if (isAppDark(context)) {
    return Colors.grey;
  }
  return null;
}

Future<String?> getAppLanguage() async =>
    await di<CacheHelper>().get('appLanguage');

String? getCurrentAppLanguage(context) =>
    AppCubit.get(context).currentAppLanguage;

Future<String?> getUserId() async {
  return await di<CacheHelper>().get('userId');
}

Future<dynamic> getIndex() async {
  return await di<CacheHelper>().getData(key: 'index');
}

const kAnimationDuration = Duration(milliseconds: 200);
