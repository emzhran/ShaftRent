import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaftrent/core/components/spaces.dart';
import 'package:shaftrent/core/constants/constants.dart';
import 'package:shaftrent/presentation/admin/car/bloc/car_bloc.dart';
import 'package:shaftrent/presentation/admin/car/bloc/car_event.dart';
import 'package:shaftrent/presentation/admin/car/bloc/car_state.dart';
import 'package:shaftrent/presentation/admin/car/widget/add_car_screen.dart';
import 'package:shaftrent/presentation/admin/car/widget/update_car_screen.dart';

class CarScreen extends StatefulWidget {
  const CarScreen({super.key});

  @override
  State<CarScreen> createState() => _CarScreenState();
}

class _CarScreenState extends State<CarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.card,
      body: Column(
        children: [
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
                icon: const Icon(Icons.add_circle_outline),
                label: const Text('Tambah Mobil Baru', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AddCarScreen()),
                  );
                  if (result == true && context.mounted) {
                    context.read<CarBloc>().add(FetchCars());
                  }
                },
              ), 
            ),
          ),
          Expanded(
            child: BlocBuilder<CarBloc, CarState>(
              builder: (context, state) {
                if (state is CarLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is CarListLoaded) {
                  final cars = state.cars.data;
                  if (cars.isEmpty) {
                    return const Center(
                      child: Text('Belum ada mobil tersedia. \nSilahkan tambahkan mobil baru.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: AppColors.black, fontSize: 16)),
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
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
                                  child: const Center(child: Icon(Icons.image_outlined, size: 100, color: AppColors.grey)),
                                ),
                              const SpaceHeight(10),
                              Text(car.namaMobil, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                              const SpaceHeight(5),
                              Text('${car.merkMobil} - ${car.transmisi}', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                              const SpaceHeight(5),
                              Text('Nomor Kendaraan: ${car.nomorKendaraan}', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                              const SpaceHeight(5),
                              Text('Harga: Rp${car.hargaMobil.toInt()}/hari', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                              const SpaceHeight(5),
                              Text('Jumlah: ${car.jumlahMobil} unit'),
                              const SpaceHeight(5),
                              Text('Kursi: ${car.jumlahKursi}'),
                              const SpaceHeight(10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton.icon(
                                    onPressed: () async {
                                       final result = await Navigator.push(
                                        context, 
                                        MaterialPageRoute(
                                          builder: (context) => UpdateCarScreen(car: car),
                                        ),
                                      );
                                      if (result == true && context.mounted) {
                                        context.read<CarBloc>().add(FetchCars());
                                      }
                                    },
                                    icon: const Icon(Icons.edit, color: AppColors.primary),
                                    label: const Text("Edit", style: TextStyle(color: AppColors.primary)),
                                  ),
                                  const SizedBox(width: 8),
                                  TextButton.icon(
                                    icon: const Icon(Icons.delete, color: AppColors.red),
                                    label: const Text("Hapus", style: TextStyle(color: AppColors.red)),
                                    onPressed: () {
                                      final navigator = Navigator.of(context);
                                      final messenger = ScaffoldMessenger.of(context);
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: const Text("Hapus Mobil"),
                                          content: const Text("Yakin ingin menghapus mobil ini?"),
                                          actions: [
                                            TextButton(
                                              child: const Text("Batal"),
                                              onPressed: () => navigator.pop(),
                                            ),
                                            TextButton(
                                              child: const Text("Hapus", style: TextStyle(color: AppColors.red)),
                                              onPressed: () {
                                                navigator.pop();
                                                showDialog(
                                                  context: context,
                                                  barrierDismissible: false,
                                                  builder: (context) {
                                                    return BlocListener<CarBloc, CarState>(
                                                      listener: (context, state) {
                                                        if (state is CarDeleted) {
                                                          navigator.pop();
                                                          messenger.showSnackBar(
                                                            const SnackBar(
                                                              content: Text("Mobil berhasil dihapus"),
                                                              backgroundColor: Colors.green,
                                                            ),
                                                          );
                                                          context.read<CarBloc>().add(FetchCars());
                                                        } else if (state is CarError) {
                                                          navigator.pop();
                                                          messenger.showSnackBar(
                                                            SnackBar(
                                                              content: Text("Gagal: ${state.message}"),
                                                              backgroundColor: AppColors.red,
                                                            ),
                                                          );
                                                        }
                                                      },
                                                      child: const Center(
                                                        child: CircularProgressIndicator(),
                                                      ),
                                                    );
                                                  },
                                                );
                                                context.read<CarBloc>().add(DeleteCar(carId: car.id));
                                              },
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
                      );
                    },
                  );
                } else if (state is CarError) {
                  return Center(child: Text('Error memuat data mobil: ${state.message}'));
                } else {
                  return const Center(child: Text('Memuat data mobil...'));
                }
              },
            ),
          )
        ],
      ),
    );
  }
}