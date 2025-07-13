import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shaftrent/core/components/spaces.dart';
import 'package:shaftrent/core/constants/colors.dart';
import 'package:shaftrent/presentation/customer/maps_customer/bloc/maps_customer_bloc.dart';
import 'package:shaftrent/presentation/customer/maps_customer/bloc/maps_customer_event.dart';
import 'package:shaftrent/presentation/customer/maps_customer/bloc/maps_customer_state.dart';

class MapsCustomerScreen extends StatefulWidget {
  const MapsCustomerScreen({super.key});

  @override
  State<MapsCustomerScreen> createState() => _MapsCustomerScreenState();
}

class _MapsCustomerScreenState extends State<MapsCustomerScreen> {
  @override
  void initState() {
    super.initState();
    context.read<MapsCustomerBloc>().add(GetMaps());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.card,
      body: BlocBuilder<MapsCustomerBloc, MapsCustomerState>(
        builder: (context, state) {
          if (state is MapsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MapsLoaded) {
            final maps = state.maps;
            if (maps.isEmpty) {
              return const Center(
                child: Text(
                  'Belum ada lokasi tersedia.',
                  style: TextStyle(fontSize: 16),
                ),
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.only(bottom: 20),
              itemCount: maps.length,
              itemBuilder: (context, index) {
              final map = maps[index];
              return GestureDetector(
                onTap: () {
                  //navigasi detail maps
                },
                child: Card(
                  margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          map.namaLokasi,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SpaceHeight(10),
                        SizedBox(
                          height: 200,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: GoogleMap(
                              initialCameraPosition: CameraPosition(
                                target: LatLng(map.latitude, map.longitude),
                                zoom: 14,
                              ),
                              markers: {
                                Marker(
                                  markerId: MarkerId(map.id.toString()),
                                  position: LatLng(map.latitude, map.longitude),
                                  infoWindow: InfoWindow(title: map.namaLokasi),
                                ),
                              },
                              zoomControlsEnabled: false,
                              liteModeEnabled: true,
                              myLocationButtonEnabled: false,
                              compassEnabled: false,
                              mapToolbarEnabled: false,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            );
          } else if (state is MapsError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: AppColors.red),
              ),
            );
          } else {
            return const Center(child: Text('Memuat lokasi...'));
          }
        },
      ),
    );
  }
}
