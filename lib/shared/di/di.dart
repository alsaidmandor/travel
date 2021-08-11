import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel/shared/cubit/cubit.dart';
import 'package:travel/shared/network/local/cache_helper.dart';
import 'package:get_it/get_it.dart';

GetIt di = GetIt.I..allowReassignment = true;

Future init() async {
  final sp = await SharedPreferences.getInstance();

  di.registerLazySingleton<SharedPreferences>(
    () => sp,
  );

  di.registerLazySingleton<CacheHelper>(
    () => CacheImpl(
      di<SharedPreferences>(),
    ),
  );

  di.registerFactory<AppCubit>(
    () => AppCubit(),
  );
  // di.registerFactory<RegisterCubit>(
  //   () => RegisterCubit(
  //     di<Repository>(),
  //   ),
  // );

  // di.registerFactory<LoginCubit>(
  //   () => LoginCubit(
  //     di<Repository>(),
  //   ),
  // );

  // di.registerFactory<ForgetCubit>(
  //   () => ForgetCubit(
  //     di<Repository>(),
  //   ),
  // );

  // di.registerFactory<HomeCubit>(
  //   () => HomeCubit(),
  // );
}
