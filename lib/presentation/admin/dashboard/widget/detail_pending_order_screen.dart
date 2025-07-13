import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaftrent/core/components/spaces.dart';
import 'package:shaftrent/core/constants/colors.dart';
import 'package:shaftrent/data/model/response/admin/status_order_update.dart';
import 'package:shaftrent/presentation/admin/dashboard/order_car_by_customer/bloc/order_car_by_customer_bloc.dart';
import 'package:shaftrent/presentation/admin/dashboard/order_car_by_customer/bloc/order_car_by_customer_event.dart';

class DetailPendingOrderScreen extends StatelessWidget {
  final CarOrderAdmin order;

  const DetailPendingOrderScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final car = order.car;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Pesanan'),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              'Data Customer',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: AppColors.primary,
              ),
            ),
            const SpaceHeight(8),
            Text('Email: ${order.email ?? '-'}'),
            SpaceHeight(10),
            Text('Nama: ${order.nama ?? '-'}'),
            SpaceHeight(10),
            Text('Alamat: ${order.alamat ?? '-'}'),
            SpaceHeight(10),
            Text('Identitas: ${order.identitas ?? '-'}'),
            SpaceHeight(10),
            Text('Nomor Identitas: ${order.nomorIdentitas ?? '-'}'),
            const SpaceHeight(16),
            const Text(
              'Data Mobil',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: AppColors.primary,
              ),
            ),
            const SpaceHeight(8),
            Text('Nama Mobil: ${car?.namaMobil ?? '-'}'),
            SpaceHeight(10),
            Text('Merek: ${car?.merkMobil ?? '-'}'),
            const SpaceHeight(16),
            const Text(
              'Data Pemesanan',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: AppColors.primary,
              ),
            ),
            const SpaceHeight(8),
            Text('Tanggal Mulai: ${order.tanggalMulai}'),
            SpaceHeight(10),
            Text('Tanggal Selesai: ${order.tanggalSelesai}'),
            SpaceHeight(10),
            Text('Metode Pembayaran: ${order.metodePembayaran}'),
            const SpaceHeight(24),
            ElevatedButton.icon(
              onPressed: () {
                context.read<OrderCarByCustomerBloc>().add(
                      UpdatePendingOrderStatus(
                        orderId: order.id,
                        newStatus: 'Dikonfirmasi',
                      ),
                    );
                Navigator.pop(context);
              },
              icon: const Icon(Icons.check, color: AppColors.white),
              label: const Text(
                'Konfirmasi Pesanan',
                style: TextStyle(color: AppColors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
