import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaftrent/core/components/spaces.dart';
import 'package:shaftrent/core/constants/colors.dart';
import 'package:shaftrent/data/model/response/auth_response_model.dart';
import 'package:shaftrent/data/model/response/car_response_model.dart';
import 'package:shaftrent/data/model/request/customer/order_car_request_model.dart';
import 'package:shaftrent/presentation/customer/car_order/bloc/car_order_bloc.dart';
import 'package:shaftrent/presentation/customer/car_order/bloc/car_order_event.dart';
import 'package:shaftrent/presentation/customer/car_order/bloc/car_order_state.dart';
import 'package:shaftrent/presentation/customer/car_order/widget/order_success_screen.dart';

class OrderCarScreen extends StatefulWidget {
  final Car car;
  final User loggedInUser;

  const OrderCarScreen({
    super.key,
    required this.car,
    required this.loggedInUser,
  });

  @override
  State<OrderCarScreen> createState() => _OrderCarScreenState();
}

class _OrderCarScreenState extends State<OrderCarScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _tanggalMulaiController = TextEditingController();
  final TextEditingController _tanggalSelesaiController = TextEditingController();

  String? _metodePembayaran;
  int _totalHari = 0;
  int _totalHarga = 0;

  @override
  void dispose() {
    _tanggalMulaiController.dispose();
    _tanggalSelesaiController.dispose();
    super.dispose();
  }

  Future<void> _selectTanggal(
    BuildContext context,
    TextEditingController controller, {
    DateTime? firstDate,
    DateTime? initialDate,
    required bool isMulai,
  }) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: firstDate ?? DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (picked != null) {
      final pickedStr = picked.toIso8601String().split('T')[0];

      if (isMulai) {
        final endDate = DateTime.tryParse(_tanggalSelesaiController.text);
        if (endDate != null && picked.isAfter(endDate)) {
          setState(() {
            _tanggalMulaiController.clear();
            _tanggalSelesaiController.clear();
            _totalHari = 0;
            _totalHarga = 0;
          });

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Tanggal mulai tidak boleh setelah tanggal selesai.\nSilakan pilih ulang.',
                style: TextStyle(color: AppColors.white),
              ),
              backgroundColor: AppColors.red,
            ),
          );
          return;
        }
        _tanggalMulaiController.text = pickedStr;
      } else {
        _tanggalSelesaiController.text = pickedStr;
      }

      _hitungTotalHarga();
    }
  }

  void _hitungTotalHarga() {
    final start = DateTime.tryParse(_tanggalMulaiController.text);
    final end = DateTime.tryParse(_tanggalSelesaiController.text);
    if (start != null && end != null && !end.isBefore(start)) {
      setState(() {
        _totalHari = end.difference(start).inDays;
        _totalHarga = _totalHari * widget.car.hargaMobil.toInt();
      });
    } else {
      setState(() {
        _totalHari = 0;
        _totalHarga = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final car = widget.car;
    final user = widget.loggedInUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Pemesanan'),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SpaceHeight(8),
              const Text('Nama Pemesan:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.primary)),
              Text(user.nama ?? '', style: const TextStyle(fontSize: 16)),
              const SpaceHeight(16),
              const Text('Merk Mobil:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.primary)),
              Text(car.merkMobil, style: const TextStyle(fontSize: 16)),
              const SpaceHeight(16),
              const Text('Nama Mobil:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.primary)),
              Text(car.namaMobil, style: const TextStyle(fontSize: 16)),
              const Text('Nomor Kendaraan:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.primary)),
              Text(car.namaMobil, style: const TextStyle(fontSize: 16)),
              const SpaceHeight(16),
              const Text('Transmisi:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.primary)),
              Text(car.transmisi, style: const TextStyle(fontSize: 16)),
              const SpaceHeight(16),
              const Text('Harga:',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.primary)),
              Text('Rp${car.hargaMobil.toInt()}/hari', style: const TextStyle(fontSize: 16)),
              const SpaceHeight(24),
              GestureDetector(
                onTap: () {
                  _selectTanggal(
                    context,
                    _tanggalMulaiController,
                    isMulai: true,
                  );
                },
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: _tanggalMulaiController,
                    decoration: InputDecoration(
                      labelText: 'Tanggal Mulai',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      prefixIcon: const Icon(Icons.calendar_today),
                    ),
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Tanggal mulai wajib diisi' : null,
                  ),
                ),
              ),
              const SpaceHeight(16),
              GestureDetector(
                onTap: () {
                  final mulai = DateTime.tryParse(_tanggalMulaiController.text);
                  _selectTanggal(
                    context,
                    _tanggalSelesaiController,
                    firstDate: mulai ?? DateTime.now(),
                    initialDate: mulai ?? DateTime.now(),
                    isMulai: false,
                  );
                },
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: _tanggalSelesaiController,
                    decoration: InputDecoration(
                      labelText: 'Tanggal Selesai',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      prefixIcon: const Icon(Icons.calendar_today),
                    ),
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Tanggal selesai wajib diisi' : null,
                  ),
                ),
              ),
              const SpaceHeight(16),
              if (_totalHari > 0) ...[
                const Text('Lama Sewa:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.primary)),
                Text('$_totalHari hari', style: const TextStyle(fontSize: 16)),
                const SpaceHeight(8),
                const Text('Total Harga:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.primary)),
                Text('Rp$_totalHarga', style: const TextStyle(fontSize: 16)),
                const SpaceHeight(16),
              ],
              DropdownButtonFormField<String>(
                value: _metodePembayaran,
                decoration: InputDecoration(
                  labelText: 'Metode Pembayaran',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                items: [
                  DropdownMenuItem(
                    value: 'BRIVA',
                    child: Row(
                      children: [
                        Image.asset('assets/images/bri-virtual-logo.png', width: 24, height: 24),
                        const SpaceWidth(10),
                        const Text('BRIVA'),
                      ],
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'BNI',
                    child: Row(
                      children: [
                        Image.asset('assets/images/bni-virtual-logo.jpg', width: 24, height: 24),
                        const SpaceWidth(10),
                        const Text('BNI'),
                      ],
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'BCA',
                    child: Row(
                      children: [
                        Image.asset('assets/images/bca-virtual-logo.jpg', width: 24, height: 24),
                        const SpaceWidth(10),
                        const Text('BCA'),
                      ],
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'QRIS',
                    child: Row(
                      children: [
                        Image.asset('assets/images/qris-logo.png', width: 24, height: 24),
                        const SpaceWidth(10),
                        const Text('QRIS'),
                      ],
                    ),
                  ),
                ],
                onChanged: (value) => setState(() => _metodePembayaran = value),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Pilih metode pembayaran' : null,
              ),
              const SpaceHeight(24),
              BlocConsumer<CarOrderBloc, CarOrderState>(
                listener: (context, state) {
                if (state is CarOrderSuccess) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => OrderSuccessScreen(
                        namaPemesan: user.nama ?? '-',
                        namaMobil: car.namaMobil,
                        nomorKendaraan: car.nomorKendaraan,
                        tanggalMulai: _tanggalMulaiController.text,
                        tanggalSelesai: _tanggalSelesaiController.text,
                        metodePembayaran: _metodePembayaran!,
                        totalHarga: _totalHarga,
                        user: user,
                      ),
                    ),
                  );
                } else if (state is CarOrderError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Gagal memesan: ${state.error}'),
                      backgroundColor: AppColors.red,
                    ),
                  );
                }
              },
                builder: (context, state) {
                  final isLoading = state is CarOrderLoading;
                  return SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: isLoading
                          ? null
                          : () {
                              if (_formKey.currentState!.validate()) {
                                final request = OrderCarRequestModel(
                                  carId: car.id,
                                  tanggalMulai: _tanggalMulaiController.text,
                                  tanggalSelesai: _tanggalSelesaiController.text,
                                  metodePembayaran: _metodePembayaran!,
                                );
                                context.read<CarOrderBloc>().add(OrderCarSubmitted(request: request));
                              }
                            },
                      child: Text(
                        isLoading ? 'Memesan...' : 'Pesan Sekarang',
                        style: const TextStyle(fontSize: 16, color: AppColors.white),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
