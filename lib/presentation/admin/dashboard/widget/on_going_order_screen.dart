import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaftrent/core/components/spaces.dart';
import 'package:shaftrent/core/constants/colors.dart';
import 'package:shaftrent/presentation/admin/dashboard/order_car_by_customer/bloc/order_car_by_customer_bloc.dart';
import 'package:shaftrent/presentation/admin/dashboard/order_car_by_customer/bloc/order_car_by_customer_event.dart';
import 'package:shaftrent/presentation/admin/dashboard/order_car_by_customer/bloc/order_car_by_customer_state.dart';

class OnGoingOrderScreen extends StatefulWidget {
  const OnGoingOrderScreen({super.key});

  @override
  State<OnGoingOrderScreen> createState() => _OnGoingOrderScreenState();
}

class _OnGoingOrderScreenState extends State<OnGoingOrderScreen> {
  @override
  void initState() {
    super.initState();
    context.read<OrderCarByCustomerBloc>().add(FetchAllOrdersByCustomer());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pesanan Berjalan'),
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
            final confirmedOrders = state.dikonfirmasi;

            if (confirmedOrders.isEmpty) {
              return const Center(child: Text('Tidak ada pesanan berjalan.'));
            }
            return ListView.builder(
              itemCount: confirmedOrders.length,
              itemBuilder: (context, index) {
                final order = confirmedOrders[index];
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
                        Text('Customer: ${order.nama ?? '-'}'),
                        SpaceHeight(10),
                        Text('Mulai: ${order.tanggalMulai}'),
                        SpaceHeight(10),
                        Text('Selesai: ${order.tanggalSelesai}'),
                        const SpaceHeight(12),
                        ElevatedButton.icon(
                          onPressed: () {
                            context.read<OrderCarByCustomerBloc>().add(
                                  UpdatePendingOrderStatus(
                                    orderId: order.id,
                                    newStatus: 'Selesai',
                                  ),
                                );
                          },
                          icon: const Icon(Icons.check, color: AppColors.white),
                          label: const Text(
                            'Selesaikan Pesanan',
                            style: TextStyle(color: AppColors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
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
