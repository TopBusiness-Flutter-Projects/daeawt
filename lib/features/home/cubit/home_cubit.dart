import 'package:bloc/bloc.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:daeawt/core/utils/app_strings.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../core/utils/assets_manager.dart';
import '../../../core/model/InvitationDataModel.dart';
import '../../../core/remote/service.dart';
import '../../splash/presentation/screens/splash_screen.dart';
import '../models/contact_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final ServiceApi api;
  List<InvitationModel> invitationsList = [];
  HomeCubit(this.api) : super(HomeInitial()){
    geInvitationsHome();
  }
  List<String> detailsIconsList = [AssetsManager.messagesIcon,AssetsManager.invitedIcon,
    AssetsManager.scannedIcon,AssetsManager.confirmedIcon,AssetsManager.apologiesIcon,
    AssetsManager.waitingIcon,AssetsManager.notSentIcon,AssetsManager.failedIcon];

  List<String> detailsLabels = [AppStrings.theMessage,AppStrings.invited,AppStrings.scanned,
             AppStrings.confirmation,AppStrings.apologies,AppStrings.wait,AppStrings.notSent,AppStrings.failed];
  final ImagePicker picker = ImagePicker();
   XFile? invitationImage;

  bool withBarcode = false;

  bool withSendingDate = false;

  bool isBottomDetailsWidgetVisible = true; //TODO-->

  List<ContactModel> contactModelList = [];
  List<ContactModel> selectedContactModelList = [];

  int numberOfInvitedPeople = 0 ;

 late GoogleMapController mapController ;
  LatLng selectedLocation = const LatLng(30.0459, 31.2243);
  late Placemark? place;
  String address = "";
  String englishSymbol = "En";
  String arabicSymbol = "ع";
  bool isEnglish = true;

  List<String> languageOptions = ["العربية","English"];
  String selectedLanguage = 'العربية';


  selectLocation(LatLng newLocation){
    selectedLocation = newLocation;
    emit(ChangeLocationState());
  }
  removeSelectedContact(int index){
    selectedContactModelList.removeAt(index);
    emit(RemoveSelectedContactState());
  }

  changesSelectButton(bool isSelected) {
    isSelected = !isSelected;
    emit(SelectButtonChangingState());
    return isSelected;
  }

  changeWithBarcodeCheckListTile(bool? value){
    withBarcode = value!;
    emit(ChangeWithBarcodeCheckListTileState());

  }

  changeWithSendingDateCheckListTile(bool? value){
    withSendingDate = value!;
    emit(ChangeWithSendingDateCheckListTileState());
  }

  Future<List<Contact>> getAllContacts() async {
    //must take the user permission
    var status = await Permission.contacts.status;
    if (status.isDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      if (!permissionStatus.isDenied || !permissionStatus.isPermanentlyDenied) {
        List<Contact> contacts =
            (await ContactsService.getContacts(withThumbnails: false)).toList();

        for (int i = 0; i < contacts.length; i++) {
          if(contacts[i].phones!.isNotEmpty){
            contactModelList.add(ContactModel(
                name: contacts[i].displayName,
                phones: contacts[i].phones,
                isSelected: false));
          }

        }
        return contacts;
      }
    } else {
      List<Contact> contacts =
          (await ContactsService.getContacts(withThumbnails: false)).toList();


      for (int i = 0; i < contacts.length; i++) {
        if(contacts[i].phones!.isNotEmpty){
          contactModelList.add(ContactModel(
              name: contacts[i].displayName,
              phones: contacts[i].phones,
              isSelected: false));
        }

      }

      return contacts;
    }
    return [];
  }

  uploadInvitationImage(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
            child: Wrap(
             children: <Widget>[
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text("Pick from gallery"),
              onTap: () async {
                  // Pick an image.
                 invitationImage = await picker.pickImage(source: ImageSource.gallery);
                 emit(SelectInvitationImageState());

              },
            ),
             ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text("Take a photo"),
               onTap: () async {
                 // Pick an image.
                 invitationImage =await  picker.pickImage(source: ImageSource.camera);
                 emit(SelectInvitationImageState());

               },
            )
          ],
        ));
      },
    );
  }

  getAddressFromLatLng() async {
    if(await Permission.location.isGranted){
      List<Placemark> placemarks = await placemarkFromCoordinates(selectedLocation.latitude, selectedLocation.longitude);
      place = placemarks[0];
      address =
      '${place?.name}, ${place?.subLocality}, ${place
          ?.subAdministrativeArea},${place?.country}';
      emit(LocationPermissionSuccessState());
    }
    else{
     await Permission.location.request();
     if(await Permission.location.isGranted||await Permission.location.isLimited){
       List<Placemark> placemarks = await placemarkFromCoordinates(selectedLocation.latitude, selectedLocation.longitude);
       place = placemarks[0];
       address =
       '${place?.name}, ${place?.street}, ${place
           ?.subAdministrativeArea},${place?.country}';
       emit(LocationPermissionSuccessState());
     }
     else{
       emit(LocationPermissionFailedState());
     }
    }


  }

  incrementNumberOfInvitedPeople(){
    numberOfInvitedPeople++;
    emit(IncrementNumberOfInvitedPeopleState());
  }

  decrementNumberOfInvitedPeople(){
    if(numberOfInvitedPeople<=0){
      numberOfInvitedPeople=0;
    }
    else{
      numberOfInvitedPeople--;

    }
    emit(DecrementNumberOfInvitedPeopleState());
  }

  changeLanguageOption(String newLanguage){
    selectedLanguage = newLanguage ;
    emit(ChangingLanguageState());
  }

  changeApplicationLanguage(BuildContext context){
    Locale appLocale = Localizations.localeOf(context);

    if(appLocale==Locale("ar")){

      EasyLocalization.of(context)?.setLocale(Locale('en', ''));
      emit(ChangingApplicationLanguageState());
    }
    else if (appLocale==Locale("en")){

      EasyLocalization.of(context)?.setLocale(Locale('ar', ''));
      emit(ChangingApplicationLanguageState());
    }


    Phoenix.rebirth(context);


  }

  visibleBottomDetailsWidget(){
    isBottomDetailsWidgetVisible = !isBottomDetailsWidgetVisible;
    emit(ChangingBottomDetailsVisibleState());
  }
  geInvitationsHome() async {
    //  print("ddldlldld0");
    // print(selectedIndividualType);
    invitationsList.clear();
    emit(InvitationsHomeLoading());
    final response = await api.getInvitationHome();
    response.fold(
          (l) => emit(InvitationsHomeError()),
          (r) {
            invitationsList = r.data;
        emit(InvitationsHomeLoaded());
      },
    );
  }

}
