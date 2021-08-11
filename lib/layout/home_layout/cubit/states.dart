abstract class HomeStates {}

class SocialInitialState extends HomeStates {}

class SocialChangeBottomNavState extends HomeStates {}

// change name country
class HomeChangeNameCountrySelected extends HomeStates {
  String? country;

  HomeChangeNameCountrySelected({this.country});
}


// chat

class SocialSendMessageSuccessState extends HomeStates {}

class SocialSendMessageErrorState extends HomeStates {}

class SocialGetMessagesSuccessState extends HomeStates {}

// destination

class HomeGetPopularDestLoadingState extends HomeStates {}

class HomeGetPopularDestSuccessState extends HomeStates {}

class HomeGetPopularDestErrorState extends HomeStates {
  final String error;

  HomeGetPopularDestErrorState(this.error);
}

// get hotel destination
class HomeGetHotelDestLoadingState extends HomeStates {}

class HomeGetHotelDestSuccessState extends HomeStates {}

class HomeGetHotelDestErrorState extends HomeStates {
  final String error;

  HomeGetHotelDestErrorState(this.error);
}

// get Favorite Destination
class HomeGetFavoriteDestSuccessState extends HomeStates {}

class HomeGetFavoriteDestErrorState extends HomeStates {
  final String? error;

  HomeGetFavoriteDestErrorState({this.error});
}

// get Favorite Hotel Destination
class HomeGetFavoriteDestHotelSuccessState extends HomeStates {}

class HomeGetFavoriteDestHotelErrorState extends HomeStates {
  final String? error;

  HomeGetFavoriteDestHotelErrorState({this.error});
}

// get user info
class HomeGetUserLoadingState extends HomeStates {}

class HomeGetUserSuccessState extends HomeStates {}

class HomeGetUserErrorState extends HomeStates {
  final String? error;

  HomeGetUserErrorState({this.error});
}

// picked profile image

class HomeImagePickedSuccessState extends HomeStates {}

class HomeImagePickedErrorState extends HomeStates {}

// picked cover image

class HomeCoverImagePickedSuccessState extends HomeStates {}

class HomeCoverImagePickedErrorState extends HomeStates {}

// update profile image

class HomeUploadProfileImageSuccessState extends HomeStates {}

class HomeUploadProfileImageErrorState extends HomeStates {}

// update cover image
class HomeUploadCoverImageSuccessState extends HomeStates {}

class HomeUploadCoverImageErrorState extends HomeStates {}

// update user
class HomeUserUpdateLoadingState extends HomeStates {}

class HomeUserUpdateErrorState extends HomeStates {}
