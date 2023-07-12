import 'package:bloc/bloc.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../models/contact_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  final ImagePicker picker = ImagePicker();
   XFile? invitationImage;

  bool withBarcode = false;

  bool withSendingDate = false;

  List<ContactModel> contactModelList = [];

 late GoogleMapController mapController ;
  LatLng selectedLocation = const LatLng(30.0459, 31.2243);
  late Placemark? place;
  String address = "";

  selectLocation(LatLng newLocation){
    selectedLocation = newLocation;
    emit(ChangeLocationState());
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
          contactModelList.add(ContactModel(
              name: contacts[i].displayName,
              phones: contacts[i].phones,
              isSelected: false));
        }
        return contacts;
      }
    } else {
      List<Contact> contacts =
          (await ContactsService.getContacts(withThumbnails: false)).toList();

      for (int i = 0; i < contacts.length; i++) {
        contactModelList.add(ContactModel(
            name: contacts[i].displayName,
            phones: contacts[i].phones,
            isSelected: false));
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
          ?.subAdministrativeArea}';
      print(address);
      emit(LocationPermissionSuccessState());
    }
    else{
     await Permission.location.request();
     if(await Permission.location.isGranted||await Permission.location.isLimited){
       List<Placemark> placemarks = await placemarkFromCoordinates(selectedLocation.latitude, selectedLocation.longitude);
       place = placemarks[0];
       address =
       '${place?.name}, ${place?.street},';
       emit(LocationPermissionSuccessState());
     }
     else{
       emit(LocationPermissionFailedState());
     }
    }


  }
}
