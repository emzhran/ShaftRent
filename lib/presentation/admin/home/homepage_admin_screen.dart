import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaft_rent/core/components/spaces.dart';
import 'package:shaft_rent/core/constants/colors.dart';
import 'package:shaft_rent/data/model/response/auth_response_model.dart';
import 'package:shaft_rent/presentation/admin/car/getcar/getcar_bloc.dart';
import 'package:shaft_rent/presentation/admin/car/getcar/getcar_event.dart';
import 'package:shaft_rent/presentation/admin/car/getcar/getcar_state.dart';
import 'package:shaft_rent/presentation/admin/car/widget/car_screen.dart';
import 'package:shaft_rent/presentation/admin/maps/getmaps/getmaps_bloc.dart';
import 'package:shaft_rent/presentation/admin/maps/getmaps/getmaps_event.dart';
import 'package:shaft_rent/presentation/admin/maps/getmaps/getmaps_state.dart';
import 'package:shaft_rent/presentation/admin/maps/widget/maps_screen.dart';

class HomepageAdminScreen extends StatefulWidget {
  final User loggedInUser;
  const HomepageAdminScreen({super.key, required this.loggedInUser});

  @override
  State<HomepageAdminScreen> createState() => _HomepageAdminScreenState();
}

class _HomepageAdminScreenState extends State<HomepageAdminScreen> {
  int _currentPage = 0;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GetCarBloc>().add(FetchCars());
    });
  }

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
      if (index == 0) {
        Future.delayed(Duration(milliseconds: 200), () {
          if (mounted) {
            context.read<GetCarBloc>().add(FetchCars());
          }
        });
      } else if (index == 2) {
        Future.delayed(Duration(milliseconds: 100), () {
          if(mounted) {
            context.read<GetMapsBloc>().add(FetchMaps());
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      BlocBuilder<GetCarBloc, GetCarState>(
        builder: (context, state) {
          if (state is GetCarLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetCarLoaded) {
            return CarScreen();
          } else if (state is GetCarError) {
            return Center(child: Text('Error memuat data mobil: ${state.message}'));
          } else {
            return const Center(child: Text('Memuat data mobil...'));
          }
        },
      ),
      const Center(child: Text('Chat Screen')),
      BlocBuilder<GetMapsBloc, GetMapsState>(
        builder: (context, state) {
          if (state is GetMapsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetMapsLoaded) {
            return const MapsScreen();
          } else if (state is GetMapsError) {
            return Center(child: Text('Gagal memuat data maps: ${state.message}'));
          } else {
            return const Center(child: Text('Memuat maps...'));
          }
        },
      ),
      const Center(child: Text('Profile Screen')),
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
            decoration: const BoxDecoration(color: AppColors.primary),
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
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            child: Container(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).padding.bottom,
              ),
              decoration: const BoxDecoration(
                color: AppColors.card,
              ),
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                  context.read<GetCarBloc>().add(FetchCars());
                },
                children: pages,
              ),
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
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            label: 'Maps'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profil'
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