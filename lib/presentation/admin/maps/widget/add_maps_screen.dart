import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shaftrent/core/components/custom_text_field.dart';
import 'package:shaftrent/core/components/spaces.dart';
import 'package:shaftrent/core/constants/colors.dart';
import 'package:shaftrent/data/model/request/admin/maps_request_model.dart';
import 'package:shaftrent/presentation/admin/maps/bloc/maps_bloc.dart';
import 'package:shaftrent/presentation/admin/maps/bloc/maps_event.dart';
import 'package:shaftrent/presentation/admin/maps/bloc/maps_state.dart';

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
          Expanded(
            child: GoogleMap(
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              initialCameraPosition: CameraPosition(target: initialPosition, zoom: 15),
              markers: selectedPosition != null
                  ? {
                      Marker(
                        markerId: const MarkerId('selected'),
                        position: selectedPosition!,
                        draggable: true,
                        onDragEnd: (pos) => setState(() => selectedPosition = pos)
                      )
                    }
                  : {},
              onTap: (pos) {
                setState(() {
                  selectedPosition = pos;
                });
              },
            ),
          ),
          const SpaceHeight(10),
          BlocConsumer<MapsBloc, MapsState>(
            listener: (context, state) {
              if (state is MapAdded) {
                Navigator.of(context).pop(true);
              } else if (state is MapsError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Gagal menambahkan lokasi: ${state.message}'),
                  backgroundColor: AppColors.red,
                  ),
                );
              }
            },
            builder: (context, state) {
              final isLoading = state is MapsLoading;
              return Padding(
                padding: const EdgeInsets.all(16),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.white,
                    minimumSize: const Size.fromHeight(50),
                  ),
                  onPressed: isLoading
                      ? null
                      : () {
                          if (namaLokasiController.text.isEmpty || selectedPosition == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Nama lokasi dan titik lokasi wajib diisi'),
                                backgroundColor: AppColors.red)
                            );
                            return;
                          }
                          final request = MapsRequestModel(
                            namaLokasi: namaLokasiController.text.trim(),
                            latitude: selectedPosition!.latitude,
                            longitude: selectedPosition!.longitude
                          );
                          context.read<MapsBloc>().add(AddMap(requestModel: request));
                        },
                  child: Text(isLoading ? 'Menyimpan...' : 'Simpan Lokasi')
                  ),
                );
            }
          ),
          SpaceHeight(10)
        ],
      ),
    );
  }
}