import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:test22/spider_catalog_page.dart';
import 'package:test22/home_page_content.dart';
import 'package:test22/profile_page.dart';
import 'package:test22/spider_inventory.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNavBarTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryPurple = Color(0xFF8E67C3);
    const Color darkNavy = Color(0xFF1E2536);
    const Color lightBackground = Color(0xFFEEEAF3);

    return Scaffold(
      backgroundColor: lightBackground,
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: [
          const HomePageContent(),
          SpiderInventory(),
          SpiderCatalogPage(),
          const ProfilePage(),
        ],
      ),
      floatingActionButton: _buildFabNavigator(darkNavy, primaryPurple),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildFabNavigator(Color darkNavy, Color primaryPurple) {
    double itemWidth = 70;
    double barWidth = itemWidth * 4;

    return SizedBox(
      height: 60,
      width: barWidth,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  color: darkNavy.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            left: _selectedIndex * itemWidth + 8,
            top: 6,
            child: Container(
              width: itemWidth - 16,
              height: 48,
              decoration: BoxDecoration(
                color: primaryPurple.withOpacity(0.75),
                borderRadius: BorderRadius.circular(24),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildFabNavItem(0, Icons.home_rounded),
              _buildFabNavItem(1, Icons.inventory_rounded),
              _buildFabNavItem(2, Icons.favorite),
              _buildFabNavItem(3, Icons.person),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFabNavItem(int index, IconData icon) {
    final bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => _onNavBarTapped(index),
      child: SizedBox(
        width: 70,
        height: 60,
        child: Icon(
          icon,
          color: isSelected ? Colors.white : Colors.white70,
          size: 22,
        ),
      ),
    );
  }
}
