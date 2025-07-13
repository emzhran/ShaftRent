import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaftrent/core/components/spaces.dart';
import 'package:shaftrent/core/constants/colors.dart';
import 'package:shaftrent/data/model/response/auth_response_model.dart';
import 'package:shaftrent/presentation/customer/car_order/bloc/car_order_bloc.dart';
import 'package:shaftrent/presentation/customer/car_order/bloc/car_order_event.dart';
import 'package:shaftrent/presentation/customer/car_order/bloc/car_order_state.dart';
import 'package:shaftrent/presentation/customer/car_order/widget/order_car_screen.dart';

class CarScreenCustomer extends StatefulWidget {
  final User loggedInUser;
  const CarScreenCustomer({super.key, required this.loggedInUser});

  @override
  State<CarScreenCustomer> createState() => _CarScreenCustomerState();
}

class _CarScreenCustomerState extends State<CarScreenCustomer> {
  final TextEditingController _searchController = TextEditingController();
  String selectedTransmisi = 'Semua';
  String selectedHarga = 'Semua';
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    context.read<CarOrderBloc>().add(FetchCarsCustomer());

    _searchController.addListener(() {
      final text = _searchController.text.trim();
      setState(() {
        _isSearching = text.isNotEmpty;
      });

      if (text.isEmpty) {
        context.read<CarOrderBloc>().add(ResetSearchCustomer());
      } else {
        context.read<CarOrderBloc>().add(SearchCarsCustomer(keyword: text));
      }
    });
  }

  void _onFilterChanged() {
    context.read<CarOrderBloc>().add(
      FilterCarsCustomer(
        transmisi: selectedTransmisi == 'Semua' ? null : selectedTransmisi,
        sortByHarga: selectedHarga == 'Semua'
            ? null
            : selectedHarga == 'Terendah'
                ? 'asc'
                : 'desc',
      ),
    );
  }

  void _showFilterDialog() {
    String tempTransmisi = selectedTransmisi;
    String tempHarga = selectedHarga;

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) => Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Filter Mobil',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SpaceHeight(16),
                DropdownButtonFormField<String>(
                  value: tempTransmisi,
                  items: ['Semua', 'Matic', 'Manual']
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  decoration: const InputDecoration(
                    labelText: 'Transmisi',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => tempTransmisi = value);
                    }
                  },
                ),
                const SpaceHeight(12),
                DropdownButtonFormField<String>(
                  value: tempHarga,
                  items: ['Semua', 'Terendah', 'Tertinggi']
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  decoration: const InputDecoration(
                    labelText: 'Urut Harga',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => tempHarga = value);
                    }
                  },
                ),
                const SpaceHeight(16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      setState(() {
                        selectedTransmisi = tempTransmisi;
                        selectedHarga = tempHarga;
                      });
                      _onFilterChanged();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                    ),
                    child: const Text('Filter', style: TextStyle(color: AppColors.white)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.card,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Cari Mobil...',
                        hintStyle: const TextStyle(color: AppColors.grey),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: AppColors.white,
                        suffixIcon: _isSearching
                            ? IconButton(
                                icon: const Icon(Icons.close, color: AppColors.primary),
                                onPressed: () {
                                  _searchController.clear();
                                  FocusScope.of(context).unfocus();
                                  context.read<CarOrderBloc>().add(ResetSearchCustomer());
                                },
                              )
                            : null,
                      ),
                      style: const TextStyle(color: AppColors.black),
                    ),
                  ),
                ),
                const SpaceWidth(8),
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.filter_list, color: AppColors.black),
                    onPressed: _showFilterDialog,
                  ),
                ),
              ],
            ),
            const SpaceHeight(16),
            Expanded(
              child: BlocBuilder<CarOrderBloc, CarOrderState>(
                builder: (context, state) {
                  if (state is CarOrderLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is CarOrderLoadSuccess) {
                    final cars = state.filteredCars;
                    if (cars.isEmpty) {
                      return const Center(child: Text('Mobil tidak ditemukan.'));
                    }

                    return ListView.builder(
                      itemCount: cars.length,
                      itemBuilder: (context, index) {
                        final car = cars[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (car.gambarmobil != null && car.gambarmobil!.isNotEmpty)
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                      imageUrl: car.gambarmobil!,
                                      height: 150,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.image_not_supported),
                                    ),
                                  ),
                                const SpaceHeight(10),
                                Text(
                                  car.namaMobil,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SpaceHeight(6),
                                Text('${car.merkMobil} - ${car.transmisi}'),
                                const SpaceHeight(4),
                                Text('Harga: Rp${car.hargaMobil.toInt()}/hari'),
                                const SpaceHeight(4),
                                Text('Jumlah: ${car.jumlahMobil} unit'),
                                const SpaceHeight(4),
                                Text('Kapasitas: ${car.jumlahKursi} kursi'),
                                const SpaceHeight(8),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: ElevatedButton.icon(
                                    icon: const Icon(Icons.shopping_cart_outlined),
                                    label: const Text('Pesan'),
                                    onPressed: () {
                                      if (widget.loggedInUser.statusAkun?.toLowerCase() != 'terverifikasi') {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                            content: Text('Akun Anda belum terverifikasi. Silakan lengkapi data terlebih dahulu.'),
                                            backgroundColor: AppColors.red,
                                          ),
                                        );
                                      } else {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => OrderCarScreen(
                                              car: car,
                                              loggedInUser: widget.loggedInUser,
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.primary,
                                      foregroundColor: AppColors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
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

                  if (state is CarOrderError) {
                    return Center(child: Text(state.error));
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
