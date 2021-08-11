import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel/layout/home_layout/cubit/cubit.dart';
import 'package:travel/modules/post/cubit/cubit.dart';
import 'package:travel/shared/bloc_observer.dart';
import 'package:travel/shared/components/constants.dart';
import 'package:travel/shared/cubit/cubit.dart';
import 'package:travel/shared/cubit/states.dart';
import 'package:travel/shared/di/di.dart';
import 'package:travel/shared/network/local/cache_helper.dart';
import 'package:travel/shared/styles/thems.dart';

import 'layout/home_layout/HomeLayout.dart';
import 'modules/Splash_Authentication/splash_auth_sc/SplashAuthenticationScreen.dart';
import 'modules/select_language/select_language_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  Bloc.observer = MyBlocObserver();

  await init();

  String? appLanguage = await getAppLanguage();

  String? translation = await rootBundle
      .loadString('assets/translations/${appLanguage ?? 'ar'}.json');

  Widget start;

  bool? appThemeMode = await getThemeMode();

  userId = di<CacheHelper>().getData(key: 'uId');
  if (appLanguage != null && userId != null) {
    start = HomeLayout();
  } else if (appLanguage != null && userId == null) {
    start = SplashAuthenticationScreen();
  } else {
    start = SelectLanguageScreen();
  }

  runApp(MyApp(
    translation: translation,
    isDark: appThemeMode,
    code: appLanguage ?? 'ar',
    start: start,
  ));
}

class MyApp extends StatelessWidget {
  String? translation;
  String? code;
  bool? isDark;
  Widget start;

  MyApp({
    this.translation,
    this.code,
    this.isDark,
    required this.start,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (BuildContext context) => AppCubit()
              ..getLanguage(
                translation: this.translation,
                code: this.code,
              )
              ..setAppThemeMode(
                dark: isDark ?? false,
              ),
          ),
          BlocProvider(
            create: (BuildContext context) => HomeCubit()
              ..getPopularDest()
              ..getFavoritePopularDestination(),
          ),
          BlocProvider(
            create: (BuildContext context) => PostCubit()..getPosts(),
          ),
        ],
        child: BlocConsumer<AppCubit, AppStates>(
            listener: (context, state) {},
            builder: (context, state) {
              var cubit = AppCubit.get(context);
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: lightTheme(context),
                darkTheme: darkTheme(context),
                themeMode: cubit.isDark ? ThemeMode.dark : ThemeMode.light,
                home: Directionality(
                  textDirection: appDirection(context),
                  child: start,
                ),
              );
            }));
  }
}
