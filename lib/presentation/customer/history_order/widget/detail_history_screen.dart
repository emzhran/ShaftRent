import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shaftrent/core/constants/colors.dart';
import 'package:shaftrent/core/components/spaces.dart';
import 'package:shaftrent/data/model/response/customer/history_order_response.dart';

class DetailHistoryScreen extends StatelessWidget {
  final HistoryOrder order;

  const DetailHistoryScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat('dd MMM yyyy');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Riwayat Pemesanan'),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
      ),
      backgroundColor: AppColors.card,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 4),
              )
            ],
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 180,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: order.car?.gambarMobil != null && order.car!.gambarMobil!.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: order.car!.gambarMobil!,
                          height: 150,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            height: 150,
                            color: Colors.grey[200],
                            child: const Center(child: CircularProgressIndicator()),
                          ),
                          errorWidget: (context, url, error) => Container(
                            height: 150,
                            color: Colors.grey[300],
                            child: const Icon(Icons.broken_image, size: 40),
                          ),
                        )
                      : Container(
                          height: 150,
                          color: AppColors.grey,
                          child: const Center(
                            child: Icon(Icons.image_not_supported, size: 40, color: AppColors.grey),
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                '${order.car?.merkMobil ?? '-'} - ${order.car?.namaMobil ?? '-'}',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SpaceHeight(10),
              Text('Transmisi : ${order.car?.transmisi ?? '-'}'),
              SpaceHeight(10),
              Text('Tanggal Mulai : ${formatter.format(order.tanggalMulai)}'),
              SpaceHeight(10),
              Text('Tanggal Selesai : ${formatter.format(order.tanggalSelesai)}'),
              SpaceHeight(10),
              Text('Metode Pembayaran : ${order.metodePembayaran}'),
              SpaceHeight(10),
              Text(
                'Status Pemesanan : ${order.statusPemesanan}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: order.statusPemesanan.toLowerCase() == 'pending'
                      ? AppColors.red
                      : order.statusPemesanan.toLowerCase() == 'dikonfirmasi'
                          ? AppColors.secondary
                          : order.statusPemesanan.toLowerCase() == 'selesai'
                              ? AppColors.green
                              : order.statusPemesanan.toLowerCase() == 'dibatalkan'
                                  ? AppColors.red
                                  : AppColors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
