import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shaftrent/core/components/custom_text_field.dart';
import 'package:shaftrent/core/constants/colors.dart';

class AddMapsScreen extends StatefulWidget {
  const AddMapsScreen({super.key});

  @override
  State<AddMapsScreen> createState() => _AddMapsScreenState();
}

class _AddMapsScreenState extends State<AddMapsScreen> {
  final namaLokasiController = TextEditingController();
  LatLng? selectedPosition;

  final LatLng initialPosition = const LatLng(-7.810721359321624, 110.32186156987228);

  Future<void> requestLocationPermission() async {
    final status = await Permission.location.request();
    if (status.isGranted) {
      print('Izin lokasi diberikan');
    } else {
      print('Izin lokasi ditolak');
    }
  }

  @override
  void initState() {
    super.initState();
    requestLocationPermission();
  }

  @override
  void dispose() {
    namaLokasiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Lokasi'),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
      ),
      backgroundColor: AppColors.primary,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: CustomTextField(
              controller: namaLokasiController,
              label: 'Nama Lokasi',
              showLabel: false,
              validator: 'Nama Lokasi tidak boleh kosong',
              textColor: AppColors.black,
              labelColor: AppColors.black,
              borderColor: AppColors.black,
              prefixIcon: Icon(Icons.map_outlined, color: AppColors.black),
            ),
          ),
        ],
      ),
    );
  }
}