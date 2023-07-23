import 'package:daeawt/features/add_invitation/presentation/cubit/add_invitation_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../home/cubit/home_cubit.dart';

class GoogleMapScreen extends StatelessWidget {
  const GoogleMapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddInvitationCubit,AddInvitationState>(
      listener: (context, state) {

      },
      builder: (context, state) {
        AddInvitationCubit cubit = context.read<AddInvitationCubit>();
     return  Scaffold(
        body: GoogleMap(
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          mapType: MapType.normal,

          onTap: (LatLng location)  {
           cubit.selectLocation(location);
           cubit.getAddressFromLatLng();
          },
          initialCameraPosition: const CameraPosition(
              target: LatLng(30.0450, 31.2242),
            zoom: 8
          ),
          onMapCreated: (controller) {
            cubit.mapController = controller;
          },
          markers: {
            Marker(
                markerId: const MarkerId("cairo"),
              position:  cubit.selectedLocation,


            )
          },

        ),
      );
      },
    );
  }
}
