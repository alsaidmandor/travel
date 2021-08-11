import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel/layout/home_layout/cubit/cubit.dart';
import 'package:travel/layout/home_layout/cubit/states.dart';
import 'package:travel/shared/components/components.dart';
import 'package:travel/shared/components/constants.dart';
import 'package:travel/shared/styles/icon_broken.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);

  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);

        nameController.text = cubit.userModel!.name!;
        bioController.text = cubit.userModel!.bio!;
        phoneController.text = cubit.userModel!.phone!;
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.light),
          child: Scaffold(
            appBar: firstDefaultAppBar(
              context: context,
              title: Text('Edit Profile'),
              actions: [
                defaultTextButton(
                    function: () {
                      HomeCubit.get(context).updateUser(
                          name: nameController.text,
                          phone: phoneController.text,
                          bio: bioController.text);
                    },
                    text: 'Update'),
                SizedBox(
                  width: 15.0,
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    if (state is HomeUserUpdateLoadingState)
                      LinearProgressIndicator(),
                    if (state is HomeUserUpdateLoadingState)
                      SizedBox(
                        height: 20.0,
                      ),
                    defaultFormField(
                      controller: nameController,
                      type: TextInputType.name,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return ' name must not empty';
                        }
                        return null;
                      },
                      label: 'Name',
                      prefix: IconBroken.User,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    defaultFormField(
                      controller: bioController,
                      type: TextInputType.text,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return ' bio must not empty';
                        }
                        return null;
                      },
                      label: 'Bio',
                      prefix: IconBroken.Info_Circle,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    defaultFormField(
                      controller: phoneController,
                      type: TextInputType.phone,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return ' phone number must not empty';
                        }
                        return null;
                      },
                      label: 'Phone',
                      prefix: IconBroken.Call,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
