import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:travel/modules/Splash_Authentication/login/Login_sc.dart';
import 'package:travel/modules/Splash_Authentication/register/Register_sc.dart';
import 'package:travel/shared/components/constants.dart';
import 'package:travel/shared/styles/thems.dart';

class SplashAuthenticationScreen extends StatelessWidget {
  const SplashAuthenticationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        SvgPicture.asset(
          'assets/images/background.svg',
          fit: BoxFit.cover,
        ),
        // buildMainButton('Login')
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 100.0,
            child: Column(
              children: [
                Expanded(
                  child: buildMainButton(
                      text: 'Login',
                      onTap: () {
                        navigateTo(context, LoginScreen());
                      }),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Expanded(
                  child: buildMainButton(
                      text: 'Create Account',
                      onTap: () {
                        navigateTo(context, RegisterScreen());
                      }),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

Widget buildMainButton(
    {String? text,
    double height = 50.0,
    double width = double.infinity,
    required Function onTap}) {
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
      color: ORANGE,
      borderRadius: BorderRadiusDirectional.circular(30.0),
    ),
    child: MaterialButton(
      child: Text(
        text!,
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
      onPressed: () {
        onTap();
      },
    ),
  );
}
