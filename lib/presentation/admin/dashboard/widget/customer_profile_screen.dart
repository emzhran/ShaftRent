import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaftrent/core/constants/colors.dart';
import 'package:shaftrent/core/components/spaces.dart';
import 'package:shaftrent/data/model/request/admin/profile_customer_request_model.dart';
import 'package:shaftrent/data/model/response/admin/profile_customer_response_model.dart';
import 'package:shaftrent/presentation/admin/dashboard/customer_profile/bloc/customer_profile_bloc.dart';
import 'package:shaftrent/presentation/admin/dashboard/customer_profile/bloc/customer_profile_event.dart';
import 'package:shaftrent/presentation/admin/dashboard/customer_profile/bloc/customer_profile_state.dart';
import 'package:shaftrent/presentation/admin/dashboard/widget/customer_detail_screen.dart';

class CustomerProfileScreen extends StatefulWidget {
  const CustomerProfileScreen({super.key});

  @override
  State<CustomerProfileScreen> createState() => _CustomerProfileScreenState();
}

class _CustomerProfileScreenState extends State<CustomerProfileScreen> {
  final TextEditingController searchController = TextEditingController();
  List<ProfileCustomer> filteredCustomers = [];

  @override
  void initState() {
    super.initState();
    context.read<CustomerProfileBloc>().add(FetchAllCustomer());
  }

  void _runFilter(String enteredKeyword, List<ProfileCustomer> allCustomers) {
    final sortedCustomers = [...allCustomers]..sort((a, b) {
      if (a.status != b.status) {
        return a.status == 'Belum Terverifikasi' ? -1 : 1;
      }
      return a.nama!.toLowerCase().compareTo(b.nama!.toLowerCase());
    });
    setState(() {
      if (enteredKeyword.isEmpty) {
        filteredCustomers = sortedCustomers;
      } else {
        filteredCustomers = sortedCustomers
        .where((customer) => customer.nama!.toLowerCase().contains(enteredKeyword.toLowerCase()))
        .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Customer'),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
      ),
      backgroundColor: AppColors.card,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              onChanged: (value) {
                final state = context.read<CustomerProfileBloc>().state;
                if (state is CustomerProfileLoaded) {
                  _runFilter(value, state.profile);
                }
              },
              decoration: InputDecoration(
                hintText: 'Cari nama customer...',
                filled: true,
                fillColor: AppColors.white,
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SpaceHeight(16),
            Expanded(
              child: BlocListener<CustomerProfileBloc, CustomerProfileState>(
                listener: (context, state) {
                  if (state is UpdateStatusSuccess) {
                    context.read<CustomerProfileBloc>().add(FetchAllCustomer());
                  } else if (state is UpdateStatusError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)),
                    );
                  } else if (state is CustomerDetailLoaded) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CustomerDetailScreen(profile: state.profile),
                      ),
                    ).then((_) {
                      context.read<CustomerProfileBloc>().add(FetchAllCustomer());
                    });
                  }
                },
                child: BlocBuilder<CustomerProfileBloc, CustomerProfileState>(
                  builder: (context, state) {
                    if (state is CustomerProfileLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is CustomerProfileLoaded) {
                      final sortedCustomers = [...state.profile]..sort((a, b) {
                        if (a.status != b.status) {
                          return a.status == 'Belum Terverifikasi' ? -1 : 1;
                        }
                        return a.nama!.toLowerCase().compareTo(b.nama!.toLowerCase());
                      });
                      if (filteredCustomers.isEmpty &&
                          searchController.text.isEmpty) {
                        filteredCustomers = sortedCustomers;
                      }
                      if (filteredCustomers.isEmpty) {
                        return const Center(child: Text('Customer Tidak ditemukan.'));
                      }
                      return ListView.builder(
                        itemCount: filteredCustomers.length,
                        itemBuilder: (context, index) {
                          final profile = filteredCustomers[index];
                          final isVerified = profile.status == 'Terverifikasi';
                          final isComplete = profile.nomorIdentitas != null && profile.nomorIdentitas!.isNotEmpty &&
                          profile.identitas != null && profile.identitas!.isNotEmpty && profile.uploadIdentitas != null &&
                          profile.uploadIdentitas!.isNotEmpty;
                          return Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  context.read<CustomerProfileBloc>().add(
                                    FetchCustomerDetail(customerId: profile.id),
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: const EdgeInsets.all(12),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.person_outline,
                                          color: AppColors.primary),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              profile.nama!,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              profile.status!,
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: isVerified
                                                    ? AppColors.primary
                                                    : AppColors.grey,
                                              ),
                                            ),
                                            if (!isComplete && !isVerified)
                                              const Text(
                                                'Data belum lengkap',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: AppColors.red,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                      if (!isVerified && isComplete)
                                        SizedBox(
                                          height: 32,
                                          child: ElevatedButton.icon(
                                            icon: const Icon(
                                              Icons.verified_outlined,
                                              size: 16,
                                              color: AppColors.white,
                                            ),
                                            label: const Text(
                                              'Verifikasi',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: AppColors.white,
                                              ),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 12,
                                                vertical: 8,
                                              ),
                                              backgroundColor: AppColors.primary,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                            onPressed: () {
                                              context.read<CustomerProfileBloc>().add(
                                                SubmitUpdateStatus(
                                                  requestModel:
                                                      StatusAccountRequestModel(
                                                    customerId:
                                                        profile.user!.id
                                                            .toString(),
                                                    status: 'Terverifikasi',
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                              if (index < filteredCustomers.length - 1)
                                const SpaceHeight(12),
                            ],
                          );
                        },
                      );
                    }
                    if (state is UpdateStatusError) {
                      return Center(child: Text(state.message));
                    }
                    return const SizedBox();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
