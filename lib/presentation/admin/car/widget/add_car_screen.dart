import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shaftrent/core/components/custom_text_field.dart';
import 'package:shaftrent/core/components/spaces.dart';
import 'package:shaftrent/core/constants/colors.dart';

class AddCarScreen extends StatefulWidget {
  const AddCarScreen({super.key});

  @override
  State<AddCarScreen> createState() => _AddCarScreenState();
}

class _AddCarScreenState extends State<AddCarScreen> {
  final _key = GlobalKey<FormState>();
  final merkMobilController = TextEditingController();
  final namaMobilController = TextEditingController();
  final jumlahKursiController = TextEditingController();
  final jumlahMobilController = TextEditingController();
  final hargaMobilController = TextEditingController();
  String? _selectedTransmisi;
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  final List<String> _transmisiOptions = ['Manual', 'Matic'];

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
    try {
      final pickedFile = await _picker.pickImage(source: source, imageQuality: 70, maxWidth: 800);
      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gagal memilih gambar: $e"), backgroundColor: AppColors.red),
      );
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
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gagal mengonversi gambar: $e"), backgroundColor: AppColors.red),
      );
      return null;
    }
  }
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Mobil'),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.of(context).pop()
        ), 
      ),
      backgroundColor: AppColors.card,
      body: Form(
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
                  border: Border.all(color: AppColors.primary)
                ),
                child: _imageFile != null
                    ? ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.file(_imageFile!, fit: BoxFit.cover),
                    )
                    : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add_a_photo_outlined, size: 50, color: AppColors.grey),
                          SpaceHeight(8),
                          Text('Pilih Gambar Mobil')
                        ],
                      ),
                    )
              ),
            ),
            SpaceHeight(24),
            CustomTextField(
              controller: merkMobilController, 
              label: 'Merk Mobil',
              showLabel: false,
              validator: 'Merk Mobil tidak boleh kosong',
              textColor: AppColors.black,
              labelColor: AppColors.black,
              borderColor: AppColors.black,
              prefixIcon: const Icon(Icons.airport_shuttle_rounded, color: AppColors.black)
            ),
            SpaceHeight(16),
            CustomTextField(
              controller: namaMobilController, 
              label: 'Nama Mobil',
              showLabel: false,
              validator: 'Nama Mobil tidak boleh kosong',
              textColor: AppColors.black,
              labelColor: AppColors.black,
              borderColor: AppColors.black,
              prefixIcon: const Icon(Icons.directions_car_filled_rounded, color: AppColors.black)
            ),
            SpaceHeight(16),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Jenis Transmisi',
                labelStyle: TextStyle(color: AppColors.black),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              value: _selectedTransmisi,
              hint: const Text('Pilih Transmisi', style: TextStyle(color: AppColors.black)),
              items: _transmisiOptions.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() => _selectedTransmisi = newValue);
              },
            ),
            SpaceHeight(16),
            CustomTextField(
              controller: jumlahKursiController,
              label: "Jumlah Kursi",
              validator: 'Jumlah kursi tidak boleh kosong',
              showLabel: false,
              textColor: AppColors.black,
              borderColor: AppColors.black,
              labelColor: AppColors.black,
              keyboardType: TextInputType.number,
              prefixIcon: const Icon(Icons.event_seat_rounded, color: AppColors.black),
            ),
            SpaceHeight(16),
            CustomTextField(
              controller: jumlahMobilController,
              label: "Jumlah Mobil",
              validator: 'Jumlah mobil tidak boleh kosong',
              showLabel: false,
              textColor: AppColors.black,
              borderColor: AppColors.black,
              labelColor: AppColors.black,
              keyboardType: TextInputType.number,
              prefixIcon: const Icon(Icons.car_rental, color: AppColors.black),
            ),
            SpaceHeight(16),
            CustomTextField(
              controller: hargaMobilController,
              label: "Harga Sewa (Rp)",
              validator: 'Harga sewa tidak boleh kosong',
              showLabel: false,
              textColor: AppColors.black,
              borderColor: AppColors.black,
              labelColor: AppColors.black,
              keyboardType: TextInputType.number,
              prefixIcon: const Icon(Icons.account_balance_wallet_outlined, color: AppColors.black),
            ),
          ],
        )
      ),
    );
  }
}