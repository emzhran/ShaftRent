import 'package:flutter/material.dart';
import 'package:shaftrent/data/model/response/admin/profile_customer_response_model.dart';
import 'package:shaftrent/core/constants/colors.dart';
import 'package:shaftrent/core/components/spaces.dart';

class CustomerDetailScreen extends StatelessWidget {
  final ProfileCustomer profile;

  const CustomerDetailScreen({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Customer'),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
      ),
      backgroundColor: AppColors.card,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          color: AppColors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Data Customer',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                const SpaceHeight(16),
                const Text('Nama', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.black)),
                Text(profile.nama ?? '-',
                  style: TextStyle(color: (profile.nama != null && profile.nama!.isNotEmpty) ? AppColors.black : AppColors.red),
                ),
                const SpaceHeight(12),
                const Text('Email', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.black)),
                Text(
                  profile.user?.email ?? '-',
                  style: TextStyle(color: (profile.user?.email != null && profile.user!.email.isNotEmpty) ? AppColors.black : AppColors.red),
                ),
                const SpaceHeight(12),
                const Text('Alamat', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.black)),
                Text(
                  profile.alamat ?? 'Data belum lengkap',
                  style: TextStyle(color: (profile.alamat != null && profile.alamat!.isNotEmpty) ? AppColors.black : AppColors.red),
                ),
                const SpaceHeight(12),
                const Text('Jenis Identitas', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.black)),
                Text(
                  profile.identitas ?? 'Data belum lengkap',
                  style: TextStyle(color: (profile.identitas != null && profile.identitas!.isNotEmpty) ? AppColors.black : AppColors.red),
                ),
                const SpaceHeight(12),
                const Text('Nomor Identitas', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.black)),
                Text(
                  profile.nomorIdentitas ?? 'Data belum lengkap',
                  style: TextStyle(color: (profile.nomorIdentitas != null && profile.nomorIdentitas!.isNotEmpty) ? AppColors.black : AppColors.red),
                ),
                const SpaceHeight(8),
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: profile.uploadIdentitas != null && profile.uploadIdentitas!.isNotEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            profile.uploadIdentitas!,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) =>
                                const Center(child: Text('Gagal memuat gambar')),
                          ),
                        )
                      : const Center(
                          child: Text(
                            'Identitas belum diisi',
                            style: TextStyle(color: AppColors.red),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
