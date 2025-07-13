import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shaftrent/core/components/spaces.dart';
import 'package:shaftrent/core/constants/colors.dart';
import 'package:shaftrent/presentation/no_auth/maps/bloc/maps_no_auth_bloc.dart';
import 'package:shaftrent/presentation/no_auth/maps/bloc/maps_no_auth_event.dart';
import 'package:shaftrent/presentation/no_auth/maps/bloc/maps_no_auth_state.dart';

class MapsNoAuthScreen extends StatefulWidget {
  const MapsNoAuthScreen({super.key});

  @override
  State<MapsNoAuthScreen> createState() => _MapsNoAuthScreenState();
}

class _MapsNoAuthScreenState extends State<MapsNoAuthScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MapsNoAuthBloc>().add(GetMapsNoAuth());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.card,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Card(
                color: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.location_on, color: AppColors.primary),
                          SpaceWidth(8),
                          Text(
                            'Temukan Lokasi Kami',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Container(
                        height: 3,
                        width: 160,
                        color: AppColors.primary.withOpacity(0.3),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<MapsNoAuthBloc, MapsNoAuthState>(
              builder: (context, state) {
                if (state is MapsNoAuthLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is MapsNoAuthLoaded) {
                  final maps = state.locations;
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
                      return Card(
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
                      );
                    },
                  );
                } else if (state is MapsNoAuthFailure) {
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
          ),
        ],
      ),
    );
  }
}
