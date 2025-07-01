import 'package:flutter/material.dart';
import 'package:shaft_rent/core/components/spaces.dart';
import 'package:shaft_rent/core/constants/colors.dart';

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
                onPressed: () {
                  //navigasi ke add car screen (progress)
                }
              ), 
            ),
          ),
        ],
      ),
    );
  }
}