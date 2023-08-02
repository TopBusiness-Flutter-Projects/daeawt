import 'package:bloc/bloc.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:daeawt/core/model/InvitationDataModel.dart';
import 'package:daeawt/core/remote/service.dart';
import 'package:daeawt/core/utils/assets_manager.dart';
import 'package:daeawt/core/utils/toast_message_method.dart';
import 'package:daeawt/features/home/cubit/home_cubit.dart';
import 'package:daeawt/features/scan/cubit/scan_cubit.dart';
import 'package:easy_localization/easy_localization.dart' as tr;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart'as maps;
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:search_map_place_updated/search_map_place_updated.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/model/user_model.dart';
import '../../../../core/preferences/preferences.dart';
import '../../../../core/utils/appwidget.dart';
import '../../../home/models/contact_model.dart';
import '../../model/add_invitation_model.dart';

part 'add_invitation_state.dart';

class AddInvitationCubit extends Cubit<AddInvitationState> {
  var TotalInvitedPeople;
  UserModel? userModel;


  AddInvitationCubit(this.api) : super(AddInvitationInitial())
  {
    getTheUserPermissionAndLocation();
    getUserData();
  }
  getUserData() async {
    userModel = await Preferences.instance.getUserModel();
    //  print("dldldl${userModel!.access_token}");
    emit(OnUserDataVaild());
  }



  TextEditingController dateController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  InvitationModel? homeListItemModel;
  bool isDataVaild1 = false;
bool isfirst=true;

  DateTime initialDate = DateTime.now();
  DateTime startData = DateTime(DateTime.now().year);
  DateTime endData = DateTime(DateTime.now().year + 100000);
  ServiceApi api;
  AddInvitationModel model = AddInvitationModel();
  final ImagePicker picker = ImagePicker();
  String birthDate = 'YYYY-MM-DD';
  XFile? invitationImage;
  bool withBarcode = false;
  String address = "";
  bool withSendingDate = false;
  List<ContactModel> contactModelList = [];
  List<ContactModel> allcontactModelList = [];
   GoogleMapController? mapController;
  PermissionStatus permissionStatus =PermissionStatus.denied ;
  LatLng selectedLocation = const LatLng(30.0459, 31.2243);//todo
  final placesApi = maps.GoogleMapsPlaces(apiKey: 'AIzaSyA6QI378BHt9eqBbiJKtqWHTSAZxcSwN3Q');
  final TextEditingController searchController = TextEditingController();
 // final List<Marker> searchMarkers = [];
  late Placemark? place;
  Set<Marker> markers = {

  };

  LatLng center= LatLng(31, 31);
  List<String> languageOptions = ["العربية", "English"];
  String selectedLanguage = 'العربية';

  Position currentPosition = Position(longitude:31.189283 , latitude:  27.180134,
      timestamp: DateTime(Duration.millisecondsPerDay), accuracy: 1.5,
      altitude: 0.8, heading: 100, speed: 12, speedAccuracy: 1);

  uploadInvitationImage(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
            child: Wrap(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.photo_library),
              title:  Text("pick_gallery").tr(),
              onTap: () async {
                // Pick an image.
                invitationImage =
                    await picker.pickImage(source: ImageSource.gallery);
                model.image = invitationImage!.path;
                checkDataVaild1();

                emit(SelectInvitationImageState());
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text("pick_photo").tr(),
              onTap: () async {
                // Pick an image.
                invitationImage =
                    await picker.pickImage(source: ImageSource.camera);
                model.image = invitationImage!.path;
                checkDataVaild1();
                emit(SelectInvitationImageState());
              },
            )
          ],
        ));
      },
    );
  }

  changeWithBarcodeCheckListTile(bool? value) {
    withBarcode = value!;
    model.has_qrcode = withBarcode ? 1 : 0;
    emit(ChangeWithBarcodeCheckListTileState());
  }

  void getTotalInvitedPeople(){
    int sum = model.selectedContactModelList.length;
    for(int i=0;i<model.selectedContactModelList.length ;i++){
      sum+=model.selectedContactModelList[i].numberOfInvitedPeople;
      print(sum);
    }
   TotalInvitedPeople=sum;
    emit(AddInvitationInitial());
  }

  changeWithSendingDateCheckListTile(bool? value) {
    withSendingDate = value!;
    model.send_date = withSendingDate ? 1 : 0;

    emit(ChangeWithSendingDateCheckListTileState());
  }

  Future<List<Contact>> getAllContacts() async {
    //must take the user permission
    getcontacts();

    var status = await Permission.contacts.status;
    if (status.isDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      if (!permissionStatus.isDenied || !permissionStatus.isPermanentlyDenied) {
        List<Contact> contacts =
            (await ContactsService.getContacts(withThumbnails: false)).toList();

        for (int i = 0; i < contacts.length; i++) {
          if (!contactModelList.contains(contacts[i])) {
            if (contacts[i].phones!.isNotEmpty) {
              contactModelList.add(ContactModel(
                  name: contacts[i].displayName,
                  phones: contacts[i].phones,
                  isSelected: false));
            }
          }
        }
        allcontactModelList.addAll(contactModelList);
        if (isfirst&&homeListItemModel != null &&
            homeListItemModel!.invitees.isNotEmpty&&model.selectedContactModelList.isEmpty) {
          print("ddddd");
          isfirst=false;
          for (int i = 0; i < homeListItemModel!.invitees.length; i++) {
            for(int j=0;j<contactModelList.length;j++){
              if (contactModelList[j].phones!.elementAt(0).value==homeListItemModel!.invitees.elementAt(i).phone) {
                print("ssssss");
                print(contactModelList.elementAt(0).phones!.elementAt(0).label);

                contactModelList[j].numberOfInvitedPeople =
                    homeListItemModel!.invitees[i].inviteesNumber;

                contactModelList[j].isSelected =
                    changesSelectButton(false);
                model.selectedContactModelList
                    .add(contactModelList[i]);
              }

            }

          }
        }
        return contacts;
      }
    } else {
      List<Contact> contacts =
          (await ContactsService.getContacts(withThumbnails: false)).toList();

      for (int i = 0; i < contacts.length; i++) {
        if (!contactModelList.contains(contacts[i])) {
          if (contacts[i].phones!.isNotEmpty) {
            contactModelList.add(ContactModel(
                name: contacts[i].displayName,
                phones: contacts[i].phones,
                isSelected: false));
          }
        }
      }
      allcontactModelList.addAll(contactModelList);
      if (isfirst&&homeListItemModel != null && homeListItemModel!.invitees.isNotEmpty&&model.selectedContactModelList.isEmpty) {
        print("ddddd");
        isfirst=true;
        for (int i = 0; i < homeListItemModel!.invitees.length; i++) {

for(int j=0;j<contactModelList.length;j++){
  if (contactModelList[j].phones!.elementAt(0).value==homeListItemModel!.invitees.elementAt(i).phone) {
    print("ssssss");
    print(contactModelList.elementAt(0).phones!.elementAt(0).label);

    contactModelList[j].numberOfInvitedPeople =
        homeListItemModel!.invitees[i].inviteesNumber;

    contactModelList[j].isSelected =
        changesSelectButton(false);
    model.selectedContactModelList
        .add(contactModelList[i]);
  }

}
        }
      }
      return contacts;
    }

    return [];
  }

  changesSelectButton(bool isSelected) {
    print("dldldldl");
    isSelected = !isSelected;
    emit(SelectButtonChangingState());
    return isSelected;
  }

  incrementNumberOfInvitedPeople(int index) {

    model.selectedContactModelList.elementAt(index).numberOfInvitedPeople++;
    print("+++++++++++++++++++++++++++++++++++++++++++++++++++++$index");
    print( model.selectedContactModelList.elementAt(index).numberOfInvitedPeople);
    emit(IncrementNumberOfInvitedPeopleState());
  }

  decrementNumberOfInvitedPeople(int index) {
    if (model.selectedContactModelList.elementAt(index).numberOfInvitedPeople <=
        0) {
      model.selectedContactModelList.elementAt(index).numberOfInvitedPeople = 0;
    } else {
      model.selectedContactModelList.elementAt(index).numberOfInvitedPeople--;
      print("-------------------------------------------------$index");
      print( model.selectedContactModelList.elementAt(index).numberOfInvitedPeople);
    }
    emit(DecrementNumberOfInvitedPeopleState());
  }

  removeSelectedContact(int index) {
    model.selectedContactModelList.removeAt(index);
    contactModelList.elementAt(index).isSelected = false;
    emit(RemoveSelectedContactState());
  }
//********************Google Map************************************************

  void onCameraMove(CameraPosition position) {
    center = position.target;
  }
  void search() async {
    // Remove any existing markers

      markers.clear();
      emit(MarkersCleared());

 center = selectedLocation;
    // Search for places
    final response = await placesApi.searchNearbyWithRadius(
      maps.Location(lat: center.latitude,lng: center.longitude),
      100000,
     // type: 'restaurant',
      keyword: searchController.text,
    );

    // Add markers for each result
    response.results.forEach((result) {
      final marker = Marker(
        markerId: MarkerId(result.placeId),
        position: LatLng(result.geometry!.location.lat, result.geometry!.location.lng),
        infoWindow: InfoWindow(title: result.name),
      );

        markers.add(marker);
      emit(MarkerAdded());
     // moveCamera(center);

    });
  }

  final Marker newMarker = const Marker(
    markerId: MarkerId('marker_id'),
    position: LatLng(31, 31),
    infoWindow: InfoWindow(
      title: 'Marker Title',
      snippet: 'Marker Snippet',
    ),
  );
getTheUserPermissionAndLocation() async {
  permissionStatus = await Permission.location.request();

  if (permissionStatus == PermissionStatus.granted) {
    // User granted location permission, get user's location
    await _getUserLocation();
    emit(LocationPermissionSuccess());
  } else {
    emit(LocationPermissionFailed());
    // User denied location permission, display error message
  }
}
  _getUserLocation() async {
    try {
      // await  getTheUserPermission();
      currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      selectedLocation =  LatLng(currentPosition.latitude, currentPosition.longitude) ;
      moveCamera(selectedLocation);
      List<Placemark> placemarks = await placemarkFromCoordinates(
          selectedLocation.latitude, selectedLocation.longitude);
      place = placemarks[0];
      print('Latitude: ${currentPosition.latitude}, Longitude: ${currentPosition.longitude}');
    } catch (e) {
      if (e is PermissionDeniedException) {
        print('User denied permission to access location');
      }
    }
  }
  // moveCamera2() async {
  //   //await getTheUserPermission();
  //   mapController.animateCamera(
  //
  //       CameraUpdate.newCameraPosition(
  //           CameraPosition(
  //               zoom: 15,
  //               // tilt: 60,
  //               // bearing: 100,
  //               target: LatLng(position.latitude, position.longitude))));
  //   emit(CameraMoveState());
  // }

  getAddressFromLatLng() async {
    if (await Permission.location.isGranted) {
      Position userCurrentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      selectedLocation =
          LatLng(userCurrentPosition.latitude, userCurrentPosition.longitude);
      List<Placemark> placemarks = await placemarkFromCoordinates(
          selectedLocation.latitude, selectedLocation.longitude);
      moveCamera(selectedLocation);
      model.title=nameController.text;
      place = placemarks[0];
      model.latitude = userCurrentPosition.latitude;
      model.longitude = userCurrentPosition.longitude;
      address =
          '${place?.name}, ${place?.subLocality}, ${place?.subAdministrativeArea},${place?.country}';
      print(address);
      model.address = address;
      emit(LocationPermissionSuccessState());
    } else {
      await Permission.location.request();
      if (await Permission.location.isGranted ||
          await Permission.location.isLimited) {
        Position userCurrentPosition = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        selectedLocation =
            LatLng(userCurrentPosition.latitude, userCurrentPosition.longitude);
        moveCamera(selectedLocation);
        List<Placemark> placemarks = await placemarkFromCoordinates(
            selectedLocation.latitude, selectedLocation.longitude);
        place = placemarks[0];
        print(address);
        model.latitude = userCurrentPosition.latitude;
        model.longitude = userCurrentPosition.longitude;
        address =
            '${place?.name}, ${place?.street}, ${place?.subAdministrativeArea},${place?.country}';
        model.address = address;
        emit(LocationPermissionSuccessState());
      } else {
        emit(LocationPermissionFailedState());
      }
    }
    checkDataVaild1();
  }
  getAddressFromLatLng1() async {
  //  if (await Permission.location.isGranted) {
  //     Position userCurrentPosition = await Geolocator.getCurrentPosition(
  //         desiredAccuracy: LocationAccuracy.high);
  //     selectedLocation =
  //         LatLng(userCurrentPosition.latitude, userCurrentPosition.longitude);
      List<Placemark> placemarks = await placemarkFromCoordinates(
          selectedLocation.latitude, selectedLocation.longitude);
      moveCamera(selectedLocation);
      model.title=nameController.text;
      place = placemarks[0];
      model.latitude = selectedLocation.latitude;
      model.longitude = selectedLocation.longitude;
      address =
      '${place?.name}, ${place?.subLocality}, ${place?.subAdministrativeArea},${place?.country}';
      print(address);
      model.address = address;
      emit(LocationPermissionSuccessState());
    //}
    // else {
    //   await Permission.location.request();
    //   if (await Permission.location.isGranted ||
    //       await Permission.location.isLimited) {
    //     Position userCurrentPosition = await Geolocator.getCurrentPosition(
    //         desiredAccuracy: LocationAccuracy.high);
    //     selectedLocation =
    //         LatLng(userCurrentPosition.latitude, userCurrentPosition.longitude);
    //     moveCamera(selectedLocation);
    //     List<Placemark> placemarks = await placemarkFromCoordinates(
    //         selectedLocation.latitude, selectedLocation.longitude);
    //     place = placemarks[0];
    //     print(address);
    //     model.latitude = userCurrentPosition.latitude;
    //     model.longitude = userCurrentPosition.longitude;
    //     address =
    //     '${place?.name}, ${place?.street}, ${place?.subAdministrativeArea},${place?.country}';
    //     model.address = address;
    //     emit(LocationPermissionSuccessState());
    //   } else {
    //     emit(LocationPermissionFailedState());
    //   }
    // }
    checkDataVaild1();
  }

  Future<bool> _handleLocationPermission(context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
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
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
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

  moveCamera(LatLng target) {
    mapController!.moveCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: target, zoom: 14)));
    emit(CameraMoveState());
  }

  selectLocation(LatLng newLocation) {
    selectedLocation = newLocation;
   // markers.add(Marker(markerId: MarkerId("id"),position: newLocation,),);
    moveCamera(newLocation);

    emit(ChangeLocationState());
  }
//**********************************************************************************
  changeLanguageOption(String newLanguage) {
    selectedLanguage = newLanguage;
    model.lang = selectedLanguage == "العربية" ? "ar" : "en";
    emit(ChangingLanguageState());
  }

  void updateBirthDate({required String date}) {
    this.birthDate = date;
    model.date = date;
    dateController.text = date;
    checkDataVaild1();
    emit(InvitationDateSelected());
  }

  void checkDataVaild1() {
    if (model.isDataVaild1()) {
      isDataVaild1 = true;
    } else {
      isDataVaild1 = false;
    }
    emit(InvitationVaild());
  }

  onSearchTextChanged(String text) async {
    contactModelList.clear();
    model.selectedContactModelList.clear();
    print("dlflfllf");
    // print(inviteess.length);
    for (ContactModel userDetail in allcontactModelList) {
      print(text + "dddd");
      if (userDetail.name!.contains(text)) contactModelList.add(userDetail);
    }
    emit(AddInvitationInitial());
  }

  void addinviatation(BuildContext context) async {
    AppWidget.createProgressDialog(context, tr.tr('wait'));
    final response = await api.addInvitation(model);
    response.fold(
      (failure) =>
          {Navigator.pop(context), toastMessage(tr.tr("fail send"), context)},
      (loginModel) {
        if (loginModel.code == 200) {
     homeListItemModel=null;
      isfirst=true;
      nameController.text='';
      dateController.text='';
      address="";
      model=AddInvitationModel();

          Navigator.pop(context);
          Preferences.instance.setUser(userModel!).then((value) => {
            context.read<HomeCubit>().geInvitationsHome(),
          context.read<ScanCubit>().geInvitationsHome(),

          Navigator.pushNamed(context, Routes.homeRoute)});

      emit(AddInvitationInitial());
        } else {
          toastMessage(tr.tr("fail send"), context);
        }
      },
    );
  }
  void updateinviatation(BuildContext context) async {
    print("lflfl");
  //  print(model.selectedContactModelList.length);
    AppWidget.createProgressDialog(context, tr.tr('wait'));
    final response = await api.updateinvitation(model,homeListItemModel!.id);
    response.fold(
      (failure) =>
          {Navigator.pop(context), toastMessage(tr.tr("fail send"), context)},
      (loginModel) {
        if (loginModel.code == 200) {

          homeListItemModel=null;
          isfirst=true;
          nameController.text='';
          dateController.text='';
          address="";

          model=AddInvitationModel();
          Navigator.pop(context);

          Preferences.instance.setUser(userModel!).then((value) => {
            context.read<HomeCubit>().geInvitationsHome(),
            context.read<ScanCubit>().geInvitationsHome(),
              Navigator.pushNamed(context, Routes.homeRoute)});
          emit(AddInvitationInitial());


        } else {
          toastMessage(tr.tr("fail send"), context);
        }
      },
    );
  }

  void setData(InvitationModel homeListItemModel) {
    isfirst=true;
    this.homeListItemModel = homeListItemModel;

    model.title = homeListItemModel.title;
    model.date = homeListItemModel.date;
    model.as_draft = int.parse(homeListItemModel.status);
    model.longitude = double.parse(homeListItemModel.longitude);
    model.latitude = double.parse(homeListItemModel.latitude);
    model.image = homeListItemModel.image;
    dateController.text = homeListItemModel.date;
    nameController.text = homeListItemModel.title;
    model.address = homeListItemModel.address;
    address = model.address;
    print("ddlldld");
    print(model.date);
    if(mapController!=null){
    selectLocation(LatLng(model.latitude, model.longitude));}
    updateBirthDate(date: model.date);
    print("homeListItemModel.invitees.length");
    print(homeListItemModel.invitees.length);
    if (contactModelList.isNotEmpty&&model.selectedContactModelList.length==0) {
      if (homeListItemModel.invitees.isNotEmpty) {
        print("ddddd");
        for (int i = 0; i < homeListItemModel!.invitees.length; i++) {
          print("ddddwwwww");
          for(int j=0;j<contactModelList.length;j++){
            if (contactModelList[j].phones!.elementAt(0).value==homeListItemModel!.invitees.elementAt(i).phone) {
              print("ssssss");
              print(contactModelList.elementAt(0).phones!.elementAt(0).label);

              contactModelList[j].numberOfInvitedPeople =
                  homeListItemModel!.invitees[i].inviteesNumber;

              contactModelList[j].isSelected =
                  changesSelectButton(false);
              model.selectedContactModelList
                  .add(contactModelList[i]);
            }

          }

        }
      }
    }
    emit(AddInvitationInitial());
  }
  void setData1(InvitationModel homeListItemModel) {
    isfirst=true;
    this.homeListItemModel = homeListItemModel;

    model.title = homeListItemModel.title;
    model.date = homeListItemModel.date;
    model.as_draft = int.parse(homeListItemModel.status);
    model.longitude = double.parse(homeListItemModel.longitude);
    model.latitude = double.parse(homeListItemModel.latitude);
    model.image = homeListItemModel.image;
    dateController.text = homeListItemModel.date;
    nameController.text = homeListItemModel.title;
    model.address = homeListItemModel.address;
    address = model.address;
    selectLocation(LatLng(model.latitude, model.longitude));
    updateBirthDate(date: model.date);
    print("homeListItemModel.invitees.length");
    print(homeListItemModel.invitees.length);
    for(int i=0;i<homeListItemModel.invitees.length;i++){
      model.selectedContactModelList.add(ContactModel(name:homeListItemModel.invitees[i].name,phones: [Item(label: 'mobile',value:homeListItemModel.invitees[i].phone )] ));
    }
    // if (contactModelList.isNotEmpty&&model.selectedContactModelList.length==0) {
    //   if (homeListItemModel.invitees.isNotEmpty) {
    //     print("ddddd");
    //     for (int i = 0; i < homeListItemModel!.invitees.length; i++) {
    //       print("ddddwwwww");
    //       for(int j=0;j<contactModelList.length;j++){
    //         if (contactModelList[j].phones!.elementAt(0).value==homeListItemModel!.invitees.elementAt(i).phone) {
    //           print("ssssss");
    //           print(contactModelList.elementAt(0).phones!.elementAt(0).label);
    //
    //           contactModelList[j].numberOfInvitedPeople =
    //               homeListItemModel!.invitees[i].inviteesNumber;
    //
    //           contactModelList[j].isSelected =
    //               changesSelectButton(false);
    //           model.selectedContactModelList
    //               .add(contactModelList[i]);
    //         }
    //
    //       }
    //
    //     }
    //   }
    // }
    emit(AddInvitationInitial());
  }

  getcontacts() async {
    //  print("ddldlldld0");
    // print(selectedIndividualType);
    final response = await api.getContacts();
    response.fold(
      (l) => {},
      (r) {
        for (int i = 0; i < r.data.length; i++) {
          if (r.data[i].phone.isNum) {
            if (!contactModelList.contains(ContactModel(
                name: r.data[i].name,
                phones: [Item(label: 'mobile', value: r.data[i].phone)],
                isSelected: false))) {
              contactModelList.add(ContactModel(
                  name: r.data[i].name,
                  phones: [Item(label: 'mobile', value: r.data[i].phone)],
                  isSelected: false));
            }
          }
        }
      },
    );
  }
}
