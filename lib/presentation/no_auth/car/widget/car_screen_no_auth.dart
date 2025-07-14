import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shaftrent/core/components/spaces.dart';
import 'package:shaftrent/core/constants/colors.dart';
import 'package:shaftrent/presentation/no_auth/car/bloc/car_no_auth_bloc.dart';
import 'package:shaftrent/presentation/no_auth/car/bloc/car_no_auth_event.dart';
import 'package:shaftrent/presentation/no_auth/car/bloc/car_no_auth_state.dart';

class CarScreenNoAuth extends StatefulWidget {
  const CarScreenNoAuth({super.key});

  @override
  State<CarScreenNoAuth> createState() => _CarScreenNoAuthState();
}

class _CarScreenNoAuthState extends State<CarScreenNoAuth> {
  final formatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

  @override
  void initState() {
    context.read<CarNoAuthBloc>().add(GetCarsNoAuth());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.card,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<CarNoAuthBloc, CarNoAuthState>(
          builder: (context, state) {
            if (state is CarNoAuthLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CarNoAuthFailure) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: AppColors.red),
                ),
              );
            } else if (state is CarNoAuthLoaded) {
              final cars = state.cars;
              return ListView.builder(
                itemCount: cars.length,
                itemBuilder: (context, index) {
                  final car = cars[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.black.withOpacity(0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                          child: car.gambarmobil != null && car.gambarmobil!.isNotEmpty
                              ? CachedNetworkImage(
                                  imageUrl: car.gambarmobil!,
                                  height: 180,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Container(
                                    color: AppColors.grey,
                                    child: const Center(child: CircularProgressIndicator()),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.broken_image, size: 40),
                                )
                              : Container(
                                  height: 180,
                                  color: AppColors.grey,
                                  child: const Icon(Icons.image_not_supported, size: 40),
                                ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${car.merkMobil} - ${car.namaMobil}',
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              const SpaceHeight(4),
                              Text('Transmisi: ${car.transmisi}'),
                              Text('Nomor Kendaraan: ${car.nomorKendaraan}'),
                              Text('Harga: ${formatter.format(car.hargaMobil)}/hari'),
                              const SpaceHeight(12),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(16),
                                          ),
                                          title: const Text('Login Diperlukan'),
                                          content: const Text('Silakan login terlebih dahulu untuk melakukan pemesanan.'),
                                          actions: [
                                            TextButton(
                                              onPressed: () => Navigator.pop(context),
                                              child: const Text('Tutup'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    padding: const EdgeInsets.symmetric(vertical: 12),
                                  ),
                                  child: const Text(
                                    'Pesan',
                                    style: TextStyle(fontSize: 16, color: AppColors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
