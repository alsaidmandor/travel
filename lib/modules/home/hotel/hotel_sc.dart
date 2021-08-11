import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel/layout/home_layout/cubit/cubit.dart';
import 'package:travel/layout/home_layout/cubit/states.dart';
import 'package:travel/modules/home/hotel_details/Hotel_Details.dart';
import 'package:travel/shared/components/components.dart';
import 'package:travel/shared/components/conditional_builder.dart';
import 'package:travel/shared/components/constants.dart';
import 'package:travel/shared/styles/icon_broken.dart';
import 'package:travel/shared/styles/thems.dart';

class HotelScreen extends StatelessWidget {
  final int indexDest;

  HotelScreen({required this.indexDest});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
          appBar: secondDefaultAppBar(
            context: context,
            leading: true,
            title: Text(
              '${languageModel(context).bestHotelIn!} ${cubit.dist[indexDest].country}',
              style: TextStyle(fontSize: 22.0, color: BLUE),
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsetsDirectional.only(
                  start: 10.0, top: 20.0, bottom: 10.0, end: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                        top: 10.0, bottom: 10.0),
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
                  Expanded(
                    child: ConditionalBuilder(
                      condition: cubit.hotel.length != 0,
                      builder: (context) => Container(
                        width: double.infinity,
                        child: ListView.separated(
                          itemBuilder: (BuildContext context, int index) {
                            return buildItemDestination(
                                image: cubit.hotel[index].image,
                                text: cubit.hotel[index].name,
                                subText: cubit.hotel[index].name_map,
                                isFav: cubit.hotel[index].favorite,
                                onTap: () {
                                  navigateTo(
                                      context,
                                      HotelDetails(
                                        index: index,
                                        indexDest: indexDest,
                                      ));
                                },
                                tapFav: () {
                                  cubit.addFavoriteHotelPopularDestination(
                                      indexDest: indexDest, indexHotel: index);
                                });
                          },
                          itemCount: cubit.hotel.length,
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              width: 10.0,
                            );
                          },
                          scrollDirection: Axis.vertical,
                        ),
                      ),
                      fallback: (context) => Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
