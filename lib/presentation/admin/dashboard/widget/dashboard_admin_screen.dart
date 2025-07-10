import 'package:flutter/material.dart';
import 'package:shaftrent/core/constants/colors.dart';
import 'package:shaftrent/core/components/spaces.dart';

class DashboardAdminScreen extends StatelessWidget {
  const DashboardAdminScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.card,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Dashboard Admin',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const SpaceHeight(20),
            Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: const Icon(Icons.people_outline, color: AppColors.primary),
                title: const Text('Data Customer', style: TextStyle(fontSize: 16)),
                onTap: () {
                  //navigasi ke halaman data customer
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: Icon(Icons.pending_actions_outlined, color: AppColors.primary),
                title: Text('Pending Order', style: TextStyle(fontSize: 16)),
                onTap: () {
                  //navigasi ke halaman pending (progress)
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: Icon(Icons.receipt_long_outlined, color: AppColors.primary),
                title: Text('Riwayat Pesanan', style: TextStyle(fontSize: 16)),
                onTap: () {
                  //navigasi ke halaman riwayat pesanan (progress)
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
