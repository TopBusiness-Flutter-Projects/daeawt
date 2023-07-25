

import 'package:bloc/bloc.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:daeawt/core/model/InvitationDataModel.dart';
import 'package:daeawt/core/remote/service.dart';
import 'package:daeawt/core/utils/toast_message_method.dart';
import 'package:daeawt/features/home/cubit/home_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/appwidget.dart';
import '../../../home/models/contact_model.dart';
import '../../model/add_invitation_model.dart';

part 'add_invitation_state.dart';

class AddInvitationCubit extends Cubit<AddInvitationState> {
  TextEditingController dateController=TextEditingController();

bool isDataVaild1=false;
  AddInvitationCubit(this.api) : super(AddInvitationInitial());
  DateTime initialDate = DateTime(DateTime.now().year);
  DateTime startData = DateTime(DateTime.now().year );
  DateTime endData = DateTime(DateTime.now().year + 100000);
  ServiceApi api;
  AddInvitationModel model=AddInvitationModel();
  final ImagePicker picker = ImagePicker();
  String birthDate = 'YYYY-MM-DD';
  XFile? invitationImage;
  bool withBarcode = false;
  String address = "";
  bool withSendingDate = false;
  List<ContactModel> contactModelList = [];
  List<ContactModel> allcontactModelList = [];
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
                  model.image=invitationImage!.path;
                    checkDataVaild1();

                    emit(SelectInvitationImageState());

                  },
                ),
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text("Take a photo"),
                  onTap: () async {
                    // Pick an image.
                    invitationImage =await  picker.pickImage(source: ImageSource.camera);
                    model.image=invitationImage!.path;
                     checkDataVaild1();
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
    model.has_qrcode=withBarcode?1:0;
    emit(ChangeWithBarcodeCheckListTileState());

  }

  changeWithSendingDateCheckListTile(bool? value){
    withSendingDate = value!;
    model.send_date=withSendingDate?1:0;

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
        allcontactModelList.addAll(contactModelList);
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
      allcontactModelList.addAll(contactModelList);

      return contacts;
    }
    return [];
  }

  changesSelectButton(bool isSelected) {
    isSelected = !isSelected;
    emit(SelectButtonChangingState());
    return isSelected;
  }

  incrementNumberOfInvitedPeople(int index){
    model.selectedContactModelList.elementAt(index).numberOfInvitedPeople++;
    emit(IncrementNumberOfInvitedPeopleState());
  }

  decrementNumberOfInvitedPeople(int index){
    if(   model.selectedContactModelList.elementAt(index).numberOfInvitedPeople<=0){
      model.selectedContactModelList.elementAt(index).numberOfInvitedPeople=0;
    }
    else{

      model.selectedContactModelList.elementAt(index).numberOfInvitedPeople++;

    }
    emit(DecrementNumberOfInvitedPeopleState());
  }

  removeSelectedContact(int index){
    model.selectedContactModelList.removeAt(index);
    contactModelList.elementAt(index).isSelected=false;
    emit(RemoveSelectedContactState());
  }

  getAddressFromLatLng() async {
    if(await Permission.location.isGranted){

      Position userCurrentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      selectedLocation = LatLng(userCurrentPosition.latitude, userCurrentPosition.longitude);
      List<Placemark> placemarks = await placemarkFromCoordinates(selectedLocation.latitude, selectedLocation.longitude);
      moveCamera(selectedLocation);
      place = placemarks[0];
      model.latitude=userCurrentPosition.latitude;
      model.longitude=userCurrentPosition.longitude;
      address =
      '${place?.name}, ${place?.subLocality}, ${place
          ?.subAdministrativeArea},${place?.country}';
      print(address);
      model.address=address;
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
        print(address);
        model.latitude=userCurrentPosition.latitude;
        model.longitude=userCurrentPosition.longitude;
        address =
        '${place?.name}, ${place?.street}, ${place
            ?.subAdministrativeArea},${place?.country}';
        model.address=address;
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
    model.lang=selectedLanguage=="العربية"?"ar":"en";
    emit(ChangingLanguageState());
  }

  void updateBirthDate({required String date}) {
    this.birthDate = date;
    model.date = date;
    dateController.text=date;
    checkDataVaild1();
    emit(InvitationDateSelected());  }

  void checkDataVaild1() {
    if(model.isDataVaild1()){
      isDataVaild1=true;
    }
    else{
      isDataVaild1=false;
    }
    emit(InvitationVaild());
  }
  onSearchTextChanged(String text) async {
    contactModelList.clear();
model.selectedContactModelList.clear();
    print("dlflfllf");
   // print(inviteess.length);
    for (ContactModel userDetail in allcontactModelList) {
      print(text+"dddd");
      if (userDetail.name!.contains(text) )
        contactModelList.add(userDetail);
    }
    emit(AddInvitationInitial());

  }
  void addinviatation(BuildContext context) async {
    AppWidget.createProgressDialog(context, 'wait'.tr());
    final response = await api.addInvitation(model);
    response.fold(
          (failure) => {Navigator.pop(context),
           toastMessage("fail send".tr(), context)},
          (loginModel) {
     if (loginModel.code == 200) {
       Navigator.pop(context);
       context.read<HomeCubit>().geInvitationsHome();
       Navigator.pushNamed(context, Routes.homeRoute);


        }

          else{
              toastMessage("fail send".tr(), context);
              }


      },
    );
  }

  void setData(InvitationModel homeListItemModel) {
    model.title=homeListItemModel.title;
    model.date=homeListItemModel.date;
    model.as_draft=int.parse(homeListItemModel.status);
    model.longitude=double.parse(homeListItemModel.longitude);
    model.latitude=double.parse(homeListItemModel.latitude);
    model.image=homeListItemModel.image;
    dateController.text=homeListItemModel.date;
    model.address=homeListItemModel.address;
    address= model.address;
    selectLocation(LatLng(model.latitude,  model.longitude));
    updateBirthDate(date: model.date);
    if(homeListItemModel.invitees.isNotEmpty){
      for(int i=0;i<homeListItemModel.invitees.length;i++){

      }
    }
  }

}
