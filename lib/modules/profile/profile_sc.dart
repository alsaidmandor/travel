import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel/layout/home_layout/cubit/cubit.dart';
import 'package:travel/layout/home_layout/cubit/states.dart';
import 'package:travel/modules/home/showPost/show_post.dart';
import 'package:travel/modules/profile/Edit_Profile/Edit_Profile.dart';
import 'package:travel/shared/components/components.dart';
import 'package:travel/shared/components/conditional_builder.dart';
import 'package:travel/shared/components/constants.dart';
import 'package:travel/shared/styles/icon_broken.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context).userModel;
        return ConditionalBuilder(
          condition: cubit != null,
          builder: (context) => AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.light),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Container(
                    height: 290.0,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 210.0,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(4.0),
                                    topLeft: Radius.circular(4.0),
                                  ),
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: '${cubit!.cover}',
                                  fit: BoxFit.cover,
                                  progressIndicatorBuilder: (context, url,
                                          downloadProgress) =>
                                      Center(
                                          child: CircularProgressIndicator(
                                              value:
                                                  downloadProgress.progress)),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                              Positioned(
                                top: 50.0,
                                right: 30.0,
                                child: IconButton(
                                    icon: CircleAvatar(
                                      radius: 20.0,
                                      child: Icon(
                                        IconBroken.Camera,
                                        size: 16.0,
                                      ),
                                    ),
                                    onPressed: () {
                                      HomeCubit.get(context).getCoverImage(
                                        phone: cubit.phone!,
                                        name: cubit.name!,
                                        bio: cubit.bio!,
                                      );
                                    }),
                              )
                            ],
                          ),
                          alignment: AlignmentDirectional.topCenter,
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 64.0,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 60.0,
                                backgroundImage: NetworkImage('${cubit.image}'),
                              ),
                            ),
                            IconButton(
                                icon: CircleAvatar(
                                  radius: 20.0,
                                  child: Icon(
                                    IconBroken.Camera,
                                    size: 16.0,
                                  ),
                                ),
                                onPressed: () {
                                  HomeCubit.get(context).getProfileImage(
                                    phone: cubit.phone!,
                                    name: cubit.name!,
                                    bio: cubit.bio!,
                                  );
                                })
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(),
                      ),
                      Expanded(
                        flex: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '${cubit.name}',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            Text(
                              '${cubit.email}',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: IconButton(
                              onPressed: () {
                                navigateTo(
                                  context,
                                  EditProfileScreen(),
                                );
                              },
                              icon: Icon(IconBroken.Edit)),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  buildDivideLine(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            child: Column(
                              children: [
                                Text(
                                  '64',
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                                Text(
                                  'Following',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],
                            ),
                            onTap: () {},
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            child: Column(
                              children: [
                                Text(
                                  '10k',
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                                Text(
                                  'Followers',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],
                            ),
                            onTap: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                  buildDivideLine(),
                  SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                      start: 15.0,
                      end: 15.0,
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                languageModel(context).popularDestination!,
                                style: TextStyle(fontSize: 15.0),
                              ),
                              IconButton(
                                onPressed: () {
                                  navigateTo(context, ShowPost());
                                },
                                icon: Icon(
                                  IconBroken.More_Circle,
                                  size: 35.0,
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 100.0,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadiusDirectional.circular(8.0),
                                    color: Colors.teal,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                child: Container(
                                  height: 100.0,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadiusDirectional.circular(8.0),
                                    color: Colors.orange,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // add Favorite
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                languageModel(context).popularDestination!,
                                style: TextStyle(fontSize: 15.0),
                              ),
                              IconButton(
                                onPressed: () {
                                  navigateTo(context, ShowPost());
                                },
                                icon: Icon(
                                  IconBroken.More_Circle,
                                  size: 35.0,
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 100.0,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadiusDirectional.circular(8.0),
                                    color: Colors.teal,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                child: Container(
                                  height: 100.0,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadiusDirectional.circular(8.0),
                                    color: Colors.orange,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
