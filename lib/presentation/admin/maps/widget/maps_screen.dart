import 'package:flutter/material.dart';
import 'package:shaftrent/core/constants/colors.dart';

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
        ],
      ),
    );
  }
}
