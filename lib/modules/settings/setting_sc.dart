import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel/layout/home_layout/cubit/cubit.dart';
import 'package:travel/layout/home_layout/cubit/states.dart';
import 'package:travel/shared/components/components.dart';
import 'package:travel/shared/components/constants.dart';
import 'package:travel/shared/styles/thems.dart';

class SettingScreen extends StatelessWidget {

  String? countrySelected;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(listener: (context, state) {
      if (state is HomeChangeNameCountrySelected) {
        countrySelected = state.country;
      }
    }, builder: (context, state) {
      var cubit = HomeCubit.get(context);
      return Scaffold(
        appBar: firstDefaultAppBar(
            context: context,
            title: Text(
              'Settings',
              style: TextStyle(color: BLUE2),
            ),
            leading: true,
            actions: [themeButton(context)]),
        body: Column(
          children: [
            itemSettings(
                title: 'Country',
                onTap: () {
                  showCountryPicker(
                    context: context,
                    showPhoneCode: false,
                    onSelect: (Country country) {
                      cubit.changeCountrySetting(country.name);
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
                            color: const Color(0xFF8C98A8).withOpacity(0.2),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                trailText: Text(countrySelected ?? 'Country')),
            itemSettings(title: 'Privacy policy', onTap: () {}),
            itemSettings(title: 'Support & FAQs', onTap: () {}),
            itemSettings(title: 'Change password', onTap: () {}),
            itemSettings(title: 'Log Out', onTap: () {}),
          ],
        ),
      );
    });
  }

  Widget itemSettings({String? title, Function? onTap, Widget? trailText}) {
    return Column(
      children: [
        Container(
          height: 60.0,
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: ListTile(
              title: Text(title!),
              trailing: trailText,
              onTap: () {
                onTap!();
              },
            ),
          ),
        ),
        buildDivideLine()
      ],
    );
  }
}
