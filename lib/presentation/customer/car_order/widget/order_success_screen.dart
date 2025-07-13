import 'package:flutter/material.dart';
import 'package:shaftrent/core/components/spaces.dart';
import 'package:shaftrent/core/constants/colors.dart';
import 'package:shaftrent/data/model/response/auth_response_model.dart';
import 'package:shaftrent/presentation/customer/home/homepage_customer_screen.dart';

class OrderSuccessScreen extends StatelessWidget {
  final User user;
  final String namaPemesan;
  final String namaMobil;
  final String nomorKendaraan;
  final String tanggalMulai;
  final String tanggalSelesai;
  final String metodePembayaran;
  final int totalHarga;

  const OrderSuccessScreen({
    super.key,
    required this.user,
    required this.namaPemesan,
    required this.namaMobil,
    required this.nomorKendaraan,
    required this.tanggalMulai,
    required this.tanggalSelesai,
    required this.metodePembayaran,
    required this.totalHarga,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        automaticallyImplyLeading: false,
        title: const Text(
          'Pemesanan Berhasil',
          style: TextStyle(color: AppColors.white),
        ),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Icon(Icons.check_circle, color: AppColors.green, size: 80),
            ),
            const SpaceHeight(16),
            const Center(
              child: Text(
                'Berhasil Dipesan!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primary),
              ),
            ),
            const SpaceHeight(32),

            const Text(
              'Detail Pemesanan',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.primary),
            ),
            const SpaceHeight(16),
            const Text('Nama Pemesan', style: TextStyle(fontSize: 18 , fontWeight: FontWeight.bold)),
            Text(namaPemesan, style: TextStyle(fontSize: 17)),
            const SpaceHeight(16),
            const Text('Nama Mobil', style: TextStyle(fontSize: 18 , fontWeight: FontWeight.bold)),
            Text(namaMobil, style: TextStyle(fontSize: 17)),
            const SpaceHeight(12),
            const Text('Nomor Kendaraan', style: TextStyle(fontSize: 18 , fontWeight: FontWeight.bold)),
            Text(nomorKendaraan, style: TextStyle(fontSize: 17)),
            const SpaceHeight(12),
            const Text('Tanggal Mulai', style: TextStyle(fontSize: 18 , fontWeight: FontWeight.bold)),
            Text(tanggalMulai, style: TextStyle(fontSize: 17)),
            const SpaceHeight(12),
            const Text('Tanggal Selesai', style: TextStyle(fontSize: 18 , fontWeight: FontWeight.bold)),
            Text(tanggalSelesai, style: TextStyle(fontSize: 17),),
            const SpaceHeight(12),
            const Text('Metode Pembayaran', style: TextStyle( fontSize: 18, fontWeight: FontWeight.bold)),
            Row(
              children: [
                if (metodePembayaran.toUpperCase() == 'BRIVA')
                  Image.asset('assets/images/bri-virtual-logo.png', width: 55, height: 55),
                if (metodePembayaran.toUpperCase() == 'BNI')
                  Image.asset('assets/images/bni-virtual-logo.jpg', width: 55, height: 55),
                if (metodePembayaran.toUpperCase() == 'BCA')
                  Image.asset('assets/images/bca-virtual-logo.jpg', width: 55, height: 55),
                if (metodePembayaran.toUpperCase() == 'QRIS')
                  Image.asset('assets/images/qris-logo.png', width: 55, height: 55),
                const SpaceHeight(8),
                Text(metodePembayaran),
              ],
            ),
            const SpaceHeight(12),
            const Text('Total Harga', style: TextStyle(fontSize: 18 ,fontWeight: FontWeight.bold)),
            Text('Rp$totalHarga', style: TextStyle(fontSize: 17)),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (_) => HomepageCustomerScreen(loggedInUser: user),
                    ),
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Kembali ke Beranda',
                  style: TextStyle(color: AppColors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
