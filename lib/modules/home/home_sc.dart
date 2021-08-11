import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel/layout/home_layout/cubit/cubit.dart';
import 'package:travel/layout/home_layout/cubit/states.dart';
import 'package:travel/modules/home/destinatoin/destination_sc.dart';
import 'package:travel/modules/home/destinatoin_details/destination_details.dart';
import 'package:travel/modules/home/showPost/show_post.dart';
import 'package:travel/shared/components/components.dart';
import 'package:travel/shared/components/conditional_builder.dart';
import 'package:travel/shared/components/constants.dart';
import 'package:travel/shared/styles/icon_broken.dart';
import 'package:travel/shared/styles/thems.dart';

import 'destinatoin/destination_sc.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
          appBar: firstDefaultAppBar(
            context: context,
            leading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Home',
                  style: TextStyle(color: BLUE),
                ),
              ],
            ),
            notifications: true,
          ),
          drawer: buildDrawer(context, cubit),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                      start: 20.0, top: 20.0, bottom: 20.0, end: 20.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 50.0,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(12.0)),
                          child: TextFormField(
                            style: TextStyle(fontSize: 15.0),
                            decoration: InputDecoration(
                                hintText: 'Search',
                                prefixIcon: Icon(
                                  IconBroken.Search,
                                ),
                                border: InputBorder.none),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                buildDivideLine(),
                Padding(
                  padding:
                      const EdgeInsetsDirectional.only(start: 20.0, end: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        languageModel(context).showPost!,
                        style: TextStyle(fontSize: 22.0),
                      ),
                      IconButton(
                        onPressed: () {
                          navigateTo(context, ShowPost());
                        },
                        icon: Icon(
                          appDirection(context) == TextDirection.ltr
                              ? IconBroken.Arrow___Right_2
                              : IconBroken.Arrow___Left_2,
                          size: 30.0,
                        ),
                      )
                    ],
                  ),
                ),
                buildDivideLine(),
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                      start: 20.0, end: 20.0, top: 20.0),
                  child: Column(
                    children: [
                      Container(
                        height: 80.0,
                        child: ListView.separated(
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              height: 65.0,
                              width: 121.0,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadiusDirectional.circular(10.0),
                                image: DecorationImage(
                                    image:
                                        AssetImage('assets/images/canada.png'),
                                    fit: BoxFit.cover),
                              ),
                              child: Center(
                                child: Text(
                                  'Canada',
                                  style: TextStyle(
                                      fontSize: 19.0, color: Colors.white),
                                ),
                              ),
                            );
                          },
                          itemCount: 10,
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              width: 10.0,
                            );
                          },
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                            top: 10.0, bottom: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              languageModel(context).popularDestination!,
                              style: TextStyle(fontSize: 22.0),
                            ),
                            IconButton(
                              onPressed: () {
                                navigateTo(context, DestinationScreen());
                              },
                              icon: Icon(
                                IconBroken.More_Circle,
                                size: 30.0,
                              ),
                            )
                          ],
                        ),
                      ),
                      ConditionalBuilder(
                        condition: cubit.dist.length != 0,
                        builder: (context) => Container(
                            height: 260,
                            width: double.infinity,
                            child: ListView.separated(
                              itemBuilder: (BuildContext context, int index) {
                                return buildItemDestination(
                                  image: cubit.dist[index].image,
                                  text: cubit.dist[index].country,
                                  subText: cubit.dist[index].dest_place,
                                  isFav: cubit.dist[index].favorite,
                                  onTap: () {
                                    cubit.getHotelDestination(
                                      index: index,
                                    );
                                    navigateTo(
                                        context,
                                        DestinationDetails(
                                          destIndex: index,
                                        ));
                                  },
                                  tapFav: () {
                                    cubit.addFavoritePopularDestination(
                                        index: index);
                                  },
                                );
                              },
                              itemCount: 2,
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return SizedBox(
                                  width: 10.0,
                                );
                              },
                              scrollDirection: Axis.vertical,
                            )),
                        fallback: (context) => Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                            top: 10.0, bottom: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              languageModel(context).explore!,
                              style: TextStyle(fontSize: 22.0),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 150.0,
                        child: ListView.separated(
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              height: 65.0,
                              width: 121.0,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadiusDirectional.circular(10.0),
                                image: DecorationImage(
                                    image:
                                        AssetImage('assets/images/canada.png'),
                                    fit: BoxFit.cover),
                              ),
                              child: Center(
                                child: Text(
                                  'Canada',
                                  style: TextStyle(
                                      fontSize: 19.0, color: Colors.white),
                                ),
                              ),
                            );
                          },
                          itemCount: 10,
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              width: 10.0,
                            );
                          },
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                            top: 10.0, bottom: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              languageModel(context).explore!,
                              style: TextStyle(fontSize: 22.0),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 260,
                        width: double.infinity,
                        child: ListView.separated(
                          itemBuilder: (BuildContext context, int index) {
                            return Row(
                              children: [
                                Expanded(
                                  child: Card(
                                    elevation: 5.0,
                                    child: Container(
                                      height: 120.0,
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadiusDirectional.only(
                                                topStart: Radius.circular(10.0),
                                                topEnd: Radius.circular(10.0)),
                                      ),
                                      child: Stack(
                                        alignment:
                                            AlignmentDirectional.topCenter,
                                        children: [
                                          Image(
                                            image: AssetImage(
                                                'assets/images/ball.png'),
                                            height: 75.0,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                          ),
                                          Positioned(
                                            top: 0.0,
                                            right: 0.0,
                                            child: Container(
                                              height: 30.0,
                                              width: 30.0,
                                              color: ORANGE,
                                              child: Icon(
                                                IconBroken.Bookmark,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 0.0,
                                            left: 0.0,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                          .only(
                                                      start: 8.0,
                                                      bottom: 8.0,
                                                      top: 8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Bali',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18.0),
                                                  ),
                                                  Text(
                                                    'Indonesia',
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
                            );
                          },
                          itemCount: 10,
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              width: 10.0,
                            );
                          },
                          scrollDirection: Axis.vertical,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
