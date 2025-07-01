import 'package:flutter/material.dart';
import 'package:shaft_rent/core/components/spaces.dart';
import 'package:shaft_rent/core/constants/colors.dart';
import 'package:shaft_rent/data/model/response/auth_response_model.dart';

class HomepageAdminScreen extends StatefulWidget {
  final User loggedInUser;
  const HomepageAdminScreen({super.key, required this.loggedInUser});

  @override
  State<HomepageAdminScreen> createState() => _HomepageAdminScreenState();
}

class _HomepageAdminScreenState extends State<HomepageAdminScreen> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const Center(child: Text('Car Screen')),
      const Center(child: Text('Chat Screen')),
      const Center(child: Text('Maps Screen')), 
      const Center(child: Text('Profile Screen')),
    ];

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
              child: pages[_currentPage],
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
        onTap: (index) {
          setState(() {
            _currentPage = index;
          });
        },
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