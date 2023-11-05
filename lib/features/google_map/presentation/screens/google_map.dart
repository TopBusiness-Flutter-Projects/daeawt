import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:daeawt/features/add_invitation/presentation/cubit/add_invitation_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

class GoogleMapScreen extends StatefulWidget {
   GoogleMapScreen({Key? key}) : super(key: key);

   final kGoogleApiKey = 'AIzaSyCZjDPvxg9h3IUSfVPzIwnKli5Y17p-v9g';
  final homeScaffoldKey = GlobalKey<ScaffoldState>();
  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  final Mode _mode = Mode.overlay;
  Set<Marker> markersList = {};
   GoogleMapController? googleMapController;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddInvitationCubit, AddInvitationState>(
      listener: (context, state) {},
      builder: (context, state) {
        AddInvitationCubit cubit = context.read<AddInvitationCubit>();
        return Scaffold(
          body: Stack(
            children: [
              GoogleMap(
                onCameraMove:(position) => {},
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                mapType: MapType.normal,
                onTap: (LatLng location)  {
                cubit.selectLocation(location);
                  cubit.moveCamera(location);
                  cubit.getAddressFromLatLng1();
                },
                initialCameraPosition: const CameraPosition(
                    target: LatLng(30.0450, 31.2242), zoom: 12),
                onMapCreated: (controller) {
                  cubit.mapController = controller;
                  googleMapController = controller;
                  // cubit.center = cubit.position.target;
                },

                markers: {
                  Marker(
                    markerId: MarkerId('selected_location'),
                    position: cubit.selectedLocation,
                    icon: BitmapDescriptor.defaultMarker
                    // infoWindow: InfoWindow(
                    //   title: 'Egypt',
                    // ),
                  ),
                }
                //cubit.markers,
                //{

                //   Marker(
                //     markerId: const MarkerId("cairo"),
                //     position: cubit.selectedLocation,
                //   )
                // },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 38.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize:
                            Size(MediaQuery.of(context).size.width / 3.1, 40)),
                    child: Text("select").tr(),
                    onPressed: () {
                      // context.read<AddServiceCubit>().setAddress(cubit.place);
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 35.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(MediaQuery.of(context).size.width / 3, 40)
                      ),
                        onPressed: _handlePressButton,
                        child: const Text("Search Places")),
                  ))
            ],
          ),
        );
      },
    );
  }

  Future<void> _handlePressButton() async {
    Prediction? p = await PlacesAutocomplete.show(
        context: context,
        apiKey: widget.kGoogleApiKey,
        onError: onError,
        mode: _mode,
        language: 'ar',
        strictbounds: false,
        types: [""],
        decoration: InputDecoration(
            hintText: 'Search',
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color: Colors.white))),
        components: [Component(Component.country,"eg")]);


    displayPrediction(p!,widget.homeScaffoldKey.currentState);
  }
  void onError(PlacesAutocompleteResponse response){

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Message',
        message: response.errorMessage!,
        contentType: ContentType.failure,
      ),
    ));

    // homeScaffoldKey.currentState!.showSnackBar(SnackBar(content: Text(response.errorMessage!)));
  }
  Future<void> displayPrediction(Prediction p, ScaffoldState? currentState) async {

    GoogleMapsPlaces places = GoogleMapsPlaces(
        apiKey: widget.kGoogleApiKey,
        apiHeaders: await const GoogleApiHeaders().getHeaders()
    );

    PlacesDetailsResponse detail = await places.getDetailsByPlaceId(p.placeId!);

    final lat = detail.result.geometry!.location.lat;
    final lng = detail.result.geometry!.location.lng;

    // markersList.clear();
    // markersList.add(Marker(markerId: const MarkerId("0"),position: LatLng(lat, lng),infoWindow: InfoWindow(title: detail.result.name)));
context.read<AddInvitationCubit>().selectedLocation=LatLng(detail.result.geometry!.location.lat, detail.result.geometry!.location.lng
);
    setState(() {});
if(googleMapController!=null) {
  googleMapController!.animateCamera(
      CameraUpdate.newLatLngZoom(LatLng(lat, lng), 14.0));
}
  }

}

// import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
// import 'package:daeawt/features/add_invitation/presentation/cubit/add_invitation_cubit.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_google_places/flutter_google_places.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_maps_webservice/places.dart';
// import 'package:google_api_headers/google_api_headers.dart';
//
// class GoogleMapScreen extends StatefulWidget {
//   const GoogleMapScreen({Key? key}) : super(key: key);
//
//   @override
//   State<GoogleMapScreen> createState() => _GoogleMapScreenState();
// }
//
// const kGoogleApiKey = 'AIzaSyA6QI378BHt9eqBbiJKtqWHTSAZxcSwN3Q';
// final homeScaffoldKey = GlobalKey<ScaffoldState>();
//
// class _GoogleMapScreenState extends State<GoogleMapScreen> {
//   static const CameraPosition initialCameraPosition = CameraPosition(target: LatLng(31, 31), zoom: 14.0);
//
//   Set<Marker> markersList = {};
//
//   late GoogleMapController googleMapController;
//
//   final Mode _mode = Mode.overlay;
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<AddInvitationCubit, AddInvitationState>(
//   listener: (context, state) {
//     // TODO: implement listener
//   },
//   builder: (context, state) {
//     AddInvitationCubit cubit = context.read<AddInvitationCubit>();
//     return Scaffold(
//       key: homeScaffoldKey,
//       appBar: AppBar(
//         title: const Text("Google Search Places"),
//       ),
//       body: Stack(
//         children: [
//           GoogleMap(
//             initialCameraPosition: initialCameraPosition,
//             markers: markersList,
//             mapType: MapType.normal,
//             onMapCreated: (GoogleMapController controller) {
//               googleMapController = controller;
//             },
//                   onTap: (LatLng location) {
//                   cubit.selectLocation(location);
//                   cubit.getAddressFromLatLng();
//                   markersList.add(Marker(markerId: MarkerId("1"),position: cubit.selectedLocation));
//                 },
//           ),
//           ElevatedButton(onPressed: _handlePressButton,
//               child: const Text("Search Places")),
//       Padding(
//                 padding: const EdgeInsets.only(top: 38.0),
//                 child: Align(
//                   alignment: Alignment.bottomCenter,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                         minimumSize:
//                             Size(MediaQuery.of(context).size.width / 3.1, 40)),
//                     child: Text("select").tr(),
//                     onPressed: () {
//                       // context.read<AddServiceCubit>().setAddress(cubit.place);
//                       Navigator.pop(context);
//                     },
//                   ),
//                 ),
//               ),
//         ],
//       ),
//     );
//   },
// );
//   }
//
//   Future<void> _handlePressButton() async {
//     Prediction? p = await PlacesAutocomplete.show(
//         context: context,
//         apiKey: kGoogleApiKey,
//         onError: onError,
//         mode: _mode,
//         language: 'ar',
//         strictbounds: false,
//         types: [""],
//         decoration: InputDecoration(
//             hintText: 'Search',
//             focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20),
//                 borderSide: const BorderSide(color: Colors.white))),
//         components: [Component(Component.country,"eg")]);
//
//
//     displayPrediction(p!,homeScaffoldKey.currentState);
//   }
//
//   void onError(PlacesAutocompleteResponse response){
//
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       elevation: 0,
//       behavior: SnackBarBehavior.floating,
//       backgroundColor: Colors.transparent,
//       content: AwesomeSnackbarContent(
//         title: 'Message',
//         message: response.errorMessage!,
//         contentType: ContentType.failure,
//       ),
//     ));
//
//     // homeScaffoldKey.currentState!.showSnackBar(SnackBar(content: Text(response.errorMessage!)));
//   }
//
//   Future<void> displayPrediction(Prediction p, ScaffoldState? currentState) async {
//
//     GoogleMapsPlaces places = GoogleMapsPlaces(
//         apiKey: kGoogleApiKey,
//         apiHeaders: await const GoogleApiHeaders().getHeaders()
//     );
//
//     PlacesDetailsResponse detail = await places.getDetailsByPlaceId(p.placeId!);
//
//     final lat = detail.result.geometry!.location.lat;
//     final lng = detail.result.geometry!.location.lng;
//
//     markersList.clear();
//     markersList.add(Marker(markerId: const MarkerId("0"),position: LatLng(lat, lng),infoWindow: InfoWindow(title: detail.result.name)));
//
//     setState(() {});
//
//     googleMapController.animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, lng), 14.0));
//
//   }
// }
