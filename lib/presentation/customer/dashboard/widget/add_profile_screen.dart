import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shaftrent/core/components/buttons.dart';
import 'package:shaftrent/core/components/custom_text_field.dart';
import 'package:shaftrent/core/components/spaces.dart';
import 'package:shaftrent/core/constants/colors.dart';
import 'package:shaftrent/data/model/request/customer/profile_request_model.dart';
import 'package:shaftrent/data/model/response/customer/profile_response_model.dart';
import 'package:shaftrent/presentation/customer/dashboard/profile/bloc/profile_bloc.dart';
import 'package:shaftrent/presentation/customer/dashboard/profile/bloc/profile_event.dart';
import 'package:shaftrent/presentation/customer/dashboard/profile/bloc/profile_state.dart';

class AddProfileScreen extends StatefulWidget {
  final Profile? profile;

  const AddProfileScreen({super.key, this.profile});

  @override
  State<AddProfileScreen> createState() => _AddProfileScreenState();
}

class _AddProfileScreenState extends State<AddProfileScreen> {
  final _key = GlobalKey<FormState>();
  late TextEditingController namaController;
  late TextEditingController alamatController;
  late TextEditingController nomorIdentitasController;
  String? _selectedIdentitas;
  File? _imageFile;

  final List<String> _identitasOptions = ['KTP', 'SIM'];
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    namaController = TextEditingController(text: widget.profile?.nama);
    alamatController = TextEditingController(text: widget.profile?.alamat ?? '');
    nomorIdentitasController = TextEditingController(text: widget.profile?.nomorIdentitas ?? '');
    _selectedIdentitas = widget.profile?.identitas;
  }

  @override
  void dispose() {
    namaController.dispose();
    alamatController.dispose();
    nomorIdentitasController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    final picked = await _picker.pickImage(source: source, imageQuality: 70);
    if (picked != null) {
      setState(() {
        _imageFile = File(picked.path);
      });
    }
  }

  void _showImagePickerDialog() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(
                Icons.camera_alt_outlined,
                color: AppColors.primary,
              ),
              title: const Text("Ambil Foto dari Kamera"),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.photo_library_outlined,
                color: AppColors.primary,
              ),
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

  Future<String?> _imageToBase64(File? imageFile) async {
    if (imageFile == null) return null;
    try {
      final bytes = await imageFile.readAsBytes();
      return base64Encode(bytes);
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profil"),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      backgroundColor: AppColors.card,
      body: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileSuccess) {
            Navigator.of(context).pop(true);
          } else if (state is ProfileError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColors.red,
              ),
            );
          }
        },
        child: Form(
          key: _key,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            children: [
              GestureDetector(
                onTap: _showImagePickerDialog,
                child: Center(
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.primary.withOpacity(0.4),
                        width: 2,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: _imageFile != null
                          ? Image.file(
                              _imageFile!,
                              fit: BoxFit.cover,
                              width: 150,
                              height: 150,
                            )
                          : (widget.profile?.uploadIdentitas != null &&
                                  widget.profile!.uploadIdentitas!.isNotEmpty)
                              ? CachedNetworkImage(
                                  imageUrl: widget.profile!.uploadIdentitas!,
                                  fit: BoxFit.cover,
                                  width: 150,
                                  height: 150,
                                  placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  errorWidget: (context, url, error) => const Icon(
                                    Icons.broken_image,
                                    size: 50,
                                    color: AppColors.red,
                                  ),
                                )
                              : const Center(
                                  child: Icon(
                                    Icons.add_a_photo_outlined,
                                    size: 50,
                                    color: AppColors.grey,
                                  ),
                                ),
                    ),
                  ),
                ),
              ),
              const SpaceHeight(24),
              CustomTextField(
                controller: namaController,
                label: 'Nama',
                validator: 'Nama tidak boleh kosong',
                readOnly: true,
                prefixIcon: const Icon(
                  Icons.person_2_outlined,
                  color: AppColors.black,
                ),
                borderColor: AppColors.black,
                textColor: AppColors.black,
                labelColor: AppColors.black,
                showLabel: false,
              ),
              const SpaceHeight(16),
              CustomTextField(
                controller: alamatController,
                label: 'Alamat',
                validator: 'Alamat tidak boleh kosong',
                prefixIcon: const Icon(
                  Icons.location_on_outlined,
                  color: AppColors.black,
                ),
                borderColor: AppColors.black,
                textColor: AppColors.black,
                labelColor: AppColors.black,
                showLabel: false,
              ),
              const SpaceHeight(16),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Pilih Identitas',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
                value: _selectedIdentitas,
                items: _identitasOptions
                    .map((id) => DropdownMenuItem(value: id, child: Text(id)))
                    .toList(),
                onChanged: (val) => setState(() => _selectedIdentitas = val),
              ),
              const SpaceHeight(16),
              CustomTextField(
                controller: nomorIdentitasController,
                label: 'Nomor Identitas',
                validator: 'Nomor identitas tidak boleh kosong',
                keyboardType: TextInputType.number,
                prefixIcon: const Icon(
                  Icons.credit_card,
                  color: AppColors.black,
                ),
                borderColor: AppColors.black,
                textColor: AppColors.black,
                labelColor: AppColors.black,
                showLabel: false,
              ),
              const SpaceHeight(16),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(24),
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            final isLoading = state is ProfileLoading;
            return Button.filled(
              label: isLoading ? "Menyimpan..." : "Simpan",
              onPressed: isLoading
                  ? null
                  : () async {
                      if (_key.currentState!.validate()) {
                        final base64Image = await _imageToBase64(_imageFile);
                        final request = ProfileRequestModel(
                          alamat: alamatController.text.trim(),
                          jenisIdentitas: _selectedIdentitas ?? '',
                          nomorIdentitas: nomorIdentitasController.text.trim(),
                          uploadIdentitas: base64Image,
                        );
                        context.read<ProfileBloc>().add(
                          AddProfile(
                            customerId: widget.profile!.id,
                            requestModel: request,
                          ),
                        );
                      }
                    },
              color: AppColors.primary,
              textColor: Colors.white,
              height: 50,
              borderRadius: 12,
              fontSize: 16,
            );
          },
        ),
      ),
    );
  }
}
