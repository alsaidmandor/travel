import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel/layout/home_layout/cubit/cubit.dart';
import 'package:travel/layout/home_layout/cubit/states.dart';
import 'package:travel/models/hotel.dart';
import 'package:travel/modules/home/destinatoin_details/destination_details.dart';
import 'package:travel/shared/components/components.dart';
import 'package:travel/shared/components/constants.dart';
import 'package:travel/shared/styles/icon_broken.dart';
import 'package:travel/shared/styles/thems.dart';

class DestinationScreen extends StatelessWidget {
  List<Hotel> hotel = [];

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
              languageModel(context).popularDestination!,
              style: TextStyle(fontSize: 22.0, color: BLUE),
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsetsDirectional.only(
                  start: 10.0, top: 20.0, bottom: 10.0, end: 10.0),
              child: Column(
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
                    child: Container(
                      width: double.infinity,
                      child: ListView.separated(
                        itemBuilder: (BuildContext context, int index) {
                          return buildItemDestination(
                            image: cubit.dist[index].image,
                            text: cubit.dist[index].country,
                            subText: cubit.dist[index].dest_place,
                            isFav: cubit.dist[index].favorite,
                            onTap: () {
                              cubit.getHotelDestination(index: index);
                              navigateTo(
                                  context,
                                  DestinationDetails(
                                    destIndex: index,
                                  ));
                            },
                            tapFav: () {
                              cubit.addFavoritePopularDestination(index: index);
                            },
                          );
                        },
                        itemCount: cubit.dist.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            width: 10.0,
                          );
                        },
                        scrollDirection: Axis.vertical,
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
