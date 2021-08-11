import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:travel/layout/home_layout/cubit/cubit.dart';
import 'package:travel/modules/settings/setting_sc.dart';
import 'package:travel/shared/components/constants.dart';
import 'package:travel/shared/styles/icon_broken.dart';
import 'package:travel/shared/styles/thems.dart';

void showToast({
  required String text,
  required ToastColors color,
}) {
  Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: setToastColor(color),
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

enum ToastColors {
  SUCCESS,
  ERROR,
  WARNING,
}

Color setToastColor(ToastColors color) {
  Color c;

  switch (color) {
    case ToastColors.ERROR:
      c = Colors.red;
      break;
    case ToastColors.SUCCESS:
      c = Colors.green;
      break;
    case ToastColors.WARNING:
      c = Colors.amber;
      break;
  }

  return c;
}

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function? onSubmit,
  Function? onChange,
  Function? onTap,
  bool isPassword = false,
  required Function validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function? suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: (value) {
        onSubmit!(value);
      },
      // onChanged: (value) {
      //   onChange!(value);
      // },
      onTap: () {
        onTap!();
      },
      validator: (value) {
        validate(value);
      },
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: () {
                  suffixPressed!();
                },
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: OutlineInputBorder(),
      ),
    );

Widget buildItemDestination({
  String? image,
  String? text,
  String? subText,
  Color? color,
  String? nameUser,
  bool? isFav = true,
  required Function onTap,
  required Function tapFav,
}) {
  return GestureDetector(
    onTap: () {
      onTap();
    },
    child: Row(
      children: [
        Expanded(
          child: Card(
            elevation: 5.0,
            child: Container(
              height: 120.0,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.only(
                    topStart: Radius.circular(10.0),
                    topEnd: Radius.circular(10.0)),
              ),
              child: Stack(
                alignment: AlignmentDirectional.topCenter,
                children: [
                  Image(
                      image: NetworkImage('$image'),
                      height: 75.0,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) =>
                          Icon(IconBroken.Image)),
                  if (nameUser != null)
                    Positioned(
                      top: 0.0,
                      left: 0.0,
                      child: Padding(
                        padding: const EdgeInsetsDirectional.only(
                            start: 8.0, top: 8.0),
                        child: Text(
                          nameUser,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  Positioned(
                    top: 0.0,
                    right: 0.0,
                    child: Container(
                      height: 45.0,
                      width: 45.0,
                      color: ORANGE,
                      child: IconButton(
                        onPressed: () {
                          tapFav();
                        },
                        icon: Center(
                          child: Icon(
                            IconBroken.Bookmark,
                            color: isFav == true ? Colors.red : Colors.white,
                            size: 30.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0.0,
                    left: 0.0,
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(
                          start: 8.0, bottom: 8.0, top: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '$text',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18.0),
                          ),
                          Text(
                            '$subText',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 11,
                              height: 0.9,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Row buildItemHotelDetails(HomeCubit cubit, int index) {
  return Row(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0),
        child: Card(
          elevation: 7,
          child: Container(
            height: 90,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image(
                      image: NetworkImage('${cubit.hotel[index].image}'),
                      height: 70,
                      width: 60,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) =>
                          Icon(IconBroken.Image)),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(start: 8.0),
                    child: ConstrainedBox(
                      constraints: BoxConstraints.expand(width: 220),
                      child: Column(
                        children: [
                          Text(
                            '${cubit.hotel[index].name}',
                            style: TextStyle(fontSize: 18.0),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            '${cubit.hotel[index].name_map}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              height: 1.8,
                              fontSize: 10.4,
                              color: Colors.grey.shade400,
                            ),
                            softWrap: true,
                          ),
                        ],
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

Widget buildDivideLine() {
  return Container(
    height: 1,
    color: Colors.grey.shade200,
  );
}

Widget defaultTextButton({
  required Function function,
  required String text,
}) =>
    TextButton(
      onPressed: () {
        function();
      },
      child: Text(
        text.toUpperCase(),
      ),
    );

Widget defaultButton({
  double width = double.infinity,
  Color background = ORANGE,
  bool isUpperCase = true,
  double radius = 3.0,
  required Function function,
  required String text,
}) =>
    Container(
      width: width,
      height: 40.0,
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
    );

Drawer buildDrawer(BuildContext context, HomeCubit cubit) {
  return Drawer(
    child: ListView(
      children: [
        Container(
          color: BLUE2,
          height: 80.0,
          child: Center(
            child: ListTile(
              leading: CircleAvatar(
                radius: 35.0,
                backgroundImage: NetworkImage('${cubit.userModel!.image}'),
              ),
              title: Text(
                'Hello , ${cubit.userModel!.name}',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        itemDrawer(
            title: 'Settings',
            onTap: () {
              navigateTo(context, SettingScreen());
            }),
        itemDrawer(title: 'Privacy policy', onTap: () {}),
        itemDrawer(title: 'Support & FAQs', onTap: () {}),
        itemDrawer(title: 'Contect', onTap: () {}),
        itemDrawer(title: 'Profile', onTap: () {}),
        itemDrawer(title: 'Log Out', onTap: () {}),
      ],
    ),
  );
}

Widget itemDrawer({String? title, Function? onTap}) {
  return Column(
    children: [
      Container(
        height: 60.0,
        child: Center(
          child: ListTile(
            title: Text(
              title!,
            ),
            onTap: () {
              onTap!();
            },
          ),
        ),
      ),
      buildDivideLine(),
    ],
  );
}
