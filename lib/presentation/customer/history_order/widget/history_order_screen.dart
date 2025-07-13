import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shaftrent/core/components/spaces.dart';
import 'package:shaftrent/core/constants/colors.dart';
import 'package:shaftrent/presentation/customer/history_order/bloc/history_order_bloc.dart';
import 'package:shaftrent/presentation/customer/history_order/bloc/history_order_event.dart';
import 'package:shaftrent/presentation/customer/history_order/bloc/history_order_state.dart';
import 'package:shaftrent/presentation/customer/history_order/widget/detail_history_screen.dart';

class HistoryOrderScreen extends StatelessWidget {
  const HistoryOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<HistoryOrderBloc>().add(GetHistoryOrders());
    return Scaffold(
      backgroundColor: AppColors.card,
      body: BlocBuilder<HistoryOrderBloc, HistoryOrderState>(
        builder: (context, state) {
          if (state is HistoryOrderLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HistoryOrderError) {
            return Center(child: Text(state.message));
          } else if (state is HistoryOrderLoaded) {
            if (state.orders.isEmpty) {
              return const Center(child: Text('Belum ada riwayat pemesanan.'));
            }
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.orders.length,
              itemBuilder: (_, index) {
                final order = state.orders[index];
                final formatter = DateFormat('dd MMM yyyy');
                Color statusColor = AppColors.grey;
                switch (order.statusPemesanan.toLowerCase()) {
                  case 'pending':
                    statusColor = AppColors.red;
                    break;
                  case 'dikonfirmasi':
                    statusColor = AppColors.secondary;
                    break;
                  case 'selesai':
                    statusColor = AppColors.green;
                    break;
                  case 'dibatalkan':
                    statusColor = AppColors.red;
                    break;
                }
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailHistoryScreen(order: order),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(16),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${order.car?.merkMobil ?? '-'} - ${order.car?.namaMobil ?? '-'}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SpaceHeight(10),
                        Text('Tanggal Mulai : ${formatter.format(order.tanggalMulai)}'),
                        SpaceHeight(10),
                        Text('Tanggal Selesai : ${formatter.format(order.tanggalSelesai)}'),
                        const SizedBox(height: 10),
                        Text('Metode Pembayaran : ${order.metodePembayaran}'),
                        const SpaceHeight(10),
                        Text(
                          'Status Pemesanan : ${order.statusPemesanan}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: statusColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
