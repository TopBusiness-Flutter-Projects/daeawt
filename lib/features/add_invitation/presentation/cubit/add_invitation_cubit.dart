

import 'package:bloc/bloc.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:daeawt/core/remote/service.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../home/models/contact_model.dart';

part 'add_invitation_state.dart';

class AddInvitationCubit extends Cubit<AddInvitationState> {

  AddInvitationCubit(this.api) : super(AddInvitationInitial());

  ServiceApi api;

  final ImagePicker picker = ImagePicker();
  XFile? invitationImage;
  bool withBarcode = false;
  String address = "";
  bool withSendingDate = false;
  List<ContactModel> contactModelList = [];
  List<ContactModel> selectedContactModelList = [];
  int numberOfInvitedPeople = 0 ;
  late GoogleMapController mapController ;
  LatLng selectedLocation = const LatLng(30.0459, 31.2243);
  late Placemark? place;
  List<String> languageOptions = ["العربية","English"];
  String selectedLanguage = 'العربية';

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

  changesSelectButton(bool isSelected) {
    isSelected = !isSelected;
    emit(SelectButtonChangingState());
    return isSelected;
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

  removeSelectedContact(int index){
    selectedContactModelList.removeAt(index);
    emit(RemoveSelectedContactState());
  }

  getAddressFromLatLng() async {
    if(await Permission.location.isGranted){

      Position userCurrentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      selectedLocation = LatLng(userCurrentPosition.latitude, userCurrentPosition.longitude);
      List<Placemark> placemarks = await placemarkFromCoordinates(selectedLocation.latitude, selectedLocation.longitude);
      moveCamera(selectedLocation);
      place = placemarks[0];
      address =
      '${place?.name}, ${place?.subLocality}, ${place
          ?.subAdministrativeArea},${place?.country}';
      emit(LocationPermissionSuccessState());
    }
    else{
      await Permission.location.request();
      if(await Permission.location.isGranted||await Permission.location.isLimited){
        Position userCurrentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        selectedLocation = LatLng(userCurrentPosition.latitude, userCurrentPosition.longitude);
        moveCamera(selectedLocation);
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

  Future<bool> _handleLocationPermission(context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  String? _currentAddress;
  Position? _currentPosition;

  // Future<void> _getCurrentPosition() async {
  //   final hasPermission = await _handleLocationPermission();
  //   if (!hasPermission) return;
  //   await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high)
  //       .then((Position position) {
  //    // setState(() => _currentPosition = position);
  //   }).catchError((e) {
  //     debugPrint(e);
  //   });
  // }



  moveCamera(LatLng target){
    mapController.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(target:target,zoom: 14 )));
    emit(CameraMoveState());
  }

  selectLocation(LatLng newLocation){
    selectedLocation = newLocation;
    emit(ChangeLocationState());
  }

  changeLanguageOption(String newLanguage){
    selectedLanguage = newLanguage ;
    emit(ChangingLanguageState());
  }
}
