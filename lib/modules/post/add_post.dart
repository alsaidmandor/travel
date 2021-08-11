import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel/modules/Splash_Authentication/splash_auth_sc/SplashAuthenticationScreen.dart';
import 'package:travel/modules/post/cubit/cubit.dart';
import 'package:travel/shared/components/conditional_builder.dart';
import 'package:travel/shared/components/constants.dart';
import 'package:travel/shared/styles/icon_broken.dart';
import 'package:travel/shared/styles/thems.dart';

import 'cubit/states.dart';

class AddPostScreen extends StatelessWidget {
  String? countrySelected;

  var placeController = TextEditingController();
  var descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostCubit, PostStates>(
      listener: (context, state) {
        if (state is ChangeNameCountrySelected) {
          countrySelected = state.country;
        }
      },
      builder: (context, state) {
        var cubit = PostCubit.get(context);
        return Scaffold(
          appBar: secondDefaultAppBar(
            context: context,
            title: Text(
              'AddPost',
              style: TextStyle(fontSize: 20.0, color: BLUE),
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        showCountryPicker(
                          context: context,
                          showPhoneCode: false,
                          onSelect: (Country country) {
                            cubit.changeCountry(country.name);
                          },
                          // Optional. Sets the theme for the country list picker.
                          countryListTheme: CountryListThemeData(
                            // Optional. Sets the border radius for the bottomsheet.
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0),
                            ),
                            textStyle: TextStyle(fontSize: 12.0),
                            // Optional. Styles the search field.
                            inputDecoration: InputDecoration(
                              labelText: 'Search',
                              hintText: 'Start typing to search',
                              prefixIcon: const Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color:
                                      const Color(0xFF8C98A8).withOpacity(0.2),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 40.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(
                                      width: 2, color: Colors.grey.shade200)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsetsDirectional.only(
                                        start: 12.0),
                                    child: Text(countrySelected ?? 'Country'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    InkWell(
                      onTap: () {
                        cubit.getPostImage();
                      },
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 200,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(
                                    width: 2, color: Colors.grey.shade200),
                              ),
                              child: cubit.postImage != null
                                  ? Image(
                                      image: FileImage(cubit.postImage!),
                                      fit: BoxFit.cover,
                                    )
                                  : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(IconBroken.Image_2),
                                        Text('Choose Picture'),
                                      ],
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Container(
                      height: 45.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                              width: 2, color: Colors.grey.shade200)),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.only(start: 8.0),
                        child: TextFormField(
                          controller: placeController,
                          style: TextStyle(fontSize: 12.0),
                          decoration: InputDecoration(
                              hintText: 'Place', border: InputBorder.none),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                              width: 2, color: Colors.grey.shade200)),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.only(start: 8.0),
                        child: TextFormField(
                          controller: descriptionController,
                          keyboardType: TextInputType.multiline,
                          maxLines: 4,
                          style: TextStyle(fontSize: 12.0),
                          decoration: InputDecoration(
                              hintText: 'About Photo',
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    ConditionalBuilder(
                      condition: state is! CreatePostLoadingState,
                      builder: (context) => buildMainButton(
                        onTap: () {
                          if (countrySelected != null ||
                              placeController.text.isNotEmpty ||
                              descriptionController.text.isNotEmpty) {
                            cubit.uploadPostImage(
                                country: countrySelected,
                                place: placeController.text,
                                aboutImage: descriptionController.text);
                            countrySelected = null;
                            placeController.text = '';
                            descriptionController.text = '';
                            cubit.removePostImage();
                          }
                        },
                        height: 40,
                        width: 100.0,
                        text: 'share',
                      ),
                      fallback: (context) =>
                          Center(child: CircularProgressIndicator()),
                    )
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
