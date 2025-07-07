import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
    return const Placeholder();
  }
}