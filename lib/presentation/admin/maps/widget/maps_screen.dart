import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaft_rent/core/components/spaces.dart';
import 'package:shaft_rent/core/constants/colors.dart';
import 'package:shaft_rent/presentation/admin/maps/getmaps/getmaps_bloc.dart';
import 'package:shaft_rent/presentation/admin/maps/getmaps/getmaps_state.dart';

class MapsScreen extends StatelessWidget {
  const MapsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.card,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 24, left: 24, right: 24, bottom: 10),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    height: 50,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.search, color: AppColors.black),
                        SpaceWidth(8),
                        Expanded(
                          child: Text(
                            'Cari Lokasi...',
                            style: TextStyle(color: AppColors.grey, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SpaceWidth(15),
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.filter_list, color: AppColors.black),
                ),
              ],
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
                label: const Text('Tambah Lokasi Baru', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                onPressed: () {},
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<GetMapsBloc, GetMapsState>(
              builder: (context, state) {
                if (state is GetMapsLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is GetMapsLoaded) {
                  final maps = state.maps;
                  if (maps.isEmpty) {
                    return const Center(
                      child: Text('Belum ada lokasi tersedia.\nSilahkan tambahkan lokasi baru.',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: AppColors.black, fontSize: 16)),
                    );
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.only(bottom: 20),
                    itemCount: maps.length,
                    itemBuilder: (context, index) {
                      final map = maps[index];
                      final String? staticMapUrl = map.staticMapImageUrl;
                      if (staticMapUrl == null || staticMapUrl.isEmpty) {
                        return const Center(
                          child: Text(
                            'URL Peta tidak tersedia untuk lokasi ini.',
                            style: TextStyle(color: AppColors.red, fontSize: 14),
                          ),
                        );
                      }
                      return InkWell(
                        onTap: () {},
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
                                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                const SpaceHeight(10),
                                SizedBox(
                                  height: 200,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      staticMapUrl,
                                      fit: BoxFit.cover,
                                      loadingBuilder: (context, child, loadingProgress) {
                                        if (loadingProgress == null) return child;
                                        return Center(
                                          child: CircularProgressIndicator(
                                            value: loadingProgress.expectedTotalBytes != null
                                                ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                                : null,
                                          ),
                                        );
                                      },
                                      errorBuilder: (context, error, stackTrace) {
                                        return const Center(child: Text('Gagal memuat peta.'));
                                      },
                                    ),
                                  ),
                                ),
                                const SpaceHeight(10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton.icon(
                                      icon: const Icon(Icons.edit, color: AppColors.primary),
                                      label: const Text('Edit', style: TextStyle(color: AppColors.primary)),
                                      onPressed: () {}), 
                                    const SizedBox(width: 8),
                                    TextButton.icon(
                                      icon: const Icon(Icons.delete, color: AppColors.red),
                                      label: const Text('Hapus', style: TextStyle(color: AppColors.red)),
                                      onPressed: () {},
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
                } else if (state is GetMapsError) {
                  return Center(child: Text('Gagal memuat data lokasi: ${state.message}'));
                } else {
                  return const Center(child: Text('Memuat data lokasi...'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}