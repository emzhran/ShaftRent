import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaftrent/core/components/spaces.dart';
import 'package:shaftrent/core/constants/colors.dart';
import 'package:shaftrent/data/model/response/customer/profile_response_model.dart';
import 'package:shaftrent/presentation/customer/dashboard/profile/bloc/profile_bloc.dart';
import 'package:shaftrent/presentation/customer/dashboard/profile/bloc/profile_event.dart';
import 'package:shaftrent/presentation/customer/dashboard/profile/bloc/profile_state.dart';
import 'package:shaftrent/presentation/customer/dashboard/widget/add_profile_screen.dart';

class DashboardCustomerScreen extends StatefulWidget {
  const DashboardCustomerScreen({super.key});

  @override
  State<DashboardCustomerScreen> createState() => _DashboardCustomerScreenState();
}

class _DashboardCustomerScreenState extends State<DashboardCustomerScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(FetchProfile());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.card,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Dashboard',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                if (state is ProfileLoaded) {
                  final status = state.profile.user?.statusAkun;
                  final isVerified = status == 'Terverifikasi';
                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      'Status Akun: $status',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: isVerified ? AppColors.primary : AppColors.red,
                      ),
                    ),
                  );
                } else if (state is ProfileLoading) {
                  return const Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Text(
                      'Status Akun: Memuat...',
                      style: TextStyle( color: AppColors.primary,fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
            const SpaceHeight(20),
            BlocConsumer<ProfileBloc, ProfileState>(
              listener: (context, state) {},
              builder: (context, state) {
                bool shouldShowWarning = false;
                if (state is ProfileLoaded) {
                  final profile = state.profile;
                  shouldShowWarning = profile.identitas == null;
                } else if (state is ProfileEmpty) {
                  shouldShowWarning = true;
                }
                return shouldShowWarning
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.red.withOpacity(0.1),
                            border: Border.all(color: AppColors.red),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            'Lengkapi profil anda untuk memesan',
                            style: TextStyle(
                              color: AppColors.red,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      )
                    : const SizedBox.shrink();
              },
            ),
            BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                Profile? profile;
                if (state is ProfileLoaded) {
                  profile = state.profile;
                }
                return Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        leading: const Icon(Icons.person_outline, color: AppColors.primary),
                        title: const Text('Profil', style: TextStyle(fontSize: 16)),
                        onTap: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AddProfileScreen(profile: profile),
                            ),
                          );
                          if (result == true) {
                            context.read<ProfileBloc>().add(FetchProfile());
                          }
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        leading: Icon(Icons.lock_outline, color: AppColors.primary),
                        title: Text('Ganti Password', style: TextStyle(fontSize: 16)),
                        onTap: () {
                          //navigasi halaman ganti password (progress)
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        leading: Icon(Icons.chat_outlined, color: AppColors.primary),
                        title: Text('Chat dengan Admin', style: TextStyle(fontSize: 16)),
                        onTap: () {
                           //navigasi halaman chat admin (progress)
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
