import 'dart:ui';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomePageContent extends StatefulWidget {
  const HomePageContent({super.key});

  @override
  State<HomePageContent> createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> with TickerProviderStateMixin {
  List<Map<String, dynamic>> customSpiderCatalog = [];
  final ImagePicker _picker = ImagePicker();
  AnimationController? _pulseController;
  AnimationController? _floatController;
  Animation<double>? _pulseAnimation;
  Animation<double>? _floatAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _floatController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _pulseController!, curve: Curves.easeInOut),
    );

    _floatAnimation = Tween<double>(begin: -5, end: 5).animate(
      CurvedAnimation(parent: _floatController!, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController?.dispose();
    _floatController?.dispose();
    super.dispose();
  }

  Future<void> _pickSpiderImageFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        customSpiderCatalog.add({
          'label': 'My Spider',
          'image': FileImage(File(image.path)),
        });
      });
    }
  }

  Future<void> _pickSpiderImageFromCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        customSpiderCatalog.add({
          'label': 'My Spider',
          'image': FileImage(File(image.path)),
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryPurple = Color(0xFF8E67C3);
    const Color secondaryPurple = Color(0xFFB794E8);
    const Color accentBlue = Color(0xFF4FC3F7);
    const Color darkNavy = Color(0xFF1E2536);
    const Color softGray = Color(0xFFF8F9FA);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            softGray,
            Colors.white,
            primaryPurple.withOpacity(0.05),
          ],
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            // Enhanced Translucent Header
            Container(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 18),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withOpacity(0.7),
                    Colors.white.withOpacity(0.4),
                  ],
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
                boxShadow: [
                  BoxShadow(
                    color: primaryPurple.withOpacity(0.1),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            AnimatedBuilder(
                              animation: _floatAnimation ?? const AlwaysStoppedAnimation(0.0),
                              builder: (context, child) {
                                return Transform.translate(
                                  offset: Offset(0, _floatAnimation?.value ?? 0),
                                  child: const Text(
                                    '🕷️',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(width: 10),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                    'Hello, Alex',
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: -0.5,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    'Spider Classification Master',
                                    style: TextStyle(
                                      color: primaryPurple.withOpacity(0.8),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Compact avatar
                      AnimatedBuilder(
                        animation: _pulseAnimation ?? const AlwaysStoppedAnimation(1.0),
                        builder: (context, child) {
                          return Transform.scale(
                            scale: _pulseAnimation?.value ?? 1.0,
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  colors: [primaryPurple, secondaryPurple],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: primaryPurple.withOpacity(0.3),
                                    blurRadius: 15,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: const CircleAvatar(
                                radius: 22,
                                backgroundColor: Colors.transparent,
                                child: Icon(Icons.person, color: Colors.white, size: 20),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Compact search bar
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: accentBlue.withOpacity(0.1),
                              blurRadius: 20,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.white.withOpacity(0.9),
                                    Colors.white.withOpacity(0.7),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.5),
                                  width: 1.5,
                                ),
                              ),
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: '🔍 Discover amazing spiders...',
                                  hintStyle: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 14,
                                  ),
                                  prefixIcon: Container(
                                    margin: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [primaryPurple, accentBlue],
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Icon(Icons.search, color: Colors.white, size: 18),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Fixed action buttons with proper centering
                      Row(
                        children: [
                          Expanded(
                            child: _buildCompactActionButton(
                              icon: Icons.photo_library_rounded,
                              label: 'Upload Photo',
                              subtitle: 'From Gallery',
                              onTap: _pickSpiderImageFromGallery,
                              gradient: [primaryPurple, secondaryPurple],
                              glowColor: primaryPurple,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildCompactActionButton(
                              icon: Icons.camera_alt_rounded,
                              label: 'Take Photo',
                              subtitle: 'Live Camera',
                              onTap: _pickSpiderImageFromCamera,
                              gradient: [accentBlue, const Color(0xFF29B6F6)],
                              glowColor: accentBlue,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // Compact Latest Classification section
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.white.withOpacity(0.9),
                              Colors.white.withOpacity(0.6),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.3),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: primaryPurple.withOpacity(0.08),
                              blurRadius: 15,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [primaryPurple.withOpacity(0.2), accentBlue.withOpacity(0.1)],
                                          ),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Icon(
                                          Icons.auto_awesome,
                                          color: primaryPurple,
                                          size: 20,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      const Flexible(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              'Latest Discovery',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black87,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              'Your recent classification',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [primaryPurple.withOpacity(0.1), accentBlue.withOpacity(0.1)],
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: IconButton(
                                    icon: Icon(Icons.arrow_forward_ios, color: primaryPurple, size: 16),
                                    onPressed: () {},
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),

                            // Compact classification result card
                            Container(
                              height: 160,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: const DecorationImage(
                                  image: AssetImage('assets/Image/bg.jpeg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.transparent,
                                      Colors.black.withOpacity(0.7),
                                    ],
                                  ),
                                ),
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Spacer(),
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: primaryPurple,
                                            borderRadius: BorderRadius.circular(16),
                                          ),
                                          child: const Text(
                                            'IDENTIFIED',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    const Text(
                                      'Jumping Spider',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Text(
                                      'Salticidae Family',
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        const Icon(Icons.psychology, color: Colors.white, size: 14),
                                        const SizedBox(width: 6),
                                        const Text('Confidence: ', style: TextStyle(color: Colors.white, fontSize: 12)),
                                        Expanded(
                                          child: Container(
                                            height: 4,
                                            margin: const EdgeInsets.symmetric(horizontal: 6),
                                            decoration: BoxDecoration(
                                              color: Colors.white30,
                                              borderRadius: BorderRadius.circular(2),
                                            ),
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: 80,
                                                  height: 4,
                                                  decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                      colors: [primaryPurple, accentBlue],
                                                    ),
                                                    borderRadius: BorderRadius.circular(2),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const Text('85%', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Compact Spider Catalog section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        primaryPurple.withOpacity(0.2),
                                        accentBlue.withOpacity(0.1),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Text('🕸️', style: TextStyle(fontSize: 16)),
                                ),
                                const SizedBox(width: 12),
                                const Flexible(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Spider Catalog',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        'Explore species',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [primaryPurple.withOpacity(0.1), accentBlue.withOpacity(0.05)],
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: TextButton.icon(
                              onPressed: () {},
                              icon: Icon(Icons.grid_view_rounded, color: primaryPurple, size: 16),
                              label: Text(
                                'View All',
                                style: TextStyle(
                                  color: primaryPurple,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Compact scrollable spider catalog
                      SizedBox(
                        height: 120,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          children: [
                            _buildCompactSpiderTile('Wolf Spider', const AssetImage('assets/Image/bg.jpeg')),
                            _buildCompactSpiderTile('Black Widow', const AssetImage('assets/Image/bg.jpeg')),
                            _buildCompactSpiderTile('Orb Weaver', const AssetImage('assets/Image/bg.jpeg')),
                            _buildCompactSpiderTile('Tarantula', const AssetImage('assets/Image/bg.jpeg')),
                            ...customSpiderCatalog.map((item) =>
                                _buildCompactSpiderTile(item['label'], item['image'])),
                          ],
                        ),
                      ),

                      const SizedBox(height: 60),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompactActionButton({
    required IconData icon,
    required String label,
    required String subtitle,
    required VoidCallback onTap,
    required List<Color> gradient,
    required Color glowColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: glowColor.withOpacity(0.25),
              blurRadius: 15,
              spreadRadius: 1,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    gradient[0].withOpacity(0.8),
                    gradient[1].withOpacity(0.6),
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.white.withOpacity(0.3),
                  width: 1.5,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(icon, color: Colors.white, size: 20),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      label,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCompactSpiderTile(String label, ImageProvider imageProvider) {
    return Container(
      width: 100,
      margin: const EdgeInsets.only(right: 12),
      child: GestureDetector(
        onTap: () => _showSpiderDetails(label, imageProvider),
        child: Column(
          children: [
            Container(
              height: 85,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.3),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 6,
                      right: 6,
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.zoom_in,
                          size: 12,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  void _showSpiderDetails(String label, ImageProvider imageProvider) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.75,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white,
                const Color(0xFF8E67C3).withOpacity(0.05),
              ],
            ),
          ),
          child: Column(
            children: [
              // Compact image section
              Expanded(
                flex: 3,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.6),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 16,
                        left: 16,
                        right: 16,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: const Color(0xFF8E67C3),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const Text(
                                'SPECIES INFO',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              label,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 12,
                        right: 12,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.close, color: Colors.white, size: 20),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Compact details section
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDetailRow('Common Name', label, Icons.label),
                      const SizedBox(height: 16),
                      _buildDetailRow('Scientific Name', 'Salticidae sp.', Icons.science),
                      const SizedBox(height: 16),
                      _buildDetailRow('Family', 'Jumping Spiders', Icons.family_restroom),
                      const Spacer(),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF8E67C3), Color(0xFF4FC3F7)],
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text(
                            'Learn More',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value, IconData icon) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: const Color(0xFF8E67C3).withOpacity(0.1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(icon, color: const Color(0xFF8E67C3), size: 14),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}