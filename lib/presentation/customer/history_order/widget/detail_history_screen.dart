import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shaftrent/core/components/spaces.dart';
import 'package:shaftrent/core/constants/colors.dart';
import 'package:shaftrent/data/model/response/customer/history_order_response.dart';
import 'package:shaftrent/presentation/customer/history_order/bloc/history_order_bloc.dart';
import 'package:shaftrent/presentation/customer/history_order/bloc/history_order_event.dart';
import 'package:shaftrent/presentation/customer/history_order/bloc/history_order_state.dart';

class DetailHistoryScreen extends StatefulWidget {
  final HistoryOrder order;

  const DetailHistoryScreen({super.key, required this.order});

  @override
  State<DetailHistoryScreen> createState() => _DetailHistoryScreenState();
}

class _DetailHistoryScreenState extends State<DetailHistoryScreen> {
  late int selectedRating;

  @override
  void initState() {
    super.initState();
    selectedRating = widget.order.rating ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    final order = widget.order;
    final formatter = DateFormat('dd MMM yyyy');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Riwayat Pemesanan'),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
      ),
      backgroundColor: AppColors.card,
      body: BlocBuilder<HistoryOrderBloc, HistoryOrderState>(
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withOpacity(0.05),
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
                      child: order.car?.gambarMobil != null &&
                              order.car!.gambarMobil!.isNotEmpty
                          ? CachedNetworkImage(
                              imageUrl: order.car!.gambarMobil!,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Container(
                                color: AppColors.grey,
                                child: const Center(
                                    child: CircularProgressIndicator()),
                              ),
                              errorWidget: (context, url, error) => Container(
                                color: AppColors.grey,
                                child: const Icon(Icons.broken_image, size: 40),
                              ),
                            )
                          : Container(
                              color: AppColors.grey,
                              child: const Icon(Icons.image_not_supported,
                                  size: 40),
                            ),
                    ),
                  ),
                  const SpaceHeight(16),
                  Text(
                    '${order.car?.merkMobil ?? '-'} - ${order.car?.namaMobil ?? '-'}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SpaceHeight(10),
                  Text('Transmisi: ${order.car?.transmisi ?? '-'}'),
                  SpaceHeight(10),
                  Text('Nomor Kendaraan: ${order.car?.nomorKendaraan ?? '-'}'),
                  SpaceHeight(10),
                  Text(
                      'Tanggal Mulai: ${formatter.format(order.tanggalMulai)}'),
                  SpaceHeight(10),
                  Text(
                      'Tanggal Selesai: ${formatter.format(order.tanggalSelesai)}'),
                  SpaceHeight(10),
                  Text('Metode Pembayaran: ${order.metodePembayaran}'),
                  SpaceHeight(10),
                  Builder(
                    builder: (context) {
                      Color statusColor;
                      if (order.statusPemesanan.toLowerCase() == 'pending' ||
                          order.statusPemesanan.toLowerCase() ==
                              'dibatalkan') {
                        statusColor = AppColors.red;
                      } else if (order.statusPemesanan.toLowerCase() ==
                          'dikonfirmasi') {
                        statusColor = AppColors.primary;
                      } else if (order.statusPemesanan.toLowerCase() ==
                          'selesai') {
                        statusColor = AppColors.green;
                      } else {
                        statusColor = AppColors.grey;
                      }
                      return Text(
                        'Status Pemesanan: ${order.statusPemesanan}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: statusColor,
                        ),
                      );
                    },
                  ),
                  if (order.statusPemesanan.toLowerCase() == 'selesai') ...[
                    const SizedBox(height: 24),
                    const Text(
                      'Beri Rating:',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SpaceHeight(10),
                    Row(
                      children: List.generate(5, (index) {
                        final isFilled = index < selectedRating;
                        return GestureDetector(
                          onTap: widget.order.rating != null ||
                                  state is RatingSubmitting
                              ? null
                              : () {
                                  final ratingToSend = index + 1;
                                  setState(() {
                                    selectedRating = ratingToSend;
                                  });
                                  context.read<HistoryOrderBloc>().add(
                                        SubmitOrderRating(
                                          orderId: order.id,
                                          rating: ratingToSend,
                                        ),
                                      );
                                },
                          child: Icon(
                            isFilled ? Icons.star : Icons.star_border,
                            color: AppColors.primary,
                            size: 32,
                          ),
                        );
                      }),
                    ),
                    SpaceHeight(10),
                    if (state is RatingSuccess || selectedRating != 0)
                      const Text(
                        'Terima kasih telah memberi rating.',
                        style: TextStyle(color: AppColors.primary),
                      ),
                    if (state is RatingError)
                      Text(
                        state.message,
                        style: const TextStyle(color: AppColors.red),
                      ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
