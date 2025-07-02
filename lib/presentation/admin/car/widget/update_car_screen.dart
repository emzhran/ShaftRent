import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shaft_rent/core/components/custom_text_field.dart';
import 'package:shaft_rent/core/components/spaces.dart';
import 'package:shaft_rent/core/constants/colors.dart';
import 'package:shaft_rent/data/model/response/car_response_model.dart';
import 'package:shaft_rent/presentation/admin/car/updatecar/updatecar_bloc.dart';
import 'package:shaft_rent/presentation/admin/car/updatecar/updatecar_state.dart';

class UpdateCarScreen extends StatefulWidget {
  final Car car;
  const UpdateCarScreen({super.key, required this.car});

  @override
  State<UpdateCarScreen> createState() => _UpdateCarScreenState();
}

class _UpdateCarScreenState extends State<UpdateCarScreen> {
  final _key = GlobalKey<FormState>();
  late TextEditingController merkMobilController;
  late TextEditingController namaMobilController;
  late TextEditingController jumlahKursiController;
  late TextEditingController jumlahMobilController;
  late TextEditingController hargaMobilController;
  String? _selectedTransmisi;
  File? _imageFile;

  final List<String> _transmisiOptions = ['Manual', 'Matic'];
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    merkMobilController = TextEditingController(text: widget.car.merkMobil);
    namaMobilController = TextEditingController(text: widget.car.namaMobil);
    jumlahKursiController = TextEditingController(text: widget.car.jumlahKursi.toString());
    jumlahMobilController = TextEditingController(text: widget.car.jumlahMobil.toString());
    hargaMobilController = TextEditingController(text: widget.car.hargaMobil.toString());
    _selectedTransmisi = widget.car.transmisi;
  }

  @override
  void dispose() {
    merkMobilController.dispose();
    namaMobilController.dispose();
    jumlahKursiController.dispose();
    jumlahMobilController.dispose();
    hargaMobilController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source, imageQuality: 70, maxWidth: 800);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void _showImagePickerDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt_outlined, color: AppColors.primary),
              title: const Text("Ambil Foto dari Kamera"),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_outlined, color: AppColors.primary),
              title: const Text("Pilih dari Galeri"),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<String?> _imageFileToBase64(File? imageFile) async {
    if (imageFile == null) return null;
    try {
      List<int> imageBytes = await imageFile.readAsBytes();
      return base64Encode(imageBytes);
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Mobil"),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      backgroundColor: AppColors.card,
      body: BlocConsumer<UpdateCarBloc, UpdateCarState>(
        listener: (context, state) {
          if (state is UpdateCarSuccess) {
            Navigator.of(context).pop(true);
          } else if (state is UpdateCarError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: AppColors.red)
            );
          }
        },
        builder: (context, state) {
          final isLoaded = state is UpdateCarLoaded;
          return Form(
            key: _key,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              children: [
                GestureDetector(
                  onTap: _showImagePickerDialog,
                  child: Container(
                    height: 180,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.primary.withOpacity(0.4)),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(12),
                      child: _imageFile != null
                          ? Image.file(_imageFile!, fit: BoxFit.cover, width: double.infinity)
                          : (widget.car.gambarmobil != null && widget.car.gambarmobil!.isNotEmpty
                              ? CachedNetworkImage(
                                  imageUrl: widget.car.gambarmobil!,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) => const Icon(Icons.broken_image, size: 50, color: Colors.red),
                                )
                              : const Center(
                                  child: Icon(Icons.image_outlined, size: 50, color: AppColors.grey),
                                )),
                    ),
                  ),
                ),
                const SpaceHeight(24),
                CustomTextField(
                  controller: merkMobilController,
                  label: 'Merk Mobil',
                  validator: 'Merk mobil tidak boleh kosong',
                  prefixIcon: const Icon(Icons.directions_car, color: AppColors.black),
                  borderColor: AppColors.black,
                  textColor: AppColors.black,
                  labelColor: AppColors.black,
                  showLabel: false,
                ),
                const SpaceHeight(16),
                CustomTextField(
                  controller: namaMobilController,
                  label: 'Nama Mobil',
                  validator: 'Nama mobil tidak boleh kosong',
                  prefixIcon: const Icon(Icons.directions_car_filled, color: AppColors.black),
                  borderColor: AppColors.black,
                  textColor: AppColors.black,
                  labelColor: AppColors.black,
                  showLabel: false,
                ),
              ],
            )
          );
        }
      ), 
    );
  }
}
