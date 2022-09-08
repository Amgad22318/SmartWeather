import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:weather_app_algoriza_75/business_logic/cubit/weather_cubit/weather_cubit.dart';
import 'package:weather_app_algoriza_75/constants/constant_methods.dart';
import 'package:weather_app_algoriza_75/constants/constants.dart';
import 'package:weather_app_algoriza_75/presentation/widgets/default_map.dart';
import 'package:weather_app_algoriza_75/presentation/widgets/default_material_button.dart';
import 'package:weather_app_algoriza_75/presentation/widgets/default_text.dart';
import 'package:weather_app_algoriza_75/presentation/widgets/default_text_button.dart';

class PickLocationScreen extends StatefulWidget {
  PickLocationScreen({Key? key}) : super(key: key);

  @override
  State<PickLocationScreen> createState() => _PickLocationScreenState();
}

class _PickLocationScreenState extends State<PickLocationScreen> {
  double? clickedMarkerLat;
  double? clickedMarkerLong;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          DefaultMap(
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            initialCameraPosition: appInitialCameraPosition,
            onTap: (argument) {
              setState(() {
                clickedMarkerLat = argument.latitude;
                clickedMarkerLong = argument.longitude;
              });
            },
            markers: clickedMarkerLat != null && clickedMarkerLong != null
                ? {
                    Marker(
                        markerId: const MarkerId('chosenLocation'),
                        infoWindow: const InfoWindow(title: 'Chosen Location'),
                        position:
                            LatLng(clickedMarkerLat!, clickedMarkerLong!)),
                  }
                : const {},
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.0.w, vertical: 4.h),
            child: DefaultMaterialButton(
                onPressed: () {
                  if (clickedMarkerLat != null || clickedMarkerLong != null) {
                  } else {
                    showToastMsg(
                        msg: 'choose your location',
                        toastState: ToastStates.WARNING);
                  }
                },
                child: DefaultText(text: 'Choose Location')),
          ),
        ],
      ),
    );
  }
}
