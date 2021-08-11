import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel/layout/home_layout/cubit/cubit.dart';
import 'package:travel/modules/home/destinatoin_details/destination_details.dart';
import 'package:travel/shared/components/components.dart';
import 'package:travel/shared/components/constants.dart';
import 'package:travel/shared/styles/icon_broken.dart';
import 'package:travel/shared/styles/thems.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CategoryCubit(),
      child: BlocConsumer<CategoryCubit, CategoryStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = CategoryCubit.get(context);

            return Scaffold(
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(
                    start: 15.0,
                    top: 20.0,
                    end: 15.0,
                    bottom: 10.0,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 31.0,
                            width: 120.0,
                            decoration: BoxDecoration(
                              color: BLUE2,
                              borderRadius: BorderRadiusDirectional.circular(6.0),
                            ),
                            child: Center(
                              child: Text(
                                'Country',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          Text(
                            'Category',
                            style: TextStyle(color: BLUE2, fontSize: 20.0),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                            top: 20.0, bottom: 20.0),
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
                      Container(
                        height: 40.0,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: cubit.items.length,
                          separatorBuilder: (context, index) => SizedBox(
                            width: 10.0,
                          ),
                          itemBuilder: (context, index) =>
                              buildItemToChooseInPlace(index, cubit),
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return buildItemDestination(
                                image: HomeCubit.get(context).dist[index].image,
                                text: HomeCubit.get(context).dist[index].country,
                                subText:
                                    HomeCubit.get(context).dist[index].dest_place,
                                onTap: () {
                                  HomeCubit.get(context).getHotelDestination(
                                    index: index,
                                  );
                                  navigateTo(
                                      context,
                                      DestinationDetails(
                                        destIndex: index,
                                      ));
                                },
                                tapFav: () {},
                              );
                            },
                            itemCount: HomeCubit.get(context).dist.length,
                            separatorBuilder: (BuildContext context, int index) {
                              return SizedBox(
                                width: 15.0,
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
          }),
    );
  }

  Widget buildItemToChooseInPlace(
    int index,
    CategoryCubit cubit,
  ) {
    return InkWell(
      onTap: () {
        cubit.changeIndexList(index: index);
      },
      child: Container(
        height: 40.0,
        width: index != 2 ? 66.0 : 66.0 * 1.5,
        decoration: BoxDecoration(
          color: cubit.isSelectedIndex == index ? BLUE2 : Colors.transparent,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
              width: 1.0,
              color: Colors.grey.shade400,
              style: BorderStyle.solid),
        ),
        child: Center(
          child: Text(
            cubit.items[index],
            style: TextStyle(
                color: cubit.isSelectedIndex == index
                    ? Colors.white
                    : Colors.black),
          ),
        ),
      ),
    );
  }
}
