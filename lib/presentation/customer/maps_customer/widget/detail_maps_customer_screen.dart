import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shaftrent/core/constants/colors.dart';
import 'package:shaftrent/core/components/spaces.dart';
import 'package:shaftrent/data/model/response/maps_response_model.dart';

class DetailMapsCustomerScreen extends StatelessWidget {
  final Maps map;

  const DetailMapsCustomerScreen({super.key, required this.map});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(map.namaLokasi),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
      ),
      body: Column(
        children: [
          const SpaceHeight(20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(map.latitude, map.longitude),
                    zoom: 16,
                  ),
                  markers: {
                    Marker(
                      markerId: MarkerId(map.id.toString()),
                      position: LatLng(map.latitude, map.longitude),
                      infoWindow: InfoWindow(title: map.namaLokasi),
                    ),
                  },
                  zoomControlsEnabled: true,
                  myLocationButtonEnabled: false,
                  compassEnabled: false,
                  mapToolbarEnabled: false,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
