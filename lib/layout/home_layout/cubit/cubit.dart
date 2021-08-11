import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travel/layout/home_layout/cubit/states.dart';
import 'package:travel/models/favorite.dart';
import 'package:travel/models/hotel.dart';
import 'package:travel/models/popular_dest.dart';
import 'package:travel/models/user.dart';
import 'package:travel/modules/categories/categories_sc.dart';
import 'package:travel/modules/favorite/favorite_sc.dart';
import 'package:travel/modules/home/home_sc.dart';
import 'package:travel/modules/post/add_post.dart';
import 'package:travel/modules/profile/profile_sc.dart';
import 'package:travel/shared/components/constants.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(SocialInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screens = [
    HomeScreen(),
    CategoriesScreen(),
    AddPostScreen(),
    FavoriteScreen(),
    ProfileScreen(),
  ];

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(SocialChangeBottomNavState());
  }

  String? myCountry;
  void changeCountrySetting(String country) {
    myCountry = country;
    emit(HomeChangeNameCountrySelected(country: country));
    print(country);
  }

  List<PopularDest> dist = [];
  List<String> distId = [];
  List<String> hotelId = [];
  List<Hotel> hotel = [];
  List<Favorite> distFavorite = [];
  void getPopularDest() {
    // dist.clear();
    // hotel.clear();
    FirebaseFirestore.instance
        .collection('Popular_dest')
        .snapshots()
        .listen((event) {
      dist = [];
      event.docs.forEach((element) {
        distId.add(element.id);
        dist.add(PopularDest.fromJson(json: element.data()));
      });
      getUserData();
      emit(HomeGetPopularDestSuccessState());
    }).onError((error) {
      emit(HomeGetPopularDestErrorState(error.toString()));
    });
    ;
  }

  getHotelDestination({required int index}) {
    emit(HomeGetHotelDestLoadingState());
    FirebaseFirestore.instance
        .collection('Popular_dest')
        .doc(distId[index])
        .collection('hotel')
        .snapshots()
        .listen((event) {
      hotel = [];
      hotelId = [];
      event.docs.forEach((element) {
        hotelId.add(element.id);
        hotel.add(Hotel.fromJson(json: element.data()));
        emit(HomeGetHotelDestSuccessState());
      });
    }).onError((error) {
      emit(HomeGetHotelDestErrorState(error.toString()));
    });
  }

  Color favColor = Colors.white;

  void addFavoritePopularDestination({required int index}) {
    if (dist[index].favorite != true) {
      FirebaseFirestore.instance
          .collection('Popular_dest')
          .doc(distId[index])
          .update({'favorite': true}).then((value) {
        getPopularDest();
        emit(HomeGetFavoriteDestSuccessState());
      }).catchError((error) {
        emit(HomeGetFavoriteDestErrorState(error: error.toString()));
      });
      FirebaseFirestore.instance
          .collection('destFavorite')
          .doc(userId)
          .collection('favorites ')
          .doc()
          .set({'favorite': true, 'distFavorite': distId[index]}).then((value) {
        print(" HomeGetFavoriteDestSuccessState");

        emit(HomeGetFavoriteDestSuccessState());
      }).catchError((error) {
        emit(HomeGetFavoriteDestErrorState(error: error.toString()));
      });
    } else {
      FirebaseFirestore.instance
          .collection('Popular_dest')
          .doc(distId[index])
          .update({'favorite': false}).then((value) {
        getPopularDest();
        emit(HomeGetFavoriteDestSuccessState());
      }).catchError((error) {
        emit(HomeGetFavoriteDestErrorState(error: error.toString()));
      });
      FirebaseFirestore.instance
          .collection('destFavorite')
          .doc(userId)
          .collection('favorites ')
          .doc()
          .set({'favorite': false, 'distFavorite': distId[index]}).then(
              (value) {
        print(" HomeGetFavoriteDestSuccessState");

        emit(HomeGetFavoriteDestSuccessState());
      }).catchError((error) {
        emit(HomeGetFavoriteDestErrorState(error: error.toString()));
      });
    }
  }

  void getFavoritePopularDestination() {
    FirebaseFirestore.instance
        .collection('destFavorite')
        .doc(userId)
        .collection('favorites ')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        distFavorite.add(Favorite.fromJson(json: element.data()));
      });
      print(value.docs.length);
      emit(HomeGetFavoriteDestSuccessState());
    }).catchError((error) {
      emit(HomeGetFavoriteDestErrorState(error: error.toString()));
    });
  }

  void addFavoriteHotelPopularDestination(
      {required int indexDest, required int indexHotel}) {
    if (hotel[indexHotel].favorite != true) {
      FirebaseFirestore.instance
          .collection('Popular_dest')
          .doc(distId[indexDest])
          .collection('hotel')
          .doc(hotelId[indexHotel])
          .update({'favorite': true}).then((value) {
        // getHotelDestination(index: index);
        emit(HomeGetFavoriteDestHotelSuccessState());
      }).catchError((error) {
        emit(HomeGetFavoriteDestHotelErrorState(error: error.toString()));
      });
    } else {
      FirebaseFirestore.instance
          .collection('Popular_dest')
          .doc(distId[indexDest])
          .collection('hotel')
          .doc(hotelId[indexHotel])
          .update({'favorite': false}).then((value) {
        emit(HomeGetFavoriteDestHotelSuccessState());
      }).catchError((error) {
        emit(HomeGetFavoriteDestHotelErrorState(error: error.toString()));
      });
    }
  }

  void getFavoriteHotelPopularDestination() {
    FirebaseFirestore.instance
        .collection('destFavorite')
        .doc(userId)
        .collection('favorites ')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        distFavorite.add(Favorite.fromJson(json: element.data()));
      });
      print(value.docs.length);
      emit(HomeGetFavoriteDestSuccessState());
    }).catchError((error) {
      emit(HomeGetFavoriteDestErrorState(error: error.toString()));
    });
  }

  UserModel? userModel;

  void getUserData() {
    emit(HomeGetUserLoadingState());

    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get()
        .then((value) {
      // print(value.data());
      userModel = UserModel.fromJson(json: value.data());
      emit(HomeGetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(HomeGetUserErrorState(error: error.toString()));
    });
  }

  File? profileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(HomeImagePickedSuccessState());
      uploadProfileImage(name: name, phone: phone, bio: bio);
    } else {
      print('No image selected.');
      emit(HomeImagePickedErrorState());
    }
  }

  File? coverImage;

  Future<void> getCoverImage({
    required String name,
    required String phone,
    required String bio,
  }) async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(HomeCoverImagePickedSuccessState());
      uploadCoverImage(name: name, phone: phone, bio: bio);
    } else {
      print('No image selected.');
      emit(HomeCoverImagePickedErrorState());
    }
  }

  void uploadProfileImage({
    String? name,
    String? phone,
    String? bio,
  }) {
    emit(HomeUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        // emit(SocialUploadProfileImageSuccessState());
        updateUser(
          name: name ?? userModel!.name!,
          phone: phone ?? userModel!.phone!,
          bio: bio ?? userModel!.bio!,
          image: value,
        );
      }).catchError((error) {
        emit(HomeUploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(HomeUploadProfileImageErrorState());
    });
  }

  void uploadCoverImage({
    String? name,
    String? phone,
    String? bio,
  }) {
    emit(HomeUserUpdateLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        // emit(ProfileUploadCoverImageSuccessState());
        updateUser(
          name: name ?? userModel!.name!,
          phone: phone ?? userModel!.phone!,
          bio: bio ?? userModel!.bio!,
          cover: value,
        );
      }).catchError((error) {
        emit(HomeUploadCoverImageErrorState());
      });
    }).catchError((error) {
      emit(HomeUploadCoverImageErrorState());
    });
  }

  void updateUser({
    required String name,
    required String phone,
    required String bio,
    String? image,
    String? cover,
  }) {
    emit(HomeUserUpdateLoadingState());
    UserModel model = UserModel(
      name: name,
      email: userModel!.email,
      phone: phone,
      uId: userModel!.uId,
      image: image ?? userModel!.image,
      cover: cover ?? userModel!.cover,
      bio: bio,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(HomeUserUpdateErrorState());
    });
  }
}
