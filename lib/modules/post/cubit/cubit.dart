import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travel/models/post_model.dart';
import 'package:travel/models/user.dart';
import 'package:travel/modules/post/cubit/states.dart';
import 'package:travel/shared/components/constants.dart';

class PostCubit extends Cubit<PostStates> {
  PostCubit() : super(PostInitialState());

  static PostCubit get(context) => BlocProvider.of(context);

  String? myCountry;
  void changeCountry(String country) {
    myCountry = country;
    emit(ChangeNameCountrySelected(country: country));
    print(country);
  }

  late UserModel userModel;

  // void getUserData() {
  //   emit(GetUserLoadingState());
  //
  //   FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(userId)
  //       .get()
  //       .then((value) {
  //     // print(value.data());
  //     userModel = UserModel.fromJson(json: value.data());
  //     emit(GetUserSuccessState());
  //   }).catchError((error) {
  //     print(error.toString());
  //     emit(GetUserErrorState(error: error.toString()));
  //   });
  // }

  File? postImage;
  var picker = ImagePicker();

  Future<void> getPostImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(CoverImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(CoverImagePickedErrorState());
    }
  }

  void removePostImage() {
    postImage = null;
    emit(RemovePostImageState());
  }

  void uploadPostImage({
    required String? country,
    required String place,
    required String aboutImage,
  }) {
    emit(CreatePostLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createPost(
          country: country!,
          place: place,
          aboutImage: aboutImage,
          postImage: value,
        );
        emit(CreatePostSuccessState());
      }).catchError((error) {
        emit(CreatePostErrorState());
      });
    }).catchError((error) {
      emit(CreatePostErrorState());
    });
  }

  void createPost({
    required String country,
    required String place,
    required String aboutImage,
    String? postImage,
  }) {
    emit(CreatePostLoadingState());
    PostModel model = PostModel(
        country: country,
        uId: userId,
        image: postImage,
        aboutImage: aboutImage,
        place: place);
    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(CreatePostSuccessState());
    }).catchError((error) {
      emit(CreatePostErrorState());
    });
  }

  List<PostModel> posts = [];
  void getPosts() {
    emit(GetPostsLoadingState());
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        posts.add(PostModel.fromJson(json: element.data()));
      });

      emit(GetPostsSuccessState());
    }).catchError((error) {
      emit(GetPostsErrorState(error.toString()));
    });
  }
}
