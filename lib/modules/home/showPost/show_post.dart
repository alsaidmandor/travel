import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel/layout/home_layout/cubit/cubit.dart';
import 'package:travel/modules/post/cubit/cubit.dart';
import 'package:travel/modules/post/cubit/states.dart';
import 'package:travel/shared/components/components.dart';
import 'package:travel/shared/components/conditional_builder.dart';
import 'package:travel/shared/components/constants.dart';
import 'package:travel/shared/styles/thems.dart';

class ShowPost extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostCubit, PostStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = PostCubit.get(context);
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsetsDirectional.only(start: 10.0, end: 10.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      leadingButton(context),
                      Text(
                        languageModel(context).post!,
                        style: TextStyle(fontSize: 22.0, color: BLUE),
                      ),
                    ],
                  ),
                  ConditionalBuilder(
                    condition: cubit.posts.length != 0,
                    builder: (context) => Container(
                        height: 260,
                        width: double.infinity,
                        child: ListView.separated(
                          itemBuilder: (BuildContext context, int index) {
                            return buildItemDestination(
                              image: cubit.posts[index].image,
                              text: cubit.posts[index].country,
                              subText: cubit.posts[index].place,
                              nameUser: HomeCubit.get(context).userModel!.name,
                              isFav: false,
                              onTap: () {},
                              tapFav: () {},
                            );
                          },
                          itemCount: cubit.posts.length,
                          separatorBuilder: (BuildContext context, int index) {
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
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
