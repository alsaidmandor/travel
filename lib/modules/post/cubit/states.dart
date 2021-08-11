abstract class PostStates {}

class PostInitialState extends PostStates {}

// change name country
class ChangeNameCountrySelected extends PostStates {
  String? country;

  ChangeNameCountrySelected({this.country});
}

// get user info
class GetUserLoadingState extends PostStates {}

class GetUserSuccessState extends PostStates {}

class GetUserErrorState extends PostStates {
  final String? error;

  GetUserErrorState({this.error});
}
// create post

class CreatePostLoadingState extends PostStates {}

class CreatePostSuccessState extends PostStates {}

class CreatePostErrorState extends PostStates {}

class PostImagePickedSuccessState extends PostStates {}

class PostImagePickedErrorState extends PostStates {}

class RemovePostImageState extends PostStates {}

class ProfileImagePickedSuccessState extends PostStates {}

class ProfileImagePickedErrorState extends PostStates {}

class CoverImagePickedSuccessState extends PostStates {}

class CoverImagePickedErrorState extends PostStates {}

class UploadProfileImageSuccessState extends PostStates {}

class UploadProfileImageErrorState extends PostStates {}

class UploadCoverImageSuccessState extends PostStates {}

class UploadCoverImageErrorState extends PostStates {}

// get posts
class GetPostsLoadingState extends PostStates {}

class GetPostsSuccessState extends PostStates {}

class GetPostsErrorState extends PostStates {
  final String error;

  GetPostsErrorState(this.error);
}
