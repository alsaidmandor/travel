import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel/layout/home_layout/cubit/cubit.dart';
import 'package:travel/layout/home_layout/cubit/states.dart';
import 'package:travel/modules/home/hotel/hotel_sc.dart';
import 'package:travel/shared/components/components.dart';
import 'package:travel/shared/components/conditional_builder.dart';
import 'package:travel/shared/components/constants.dart';
import 'package:travel/shared/styles/icon_broken.dart';

class DestinationDetails extends StatelessWidget {
  final int destIndex;

  const DestinationDetails({Key? key, required this.destIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          return AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle(
                  statusBarColor: Colors.transparent,
                  statusBarIconBrightness: Brightness.light),
              child: Scaffold(
                body: Directionality(
                  textDirection: appDirection(context),
                  child: Container(
                    height: double.infinity,
                    child: Stack(
                      children: [
                        Image(
                            image: NetworkImage('${cubit.dist[destIndex].image}'),
                            height: 300,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) =>
                                Icon(IconBroken.Bag_2),),
                        Positioned(
                          top: 40.0,
                          left: 0.0,
                          child: leadingButton(context, color: true),
                        ),
                        Positioned(
                          top: 230.0,
                          left: 0.0,
                          child: Container(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadiusDirectional.circular(20.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.only(
                                start: 20.0,
                                end: 20.0,
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsetsDirectional.only(
                                        top: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${cubit.dist[destIndex].country} , ${cubit.dist[destIndex].dest_place}',
                                          style: TextStyle(fontSize: 21.0),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              cubit
                                                  .addFavoritePopularDestination(
                                                index: destIndex,
                                              );
                                            },
                                            icon: Icon(
                                              IconBroken.Bookmark,
                                              color: cubit.dist[destIndex]
                                                          .favorite ==
                                                      true
                                                  ? Colors.red
                                                  : Colors.black,
                                              size: 30.0,
                                            ))
                                      ],
                                    ),
                                  ),
                                  Text(
                                    '${cubit.dist[destIndex].description}',
                                    style:
                                        TextStyle(color: Colors.grey.shade500),
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.only(
                                        top: 10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          ' ${languageModel(context).hotel!} ${cubit.dist[destIndex].country} ',
                                          style: TextStyle(fontSize: 22.0),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            navigateTo(
                                                context,
                                                HotelScreen(
                                                  indexDest: destIndex,
                                                ));
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
                                    condition: cubit.hotel.length != 0,
                                    builder: (context) => Expanded(
                                      child: Container(
                                        width: double.infinity,
                                        child: ListView.separated(
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return buildItemHotelDetails(
                                                cubit, index);
                                          },
                                          physics: BouncingScrollPhysics(),
                                          itemCount: cubit.hotel.length,
                                          separatorBuilder:
                                              (BuildContext context,
                                                  int index) {
                                            return SizedBox(
                                              width: 10.0,
                                            );
                                          },
                                          scrollDirection: Axis.vertical,
                                        ),
                                      ),
                                    ),
                                    fallback: (context) => Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ));
        });
  }
}

/*
Stack(
alignment: Alignment.center,
children: [
Image(
image: AssetImage('assets/images/ball.png'),
height: 300,
width: double.infinity,
fit: BoxFit.cover,
),
Container(
color: Colors.red,
)
],
),*/
