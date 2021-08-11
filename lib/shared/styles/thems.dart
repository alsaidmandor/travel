import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:travel/shared/cubit/cubit.dart';

const ORANGE = Colors.orange;
const WHITE1 = Color(0xFFFFFFFF);
const WHITE2 = Color(0xFFD8D8D8);
const BLUE = Color(0xFF312DA4);
const BLUE2 = Color(0xFF463EC9);
const GREY = Color(0xFF707070);
final name = HexColor('f38000');
final search = HexColor('EDEDED');

ThemeData darkTheme(context) => ThemeData(
      primarySwatch: ORANGE,
      scaffoldBackgroundColor: HexColor('333739'),
      appBarTheme: AppBarTheme(
        titleSpacing: 20.0,
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: HexColor('333739'),
          statusBarIconBrightness: Brightness.light,
        ),
        // brightness: isAppDark(context) ? Brightness.dark : Brightness.light,
        backgroundColor: HexColor('333739'),
        elevation: 0.0,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: BLUE,
        unselectedItemColor: Colors.grey,
        elevation: 20.0,
        backgroundColor: HexColor('333739'),
      ),
      textTheme: TextTheme(
        bodyText1: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        headline6: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w300,
          color: Colors.white,
        ),
        subtitle1: TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.w300,
          color: Colors.white,
        ),
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      fontFamily: AppCubit.get(context).appFontFamily,
    );

ThemeData lightTheme(context) => ThemeData(
      primarySwatch: ORANGE,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
        titleSpacing: 20.0,
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
        // brightness: isAppDark(context) ? Brightness.dark : Brightness.light,
        backgroundColor: Colors.white,
        elevation: 0.0,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: BLUE,
        unselectedItemColor: Colors.grey,
        elevation: 20.0,
        backgroundColor: Colors.white,
      ),
      textTheme: TextTheme(
        bodyText1: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        headline6: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w300,
          color: Colors.black,
        ),
        subtitle1: TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.w300,
          color: Colors.black,
        ),
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      fontFamily: AppCubit.get(context).appFontFamily,
    );
