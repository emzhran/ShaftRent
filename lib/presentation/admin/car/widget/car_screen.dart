import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaft_rent/core/components/spaces.dart';
import 'package:shaft_rent/core/constants/colors.dart';
import 'package:shaft_rent/presentation/admin/car/getcar/getcar_bloc.dart';
import 'package:shaft_rent/presentation/admin/car/getcar/getcar_event.dart';
import 'package:shaft_rent/presentation/admin/car/getcar/getcar_state.dart';
import 'package:shaft_rent/presentation/admin/car/widget/add_car_screen.dart';

class CarScreen extends StatelessWidget {
  const CarScreen({super.key});

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
                            'Cari Mobil...',
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
                    borderRadius: BorderRadiusGeometry.circular(14),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  elevation: 3,
                ),
                icon: const Icon(Icons.add_circle_outline),
                label: Text('Tambah Mobil Baru', 
                style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 16),
                ),
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AddCarScreen()),
                  );
                  if (result == true && context.mounted) {
                    context.read<GetCarBloc>().add(FetchCars());
                  }
                }
              ), 
            ),
          ),
          Expanded(
            child: BlocBuilder<GetCarBloc, GetCarState>(
              builder: (context, state) {
                if (state is GetCarLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is GetCarLoaded) {
                  final cars = state.cars.data;
                  if (cars.isEmpty) {
                    return const Center(
                      child: Text('Belum ada mobil tersedia. \nSilahkan tambahkan mobil baru.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 16),
                      ),
                    );
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.only(bottom: 20),
                    itemCount: cars.length,
                    itemBuilder: (context, index) {
                      final car = cars[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (car.gambarmobil != null && car.gambarmobil!.isNotEmpty)
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  imageUrl: car.gambarmobil!,
                                  height: 150,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  errorWidget: (context, url, error) => const Icon(
                                    Icons.image_not_supported,
                                    size: 100,
                                    color: AppColors.grey
                                  ),
                                ),
                              )
                              else
                              Container(
                                height: 150,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: AppColors.grey,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.image_outlined,
                                    size: 100,
                                    color: AppColors.grey
                                  ),
                                ),
                              ),
                              const SpaceHeight(10),
                              Text(
                                car.namaMobil,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              Text(
                                '${car.merkMobil} - ${car.transmisi}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              Text(
                                'Harga: Rp${car.hargaMobil.toInt()}/hari',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              Text(
                                'Jumlah: ${car.jumlahMobil} unit'
                              ),
                              Text(
                                'Kursi: ${car.jumlahKursi}'
                              )
                            ],
                          ),
                        ),
                      );
                    }
                  );
                } else if (state is GetCarError) {
                  return Center(
                    child: Text('Error memuat data mobil: ${state.message}'),
                  );
                } else {
                  return const Center(child: Text('Memuat data mobil...'));
                }
              }
            )
          )
        ],
      ),
    );
  }
}