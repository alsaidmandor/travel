import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel/models/language/language_model.dart';
import 'package:travel/shared/cubit/states.dart';
import 'package:travel/shared/di/di.dart';
import 'package:travel/shared/network/local/cache_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppStateInitial());

  static AppCubit get(context) => BlocProvider.of(context);

  late LanguageModel languageModel;
  String appFontFamily = 'Jannah';
  String currentAppLanguage = '';

  bool isDark = false;

  TextDirection textDirection = TextDirection.rtl;

  changeAppThemeMode() {
    isDark = !isDark;

    di<CacheHelper>().put('themeMode', isDark).then((value) {
      emit(AppStateChangeAppThemeMode());
    }).catchError((error) {
      print(error.toString());
    });
  }

  setAppThemeMode({required bool dark}) {
    isDark = dark;
    emit(AppStateChangeAppThemeMode());
  }

  changeAppFontFamily({
    required String family,
  }) {
    appFontFamily = family;

    emit(AppStateSetAppFontFamily());
  }

  Future<void> changeAppDirection({
    String? code,
    bool fromSettings = false,
  }) async {
    if (code == 'ar') {
      changeAppFontFamily(family: 'Jannah');
      textDirection = TextDirection.rtl;

      if (fromSettings) {
        await rootBundle
            .loadString('assets/translations/ar.json')
            .then((value) {
          getLanguage(
            translation: value,
          );
        });
      }

      return di<CacheHelper>().put('appLanguage', 'ar').then((value) {
        currentAppLanguage = code!;

        emit(AppStateSetAppDirection());
      }).catchError((error) {
        print(error.toString());

        emit(AppStateSetAppDirection());
      });
    } else {
      changeAppFontFamily(family: 'SFProDisplay');

      textDirection = TextDirection.ltr;

      return await rootBundle
          .loadString('assets/translations/en.json')
          .then((value) {
        getLanguage(
          translation: value,
        );

        di<CacheHelper>().put('appLanguage', 'en').then((value) {
          currentAppLanguage = code!;
        }).catchError((error) {
          print(error.toString());
        });

        emit(AppStateSetAppDirection());
      });
    }
  }

  getLanguage({
    String? translation,
    String? code,
  }) {
    languageModel = LanguageModel.fromJson(translation);

    if (code != null) {
      currentAppLanguage = code;
      textDirection = code == 'ar' ? TextDirection.rtl : TextDirection.ltr;
    }

    emit(AppStateGetLanguage());
  }

  List<Widget> bottomWidgets = [
    // HomeScreen(),
    // CategoriesScreen(),
    // FavoriteScreen(),
    // ProfileScreen(),
  ];

  int currentIndex = 0;

  void changeBottomIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomIndexState());
  }
}
