import 'package:flutter/material.dart';
import 'package:shaftrent/core/components/spaces.dart';
import 'package:shaftrent/core/constants/constants.dart';

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
                      children: const [
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
        ],
      ),
    );
  }
}