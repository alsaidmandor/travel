import 'package:flutter/material.dart';
import 'package:travel/shared/components/constants.dart';
import 'package:travel/shared/styles/thems.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: secondDefaultAppBar(
        context: context,
        title: Text(
          'Favorite',
          style: TextStyle(fontSize: 20.0, color: BLUE),
        ),
      ),
      body: Center(
        child: Container(
          child: Text('Favorite Screen'),
        ),
      ),
    );
  }
}
