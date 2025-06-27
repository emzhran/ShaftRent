import 'package:flutter/material.dart';
import 'package:shaft_rent_app/core/components/spaces.dart';
import 'package:shaft_rent_app/core/constants/colors.dart';
import 'package:shaft_rent_app/data/model/response/auth_response_model.dart';

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
    _pages = [
      const Center(child: Text('car screen')),
      const Center(child: Text('chat screen')),
      const Center(child: Text('maps screen')),
      const Center(child: Text('profile screen')),
    ];
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
              bottom: 18
            ),
            width: double.infinity,
            decoration: const BoxDecoration(
              color: AppColors.primary
            ),
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
                      fontSize: 20
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
