import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaftrent/core/components/spaces.dart';
import 'package:shaftrent/core/constants/colors.dart';
import 'package:shaftrent/data/model/response/auth_response_model.dart';
import 'package:shaftrent/presentation/auth/widget/login_screen.dart';
import 'package:shaftrent/presentation/customer/car_order/widget/car_screen_customer.dart';
import 'package:shaftrent/presentation/customer/dashboard/widget/dashboard_customer_screen.dart';
import 'package:shaftrent/presentation/customer/history_order/widget/history_order_screen.dart';
import 'package:shaftrent/presentation/customer/maps_customer/bloc/maps_customer_bloc.dart';
import 'package:shaftrent/presentation/customer/maps_customer/bloc/maps_customer_event.dart';
import 'package:shaftrent/presentation/customer/maps_customer/widget/maps_customer_screen.dart';

class HomepageCustomerScreen extends StatefulWidget {
  final User loggedInUser;
  const HomepageCustomerScreen({super.key, required this.loggedInUser});

  @override
  State<HomepageCustomerScreen> createState() => _HomepageCustomerScreenState();
}

class _HomepageCustomerScreenState extends State<HomepageCustomerScreen> {
  int _currentPage = 0;
  final PageController _pageController = PageController();
  bool isDarkMode = false;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNavbarTap(int index) {
    if (_currentPage != index) {
      setState(() {
        _currentPage = index;
      });
      _pageController.jumpToPage(index);
      if (index == 2) {
        Future.delayed(const Duration(milliseconds: 100), () {
          if (mounted) {
            context.read<MapsCustomerBloc>().add(GetMaps());
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      CarScreenCustomer(loggedInUser: widget.loggedInUser),
      const HistoryOrderScreen(),
      const MapsCustomerScreen(),
      const DashboardCustomerScreen(),
    ];
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(
              left: 24,
              right: 24,
              top: MediaQuery.of(context).padding.top,
              bottom: 18,
            ),
            width: double.infinity,
            decoration: BoxDecoration(
              color: isDarkMode ? AppColors.blackMenu : AppColors.primary,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/images/Shaft-CR.png',
                  width: 120,
                  height: 60,
                  errorBuilder: (context, error, stackTrace) =>
                      const SizedBox(width: 50, height: 30, child: Icon(Icons.info_outline, color: AppColors.grey)),
                ),
                const SpaceHeight(5),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'Selamat Datang, ${widget.loggedInUser.nama}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              isDarkMode ? Icons.wb_sunny_outlined : Icons.nightlight_round_outlined,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                isDarkMode = !isDarkMode;
                              });
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.logout_outlined, color: Colors.white),
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => const LoginScreen()),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              child: Container(
                color: isDarkMode ? AppColors.blackMenu : AppColors.card,
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                    if (index == 2) {
                      context.read<MapsCustomerBloc>().add(GetMaps());
                    }
                  },
                  children: pages,
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: isDarkMode ? AppColors.blackMenu : AppColors.primary,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.directions_car_filled_outlined), label: 'Mobil'),
          BottomNavigationBarItem(icon: Icon(Icons.history_outlined), label: 'Riwayat'),
          BottomNavigationBarItem(icon: Icon(Icons.map_outlined), label: 'Maps'),
          BottomNavigationBarItem(icon: Icon(Icons.dashboard_outlined), label: 'Dashboard'),
        ],
        currentIndex: _currentPage,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(0.5),
        onTap: _onNavbarTap,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: false,
        showSelectedLabels: true,
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 0,
          height: 0,
        ),
        elevation: 8.0,
      ),
    );
  }
}
