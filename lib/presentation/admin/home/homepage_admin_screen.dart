import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaft_rent_app/core/components/spaces.dart';
import 'package:shaft_rent_app/core/constants/colors.dart';
import 'package:shaft_rent_app/data/model/response/auth_response_model.dart';
import 'package:shaft_rent_app/presentation/admin/car/addcar/add_car_bloc.dart';
import 'package:shaft_rent_app/presentation/admin/car/addcar/add_car_event.dart';
import 'package:shaft_rent_app/presentation/admin/car/addcar/add_car_state.dart';
import 'package:shaft_rent_app/presentation/admin/car/widget/car_screen.dart';

class HomepageAdminScreen extends StatefulWidget {
  final User loggedInUser;
  const HomepageAdminScreen({super.key, required this.loggedInUser});

  @override
  State<HomepageAdminScreen> createState() => _HomepageAdminScreenState();
}

class _HomepageAdminScreenState extends State<HomepageAdminScreen> {
  int _currentPage = 0;
  final PageController _pageController = PageController();
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      BlocBuilder<AddCarBloc, AddCarState>(
        builder: (context, state) {
          if (state is AddCarLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AddCarLoaded) {
            return CarScreen(carsData: state.cars);
          } else if (state is AddCarError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return const Center(child: Text('Data belum dimuat.'));
          }
        },
      ),
      const Center(child: Text('chat screen')),
      const Center(child: Text('maps screen')),
      const Center(child: Text('profile screen')),
    ];
    context.read<AddCarBloc>().add(GetCarEvent());
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNavbarTap(int index) {
    setState(() {
      _currentPage = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
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
            decoration: const BoxDecoration(color: AppColors.primary),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/images/Shaft-CR.png',
                  width: 120,
                  height: 60,
                ),
                const SpaceHeight(5),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Selamat Datang, ${widget.loggedInUser.nama}',
                    style: const TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).padding.bottom,
              ),
              decoration: const BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                children: _pages,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.primary,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_car_filled_outlined),
            label: 'Mobil'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_outlined),
            label: 'Chat'
          ),BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            label: 'Maps'
          ),BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Pesan'
          ),
        ],
        currentIndex: _currentPage,
        selectedItemColor: AppColors.white,
        unselectedItemColor: AppColors.white.withOpacity(0.5),
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
