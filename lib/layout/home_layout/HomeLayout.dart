import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel/layout/home_layout/cubit/cubit.dart';
import 'package:travel/layout/home_layout/cubit/states.dart';
import 'package:travel/shared/styles/icon_broken.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        // if(state  is SocialNewPostState)
        // {
        //   navigateTo(context, NewPostScreen(),);
        // }
      },
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNav(index);
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    IconBroken.Home,
                  ),
                  label: ''),
              BottomNavigationBarItem(
                  icon: Icon(
                    IconBroken.Category,
                  ),
                  label: ''),
              BottomNavigationBarItem(
                  icon: Icon(
                    IconBroken.Plus,
                  ),
                  label: ''),
              BottomNavigationBarItem(
                  icon: Icon(
                    IconBroken.Heart,
                  ),
                  label: ''),
              BottomNavigationBarItem(
                  icon: Icon(
                    IconBroken.Profile,
                  ),
                  label: ''),
            ],
          ),

          /*ConditionalBuilder(
            condition: SocialCubit.get(context).userModel != null,
            builder: (context) {
              var model = SocialCubit.get(context).userModel;
              return Column(
                children: [
                  // if (!FirebaseAuth.instance.currentUser.emailVerified)
                  //   Container(
                  //     color: Colors.amber.withOpacity(0.6),
                  //     child: Padding(
                  //       padding: const EdgeInsets.symmetric(
                  //         horizontal: 20.0,
                  //       ),
                  //       child: Row(
                  //         children: [
                  //           Icon(
                  //             Icons.info_outline,
                  //           ),
                  //           SizedBox(
                  //             width: 15.0,
                  //           ),
                  //           Expanded(
                  //             child: Text(
                  //               'Please verify your email',
                  //             ),
                  //           ),
                  //           SizedBox(
                  //             width: 20.0,
                  //           ),
                  //           defaultTextButton(
                  //             function: () {
                  //               FirebaseAuth.instance.currentUser
                  //                   .sendEmailVerification()
                  //                   .then((value) {
                  //                 showToast(
                  //                   text: 'Check your mail',
                  //                   state: ToastStates.SUCCESS,
                  //                 );
                  //               }).catchError((error) {});
                  //             },
                  //             text: 'send ',
                  //           )
                  //         ],
                  //       ),
                  //     ),
                  //   )
                ],
              );
            },
            fallback: (context) => Center(
              child: CircularProgressIndicator(),
            ),
          )*/
        );
      },
    );
  }
}
