import 'dart:convert';

class LanguageModel {
  String? languageHead;
  String? languageBody;
  String? b1title;
  String? b2title;
  String? b3title;
  String? b1body;
  String? b2body;
  String? b3body;
  String? skip;
  String? phoneAuthMessage;
  String? phoneNumber;
  String? login;

  String? loginTitle;

  String? registerTitle;
  String? registerBtn;
  String? register;

  String? sendCode;
  String? loginFacebook;
  String? completeProfile;
  String? seeProfile;
  String? home;
  String? categories;
  String? favourites;
  String? profile;
  String? darkMode;
  String? changeLanguage;
  String? aboutUs;
  String? rateApp;
  String? terms;
  String? contactUs;
  String? logout;
  String? editProfile;
  String? notifications;
  String? notificationTitle;
  String? notificationDate;
  String? forgetPasswordBtn;
  String? donNotHave;
  String? forgetPasswordTitle;
  String? forgetPasswordBtnTitle;
  String? verificationCodeTitle;
  String? verificationCodeBtnTitle;
  String? hintEmail;
  String? hintName;
  String? hintPassword;
  String? hintConfirmPassword;
  String? hintVerificationCode;
  String? showPost;
  String? popularDestination;
  String? see;
  String? explore;
  String? followRequest;
  String? hotel;
  String? bestHotelIn;
  String? post;

  LanguageModel(
      {this.languageHead,
      this.languageBody,
      this.b1title,
      this.b2title,
      this.b3title,
      this.b1body,
      this.b2body,
      this.b3body,
      this.skip,
      this.phoneAuthMessage,
      this.phoneNumber,
      this.login,
      this.loginTitle,
      this.registerTitle,
      this.register,
      this.registerBtn,
      this.sendCode,
      this.loginFacebook,
      this.completeProfile,
      this.seeProfile,
      this.home,
      this.categories,
      this.favourites,
      this.profile,
      this.darkMode,
      this.changeLanguage,
      this.aboutUs,
      this.rateApp,
      this.terms,
      this.contactUs,
      this.logout,
      this.editProfile,
      this.notifications,
      this.notificationTitle,
      this.notificationDate,
      this.forgetPasswordBtn,
      this.donNotHave,
      this.forgetPasswordTitle,
      this.forgetPasswordBtnTitle,
      this.verificationCodeTitle,
      this.verificationCodeBtnTitle,
      this.hintEmail,
      this.hintName,
      this.hintPassword,
      this.hintConfirmPassword,
      this.hintVerificationCode,
      this.showPost,
      this.popularDestination,
      this.see,
      this.explore,
      this.followRequest,
      this.hotel,
      this.bestHotelIn,
      this.post});

  factory LanguageModel.fromJson(data) {
    Map<String, dynamic> json = jsonDecode(data);

    return new LanguageModel(
      languageHead: json['languageHead'] as String,
      languageBody: json['languageBody'] as String,
      b1title: json['b1title'] as String,
      b2title: json['b2title'] as String,
      b3title: json['b3title'] as String,
      b1body: json['b1body'] as String,
      b2body: json['b2body'] as String,
      b3body: json['b3body'] as String,
      skip: json['skip'] as String,
      phoneAuthMessage: json['phoneAuthMessage'] as String,
      phoneNumber: json['phoneNumber'] as String,
      login: json['login'] as String,
      loginTitle: json['loginTitle'] as String,
      register: json['register'] as String,
      registerTitle: json['registerTitle'] as String,
      registerBtn: json['registerBtn'] as String,
      sendCode: json['sendCode'] as String,
      loginFacebook: json['loginFacebook'] as String,
      completeProfile: json['completeProfile'] as String,
      seeProfile: json['seeProfile'] as String,
      home: json['home'] as String,
      categories: json['categories'] as String,
      favourites: json['favourites'] as String,
      profile: json['profile'] as String,
      darkMode: json['darkMode'] as String,
      changeLanguage: json['changeLanguage'] as String,
      aboutUs: json['aboutUs'] as String,
      rateApp: json['rateApp'] as String,
      terms: json['terms'] as String,
      contactUs: json['contactUs'] as String,
      logout: json['logout'] as String,
      editProfile: json['editProfile'] as String,
      notifications: json['notifications'] as String,
      notificationTitle: json['notificationTitle'] as String,
      notificationDate: json['notificationDate'] as String,
      forgetPasswordBtn: json['forgetPasswordBtn'] as String,
      donNotHave: json['donNotHave'] as String,
      forgetPasswordTitle: json['forgetPasswordTitle'] as String,
      forgetPasswordBtnTitle: json['forgetPasswordBtnTitle'] as String,
      verificationCodeTitle: json['verificationCodeTitle'] as String,
      verificationCodeBtnTitle: json['verificationCodeBtnTitle'] as String,
      hintEmail: json['hintEmail'] as String,
      hintName: json['hintName'] as String,
      hintPassword: json['hintPassword'] as String,
      hintConfirmPassword: json['hintConfirmPassword'] as String,
      hintVerificationCode: json['hintVerificationCode'] as String,
      showPost: json['showPost'] as String,
      popularDestination: json['popularDestination'] as String,
      see: json['see'] as String,
      explore: json['explore'] as String,
      followRequest: json['followRequest'] as String,
      hotel: json['hotel'] as String,
      bestHotelIn: json['bestHotelIn'] as String,
      post: json['post'] as String,
    );
  }
}
