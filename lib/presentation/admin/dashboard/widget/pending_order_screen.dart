import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaftrent/core/constants/colors.dart';
import 'package:shaftrent/presentation/admin/dashboard/order_car_by_customer/bloc/order_car_by_customer_bloc.dart';
import 'package:shaftrent/presentation/admin/dashboard/order_car_by_customer/bloc/order_car_by_customer_event.dart';
import 'package:shaftrent/presentation/admin/dashboard/order_car_by_customer/bloc/order_car_by_customer_state.dart';
import 'package:shaftrent/presentation/admin/dashboard/widget/detail_pending_order_screen.dart';

class PendingOrderScreen extends StatefulWidget {
  const PendingOrderScreen({super.key});

  @override
  State<PendingOrderScreen> createState() => _PendingOrderScreenState();
}

class _PendingOrderScreenState extends State<PendingOrderScreen> {
  @override
  void initState() {
    super.initState();
    context.read<OrderCarByCustomerBloc>().add(FetchAllOrdersByCustomer());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Pesanan Pending'),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
      ),
      body: BlocConsumer<OrderCarByCustomerBloc, OrderCarByCustomerState>(
        listener: (context, state) {
          if (state is OrderCarByCustomerStatusUpdated || state is OrderCarByCustomerError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state is OrderCarByCustomerStatusUpdated
                      ? state.message
                      : (state as OrderCarByCustomerError).message,
                ),
                backgroundColor: state is OrderCarByCustomerError ? AppColors.red : AppColors.green,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is OrderCarByCustomerLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is OrderCarByCustomerLoaded) {
            final pendingOrders = state.pending;

            if (pendingOrders.isEmpty) {
              return const Center(child: Text('Tidak ada pesanan pending.'));
            }
            return ListView.builder(
              itemCount: pendingOrders.length,
              itemBuilder: (context, index) {
                final order = pendingOrders[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailPendingOrderScreen(order: order),
                      ),
                    );
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            order.car?.namaMobil ?? 'Nama Mobil',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text('Customer: ${order.nama ?? '-'}'),
                          Text('Mulai: ${order.tanggalMulai}'),
                          Text('Selesai: ${order.tanggalSelesai}'),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
          if (state is OrderCarByCustomerError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const SizedBox();
        },
      ),
    );
  }
}
