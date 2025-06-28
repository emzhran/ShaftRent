import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:shaft_rent_app/core/constants/colors.dart';
import 'package:shaft_rent_app/data/model/response/get_all_car_response_model.dart';


class CarScreen extends StatelessWidget {
  final GetAllCarModel carsData; 

  const CarScreen({super.key, required this.carsData});

  Uint8List _decodeBase64Image(String base64String) {
    final String base64Clean = base64String.split(',').last;
    return base64Decode(base64Clean);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.transparant,
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
                    child: const Row(
                      children: [
                        Icon(Icons.search, color: AppColors.grey),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            "Cari mobil...",
                            style: TextStyle(color: AppColors.grey, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.filter_list, color: AppColors.black),
                )
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
                icon: const Icon(Icons.add_circle_outline),
                label: const Text(
                  "Tambah Mobil Baru",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16
                  ),
                ),
                onPressed: () {
                  // navigasi add screen
                },
              ),
            ),
          ),
          Expanded(
            child: carsData.data.isEmpty
                ? const Center(
                    child: Text(
                      'Belum ada mobil tersedia.\nSilakan tambahkan mobil baru.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: AppColors.black, fontSize: 16),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(bottom: 20),
                    itemCount: carsData.data.length, 
                    itemBuilder: (context, index) {
                      final Car car = carsData.data[index]; 
                      return Card( 
                        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                        elevation: 4,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (car.fotoMobil != null && car.fotoMobil!.startsWith('data:image'))
                                Image.memory(
                                  _decodeBase64Image(car.fotoMobil!),
                                  height: 100,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) => const Icon(
                                    Icons.image_not_supported,
                                    size: 100,
                                    color: AppColors.grey,
                                  ),
                                )
                              else
                              const Icon(Icons.image_outlined, size: 100, color: AppColors.grey),
                              const SizedBox(height: 10),
                              Text(car.namaMobil, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                              Text('${car.merkMobil} - ${car.transmisi}', style: const TextStyle(fontSize: 14, color: AppColors.grey)),
                              Text('Harga: Rp${car.hargaMobil.toInt()}/hari', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                              Text('Jumlah: ${car.jumlahMobil} unit', style: const TextStyle(fontSize: 14)),
                              Text('Kursi: ${car.jumlahKursi}', style: const TextStyle(fontSize: 14)),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}