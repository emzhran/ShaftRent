import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shaftrent/core/constants/colors.dart';

class DetailMapsScreen extends StatefulWidget {
  final String namaLokasi;
  final double latitude;
  final double longitude;

  const DetailMapsScreen({
    super.key,
    required this.namaLokasi,
    required this.latitude,
    required this.longitude,
  });

  @override
  State<DetailMapsScreen> createState() => _DetailMapsScreenState();
}

class _DetailMapsScreenState extends State<DetailMapsScreen> {
  late LatLng _location;

  @override
  void initState() {
    super.initState();
    _location = LatLng(widget.latitude, widget.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.namaLokasi),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _location,
          zoom: 16,
        ),
        markers: {
          Marker(
            markerId: const MarkerId('lokasi'),
            position: _location,
            infoWindow: InfoWindow(title: widget.namaLokasi),
          ),
        },
        zoomControlsEnabled: true,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
      ),
    );
  }
}
