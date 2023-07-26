import 'package:daeawt/features/add_invitation/model/add_invitation_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../features/contact_us/presentation/contact_model.dart';
import '../../features/login/model/login_model.dart';
import '../../features/signup/model/register_model.dart';
import '../api/base_api_consumer.dart';
import '../api/end_points.dart';
import '../error/exceptions.dart';
import '../error/failures.dart';


import '../model/InvitationDataModel.dart';
import '../model/check_code_model.dart';
import '../model/contact_us_model.dart';
import '../model/contacts_model.dart';
import '../model/reset_password_model.dart';
import '../model/setting.dart';
import '../model/status_resspons.dart';
import '../model/user_model.dart';
import '../preferences/preferences.dart';

class ServiceApi {
  final BaseApiConsumer dio;

  ServiceApi(this.dio);



  Future<Either<Failure, UserModel>> registerUser(RegisterModel userData) async {
    try {
      final response = await dio.post(
        EndPoints.registerUrl,
        formDataIsEnabled: true,
        body: await userData.updateToJson(),
      );

      return Right(UserModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  Future<Either<Failure, UserModel>> registerWithGoogle(UserCredential userCredential) async {
    try {
      final response = await dio.post(
        EndPoints.registerWithGoogleUrl,
        formDataIsEnabled: true,
        body: {
          "email":userCredential.user?.email,
          "name":userCredential.user?.displayName,
          "google_id":userCredential.user?.uid,


        },
      );

      return Right(UserModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  Future<Either<Failure, UserModel>> UpdateUser(RegisterModel userData) async {
    try {
      UserModel loginModel = await Preferences.instance.getUserModel();

      final response = await dio.post(
        options: Options(
          headers: {'Authorization': loginModel.data!.accessToken!},
        ),
        EndPoints.updateUrl,
        formDataIsEnabled: true,
        body: await userData.updateuserToJson(),
      );
      return Right(UserModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  Future<Either<Failure, StatusResponse>> addInvitation(AddInvitationModel invitationModel) async {
    try {
      print(";;;;");
      print(invitationModel.step);
      UserModel loginModel = await Preferences.instance.getUserModel();

      final response = await dio.post(
        options: Options(
          headers: {'Authorization': loginModel.data!.accessToken!},
        ),
        EndPoints.addInvitationUrl,
        formDataIsEnabled: true,
        body: await invitationModel.updateToJson(),
      );
      return Right(StatusResponse.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  Future<Either<Failure, StatusResponse>> updateinvitation(AddInvitationModel invitationModel,int id) async {
    try {
      print(";;;;");
      print(invitationModel.step);
      UserModel loginModel = await Preferences.instance.getUserModel();

      final response = await dio.post(
        options: Options(
          headers: {'Authorization': loginModel.data!.accessToken!},
        ),
        EndPoints.updateInvitationUrl+id.toString(),
        formDataIsEnabled: true,
        body: await invitationModel.updateToJson(),
      );
      return Right(StatusResponse.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  Future<Either<Failure, StatusResponse>> sendReminder(List<Invitee> invitationModel,int id) async {
    try {

      UserModel loginModel = await Preferences.instance.getUserModel();

      final response = await dio.post(
        options: Options(
          headers: {'Authorization': loginModel.data!.accessToken!},
        ),
        EndPoints.sendreminderInvitationUrl,
        formDataIsEnabled: true,
        body:{
          'invitation_id':id,
          for(int i=0;i<invitationModel.length;i++)...{
            "invitees[$i]":invitationModel[i].id
          }
        },
      );
      return Right(StatusResponse.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  Future<Either<Failure, StatusResponse>> deleteinvitation(int id) async {
    try {
      // print(";;;;");
      // print(invitationModel.step);
      UserModel loginModel = await Preferences.instance.getUserModel();

      final response = await dio.get(
        options: Options(
          headers: {'Authorization': loginModel.data!.accessToken!},
        ),
        EndPoints.deleteInvitationUrl+id.toString(),
     //   formDataIsEnabled: true,
       // body: await invitationModel.updateToJson(),
      );
      return Right(StatusResponse.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, UserModel>> postLogin(LoginModel model) async {
    try {
      final response = await dio.post(
        EndPoints.loginUrl,
        body: {
          'email': model.email,
          'password': model.password,
        },
      );
      return Right(UserModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
    postContactUs(ContactModel contactModel) async {
    try{
     final response = await dio.post(EndPoints.contactUsUrl,
        body: {
        "name":contactModel.userName,
          "phone":contactModel.phoneNumber,
          "subject":contactModel.topic,
          "message":contactModel.message,
        }
      );
      return Right(ContactUsModel.fromJson(response));
    }on ServerException{
      return Left(ServerFailure());
    }
    }


  Future<Either<Failure, ResetPasswordModel>> forgotPassword(String email) async {

    try {
      final response = await dio.post(
        EndPoints.forgotPasswordUrl,
        body: {
          'email': email,

        },
      );
      return Right(ResetPasswordModel.fromJson(response));
    } on ServerException {

      return Left(ServerFailure());
    }
  }

 Future<Either<Failure,CheckCodeModel>> postCheckCode(String code) async {
    try {
      final response = await dio.post(
        EndPoints.checkCodeUrl,
        body: {
          'code': code,

        },
      );
      print(".............................................");
      print(response);
      return Right(CheckCodeModel.fromJson(response));
    } on ServerException {

      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, ResetPasswordModel>> postPasswordReset(String password , String passwordConfirmation , String code) async {
    try{
      final response = await dio.post(EndPoints.passwordResetUrl,
        body: {
        "password":password,
          "password_confirmation":passwordConfirmation,
          "code":code,
        },
      );
      print("0000000000000000000000000000000000000000000000");
      print(response);
      return Right(ResetPasswordModel.fromJson(response));
    }on ServerException{
      return Left(ServerFailure());
    }

  }

  Future<Either<Failure, InvitationDataModel>> getInvitationHome(String search
      ) async {
     String lan = await Preferences.instance.getSavedLang();
     UserModel loginModel = await Preferences.instance.getUserModel();

     try {
      final response = await dio.get(
        EndPoints.invitationhomeListUrl ,
        queryParameters: {
          "search_key":search
        },
        options: Options(
          headers: {'Authorization': loginModel.data!.accessToken!},
        ),
      );
      print(response);
      return Right(InvitationDataModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  Future<Either<Failure, SettingDataModel>> getSetting(
      ) async {
     String lan = await Preferences.instance.getSavedLang();
   //  UserModel loginModel = await Preferences.instance.getUserModel();

     try {
      final response = await dio.get(
        EndPoints.settingurl ,


      );
      print(response);
      return Right(SettingDataModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  Future<Either<Failure, ContactsDataModel>> getContacts(
      ) async {
     String lan = await Preferences.instance.getSavedLang();
     UserModel loginModel = await Preferences.instance.getUserModel();

     try {
      final response = await dio.get(
        EndPoints.contactListUrl ,

        options: Options(
          headers: {'Authorization': loginModel.data!.accessToken!},
        ),
      );
      print(response);
      return Right(ContactsDataModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
