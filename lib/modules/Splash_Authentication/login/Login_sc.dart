import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:travel/layout/home_layout/HomeLayout.dart';
import 'package:travel/modules/Splash_Authentication/splash_auth_sc/SplashAuthenticationScreen.dart';
import 'package:travel/shared/components/components.dart';
import 'package:travel/shared/components/conditional_builder.dart';
import 'package:travel/shared/components/constants.dart';
import 'package:travel/shared/cubit/cubit.dart';
import 'package:travel/shared/di/di.dart';
import 'package:travel/shared/network/local/cache_helper.dart';
import 'package:travel/shared/styles/thems.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginErrorState) {
            showToast(
              text: "Error",
              color: ToastColors.ERROR,
            );
          }
          if (state is LoginSuccessState) {
            di<CacheHelper>()
                .saveData(key: 'uId', value: state.uId)
                .then((value) {
              navigateAndFinish(context, HomeLayout());
            });
          }
        },
        builder: (context, state) {
          return Directionality(
            textDirection: AppCubit.get(context).textDirection,
            child: Container(
              width: double.infinity,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Positioned(
                    bottom: 0.0,
                    left: 0.0,
                    child: SvgPicture.asset(
                      'assets/images/background.svg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 80.0,
                            ),
                            Text(
                              "Login",
                              style: TextStyle(
                                color: ORANGE,
                                fontSize: 33,
                                decoration: TextDecoration.none,
                              ), // removes yellow line
                            ),
                            SizedBox(
                              height: 30.0,
                            ),
                            Container(
                              height: 200.0,
                              width: double.infinity,
                              child: Card(
                                elevation: 0.8,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      defaultFormField(
                                        controller: emailController,
                                        type: TextInputType.emailAddress,
                                        validate: (String value) {
                                          if (value.isEmpty) {
                                            return 'please enter your email address';
                                          }
                                        },
                                        label: 'Email Address',
                                        prefix: Icons.email_outlined,
                                      ),
                                      SizedBox(
                                        height: 15.0,
                                      ),
                                      defaultFormField(
                                        controller: passwordController,
                                        type: TextInputType.visiblePassword,
                                        suffix: LoginCubit.get(context).suffix,
                                        onSubmit: (value) {},
                                        isPassword:
                                            LoginCubit.get(context).isPassword,
                                        suffixPressed: () {
                                          LoginCubit.get(context)
                                              .changePasswordVisibility();
                                        },
                                        validate: (String value) {
                                          if (value.isEmpty) {
                                            return 'password is too short';
                                          }
                                        },
                                        label: 'Password',
                                        prefix: Icons.lock_outline,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30.0,
                            ),
                            ConditionalBuilder(
                              condition: state is! LoginLoadingState,
                              builder: (context) => Container(
                                height: 50.0,
                                child: buildMainButton(
                                    text: 'LOGIN',
                                    onTap: () {
                                      if (formKey.currentState!.validate()) {
                                        LoginCubit.get(context).userLogin(
                                          email: emailController.text,
                                          password: passwordController.text,
                                        );
                                      }
                                    }),
                              ),
                              fallback: (context) =>
                                  Center(child: CircularProgressIndicator()),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
