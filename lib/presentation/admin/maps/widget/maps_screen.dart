import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shaftrent/core/components/spaces.dart';
import 'package:shaftrent/core/constants/colors.dart';
import 'package:shaftrent/presentation/admin/maps/bloc/maps_bloc.dart';
import 'package:shaftrent/presentation/admin/maps/bloc/maps_event.dart';
import 'package:shaftrent/presentation/admin/maps/bloc/maps_state.dart';

class MapsScreen extends StatefulWidget {
  const MapsScreen({super.key});

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.card,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 32, left: 24, right: 24, bottom: 10),
            child: Text(
              'Dengan Shaft Rental menjadi mudah.',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  elevation: 3,
                ),
                icon: const Icon(Icons.add_location_alt_outlined),
                label: const Text(
                  'Tambah Lokasi Baru',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                onPressed: () async {
                  // Navigasi ke AddMapsScreen
                },
              ),
            ),
          ),
          Expanded(
            child: BlocListener<MapsBloc, MapsState>(
              listener: (context, state) {
                if (state is MapAdded || state is MapUpdated || state is MapDeleted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        state is MapAdded
                            ? 'Lokasi berhasil ditambahkan!'
                            : state is MapUpdated
                                ? 'Lokasi berhasil diperbarui!'
                                : 'Lokasi berhasil dihapus!',
                      ),
                      backgroundColor: AppColors.green,
                    ),
                  );
                  context.read<MapsBloc>().add(FetchMaps());
                } else if (state is MapsError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Gagal: ${state.message}"),
                      backgroundColor: AppColors.red,
                    ),
                  );
                }
              },
              child: BlocBuilder<MapsBloc, MapsState>(
                builder: (context, state) {
                  if (state is MapsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is MapsLoaded) {
                    final maps = state.maps;
                    if (maps.isEmpty) {
                      return const Center(
                        child: Text(
                          'Belum ada lokasi tersedia.\nSilahkan tambahkan lokasi baru.',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: AppColors.black, fontSize: 16),
                        ),
                      );
                    }
                    return ListView.builder(
                      padding: const EdgeInsets.only(bottom: 20),
                      itemCount: maps.length,
                      itemBuilder: (context, index) {
                        final map = maps[index];
                        return InkWell(
                          onTap: () {
                            // Navigasi ke DetailMapsScreen
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
                                  const SpaceHeight(10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton.icon(
                                        icon: const Icon(Icons.edit, color: AppColors.primary),
                                        label: const Text(
                                          'Edit',
                                          style: TextStyle(color: AppColors.primary),
                                        ),
                                        onPressed: () {
                                          // Navigasi ke UpdateMapsScreen
                                        },
                                      ),
                                      const SizedBox(width: 8),
                                      TextButton.icon(
                                        icon: const Icon(Icons.delete, color: AppColors.red),
                                        label: const Text(
                                          'Hapus',
                                          style: TextStyle(color: AppColors.red),
                                        ),
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              title: const Text('Hapus Lokasi'),
                                              content: const Text('Yakin ingin menghapus lokasi ini?'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () => Navigator.pop(context),
                                                  child: const Text('Batal'),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                    context
                                                        .read<MapsBloc>()
                                                        .add(DeleteMap(mapId: map.id));
                                                  },
                                                  child: const Text(
                                                    'Hapus',
                                                    style: TextStyle(color: AppColors.red),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(child: Text('Memuat maps...'));
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
