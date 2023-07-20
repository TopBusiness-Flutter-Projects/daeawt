import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../features/login/model/login_model.dart';
import '../../features/signup/model/register_model.dart';
import '../api/base_api_consumer.dart';
import '../api/end_points.dart';
import '../error/exceptions.dart';
import '../error/failures.dart';


import '../model/InvitationDataModel.dart';
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
  Future<Either<Failure, InvitationDataModel>> getInvitationHome(
      ) async {
     String lan = await Preferences.instance.getSavedLang();
     UserModel loginModel = await Preferences.instance.getUserModel();

     try {
      final response = await dio.get(
        EndPoints.invitationhomeListUrl ,
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
}
