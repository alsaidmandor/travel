import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel/modules/categories/cubit/states.dart';

class CategoryCubit extends Cubit<CategoryStates> {
  CategoryCubit() : super(CategoryInitialState());

  static CategoryCubit get(context) => BlocProvider.of(context);

  List<String> items = ['Hotel', 'River', 'Mountain', 'Lake', 'City'];
  int? isSelectedIndex = 0;
  void changeIndexList({int? index}) {
    isSelectedIndex = index;
    emit(CategoryChangeIndexList(index: index));
  }
}
