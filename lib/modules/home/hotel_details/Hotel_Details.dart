import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel/layout/home_layout/cubit/cubit.dart';
import 'package:travel/layout/home_layout/cubit/states.dart';
import 'package:travel/modules/Splash_Authentication/splash_auth_sc/SplashAuthenticationScreen.dart';
import 'package:travel/shared/components/constants.dart';
import 'package:travel/shared/styles/icon_broken.dart';
import 'package:travel/shared/styles/thems.dart';

class HotelDetails extends StatelessWidget {
  final int index;
  final int indexDest;

  HotelDetails({Key? key, required this.index, required this.indexDest})
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
                child: Column(
                  children: [
                    Expanded(
                      flex: 9,
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadiusDirectional.only(
                              bottomStart: Radius.circular(15.0),
                              bottomEnd: Radius.circular(15.0),
                            ),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              onError: (exception, stackTrace) =>
                                  Icon(Icons.error),
                              image: NetworkImage(
                                '${cubit.hotel[index].image}',
                              ),
                            )),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Padding(
                          padding: const EdgeInsetsDirectional.only(
                              start: 15.0, bottom: 5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsetsDirectional.only(top: 45.0),
                                child: leadingButton(context, color: true),
                              ),
                              Expanded(
                                child: Container(
                                  width: double.infinity,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Expanded(
                                    child: Container(
                                      width: double.infinity,
                                    ),
                                    flex: 6,
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: 40.0,
                                      width: 65.0,
                                      decoration: BoxDecoration(
                                        color: BLUE,
                                        borderRadius:
                                            BorderRadiusDirectional.only(
                                          topStart: Radius.circular(15.0),
                                          bottomStart: Radius.circular(15.0),
                                        ),
                                      ),
                                      child: IconButton(
                                        icon: Icon(
                                          IconBroken.Bookmark,
                                          color: cubit.hotel[index].favorite ==
                                                  true
                                              ? Colors.red
                                              : Colors.white,
                                          size: 25.0,
                                        ),
                                        onPressed: () {
                                          cubit
                                              .addFavoriteHotelPopularDestination(
                                                  indexDest: indexDest,
                                                  indexHotel: index);
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Flexible(
                                child: Text(
                                  '${cubit.hotel[index].name}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 21.0,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    IconBroken.Location,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Flexible(
                                    child: Text(
                                      '${cubit.hotel[index].name_map}',
                                      maxLines: 2,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.only(
                                      end: 10.0),
                                  child: Text(
                                    '${cubit.hotel[index].description}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13.0,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  buildMainButton(
                                      onTap: () {},
                                      text: 'Open Maps',
                                      width: 150.0,
                                      height: 40.0),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(
                              '  More photos',
                              style: TextStyle(fontSize: 19.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

/*
* Stack(
                          children: [
                            CachedNetworkImage(
                              imageUrl: '${cubit.hotel[index].image}',
                              height: double.infinity,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) => Center(
                                      child: CircularProgressIndicator(
                                          value: downloadProgress.progress)),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsetsDirectional.only(top: 45.0),
                              child: leadingButton(context, color: true),
                            ),
                            Positioned(
                              top: 80.0,
                              left: 0.0,
                              child: Column(
                                children: [
                                  /* Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${cubit.hotel[index].name}',
                                        style: TextStyle(
                                          fontSize: 21.0,
                                        ),
                                      ),
                                      Container(
                                        height: 38.0,
                                        width: 50.0,
                                        decoration: BoxDecoration(
                                          color: BLUE,
                                          borderRadius:
                                              BorderRadiusDirectional.only(
                                            topStart: Radius.circular(10.0),
                                            bottomStart: Radius.circular(10.0),
                                          ),
                                        ),
                                        child: Center(
                                          child: IconButton(
                                            icon: Icon(IconBroken.Bookmark),
                                            onPressed: () {},
                                          ),
                                        ),
                                      )
                                    ],
                                  ),*/
                                ],
                              ),
                            )
                          ],
                        ),*/
