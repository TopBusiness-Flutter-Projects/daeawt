import 'package:bloc/bloc.dart';
import 'package:daeawt/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:image_cropper/image_cropper.dart';

import '../../../core/model/user_model.dart';
import '../../../core/preferences/preferences.dart';
import '../../../core/remote/service.dart';
import '../../../core/utils/appwidget.dart';
import '../../../core/utils/toast_message_method.dart';
import '../../signup/model/register_model.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  bool isEditProfileValid = false;
  RegisterModel editProfileModel = RegisterModel();
  XFile? imageFile;
  String imagePath = '';
  String? message;
  ServiceApi api;
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerPhone = TextEditingController();

  UserModel? userModel;
  EditProfileCubit(this.api) : super(EditProfileInitial()){
    getUserData().then((value) => updateData(value));
  }
  pickImage({required String type}) async {
    imageFile = await ImagePicker().pickImage(
      source: type == 'camera' ? ImageSource.camera : ImageSource.gallery,
    );
    CroppedFile? croppedFile = await ImageCropper.platform.cropImage(
      sourcePath: imageFile!.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio7x5,
        CropAspectRatioPreset.ratio16x9
      ],
      cropStyle: CropStyle.rectangle,
      compressFormat: ImageCompressFormat.png,
      compressQuality: 90,
    );
    imagePath = croppedFile!.path;
    editProfileModel.image = imagePath;

    emit(AddProfilePickImageSuccess());
    checkValidEditProfileData();
  }
  Future<void> checkValidEditProfileData() async {
    bool vaild = await editProfileModel.isDataValid();
    if (vaild) {
      isEditProfileValid = true;
      print("object${isEditProfileValid}");
      emit(OnEditProfileVaild());
    } else {
      isEditProfileValid = false;

      emit(OnEditProfileVaildFaild());
    }
    print("obtyyryyryject${isEditProfileValid}");
  }

  Future<UserModel?> getUserData() async {
    //await CountryCodes.init(); // Optionally, you may provide a `Locale` to get countrie's localizadName

    userModel = await Preferences.instance.getUserModel();
    return userModel;
  }
  updateData(UserModel? value) async {

    editProfileModel
      ..image=value!.data!.user!.image
      ..name=value!.data!.user!.name.split(" ")[0]
      ..phone=value!.data!.user!.phone

    ;


    controllerName.text = value!.data!.user!.name;
    controllerPhone.text = value!.data!.user!.phone;

//    print("ddd${editProfileModel.phone}");
    //  print("ddd${number.isoCode}");
    checkValidEditProfileData();

  }
  void edit(BuildContext context) async {
    AppWidget.createProgressDialog(context, 'wait'.tr());
    final response = await api.UpdateUser(editProfileModel);
    response.fold(
          (failure) => {Navigator.pop(context), emit(EditProfileFailure())},
          (loginModel) {
        print("------------------ ${loginModel.code}");
        if (loginModel.code == 409 || loginModel.code == 410) {
          Navigator.pop(context);
          toastMessage("exists_email".tr(), context);
          // errorGetBar(translateText(AppStrings.noEmailError, context));
          emit(EditProfileFailure());
        } else if (loginModel.code == 200) {
          Navigator.pop(context);
          Preferences.instance.setUser(loginModel).then((value) {
            context.read<ProfileCubit>().getUserData();
            Navigator.pop(context);

          });
        }
      },
    );
  }

}
