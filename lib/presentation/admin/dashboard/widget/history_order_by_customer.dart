import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaftrent/core/components/components.dart';
import 'package:shaftrent/core/constants/colors.dart';
import 'package:shaftrent/presentation/admin/dashboard/order_car_by_customer/bloc/order_car_by_customer_bloc.dart';
import 'package:shaftrent/presentation/admin/dashboard/order_car_by_customer/bloc/order_car_by_customer_event.dart';
import 'package:shaftrent/presentation/admin/dashboard/order_car_by_customer/bloc/order_car_by_customer_state.dart';

class HistoryOrderByCustomerScreen extends StatefulWidget {
  const HistoryOrderByCustomerScreen({super.key});

  @override
  State<HistoryOrderByCustomerScreen> createState() => _HistoryOrderByCustomerScreenState();
}

class _HistoryOrderByCustomerScreenState extends State<HistoryOrderByCustomerScreen> {
  @override
  void initState() {
    super.initState();
    context.read<OrderCarByCustomerBloc>().add(FetchAllOrdersByCustomer());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Pesanan'),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
      ),
      body: BlocBuilder<OrderCarByCustomerBloc, OrderCarByCustomerState>(
        builder: (context, state) {
          if (state is OrderCarByCustomerLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is OrderCarByCustomerLoaded) {
            final selesaiOrders = state.selesai;
            if (selesaiOrders.isEmpty) {
              return const Center(child: Text('Belum ada pesanan yang selesai.'));
            }
            return ListView.builder(
              itemCount: selesaiOrders.length,
              itemBuilder: (context, index) {
                final order = selesaiOrders[index];
                final car = order.car;
                return Card(
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
                          car?.namaMobil ?? 'Nama Mobil',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                        const SpaceHeight(4),
                        Text('Customer: ${order.nama}'),
                        SpaceHeight(8),
                        Text('Mulai: ${order.tanggalMulai}'),
                        SpaceHeight(8),
                        Text('Selesai: ${order.tanggalSelesai}'),
                        SpaceHeight(8),
                        Text('Metode Pembayaran: ${order.metodePembayaran}'),
                      ],
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
