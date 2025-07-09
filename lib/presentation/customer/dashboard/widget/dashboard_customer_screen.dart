import 'package:flutter/material.dart';
import 'package:shaftrent/core/components/spaces.dart';
import 'package:shaftrent/core/constants/colors.dart';

class DashboardCustomerScreen extends StatefulWidget {
  const DashboardCustomerScreen({super.key});

  @override
  State<DashboardCustomerScreen> createState() => _DashboardCustomerScreenState();
}

class _DashboardCustomerScreenState extends State<DashboardCustomerScreen> {
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
              'Akun Saya',
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
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                leading: Icon(Icons.person_outline, color: AppColors.primary),
                title: Text('Profil', style: TextStyle(fontSize: 16)),
                trailing: Icon(Icons.chevron_right),
                onTap: (){
                  //navigasi halaman profile (progress)
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                leading: Icon(Icons.lock_outline, color: AppColors.primary),
                title: Text('Ganti Password', style: TextStyle(fontSize: 16)),
                trailing: Icon(Icons.chevron_right),
                onTap: () {
                  //navigasi halaman ganti password (progress)
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                leading: Icon(Icons.chat_outlined, color: AppColors.primary),
                title: Text('Chat dengan Admin', style: TextStyle(fontSize: 16)),
                trailing: Icon(Icons.chevron_right),
                onTap: () {
                  //navigasi halaman chat admin (progress)
                },
              ),
            ),
          ],
        ),
      ),
    );
}
}
