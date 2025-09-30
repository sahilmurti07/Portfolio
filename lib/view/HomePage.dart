import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_web/core/app_theme.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:portfolio_web/core/widgets/card.dart';
import 'package:portfolio_web/model/projectModel.dart';
import 'package:url_launcher/url_launcher.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  // Constants
  static const double _mobileBreakpoint = 768;
  static const String _cvUrl = 'https://drive.google.com/file/d/1GAtCuDKmlO8vfvsXilPHl4exJJZSfL_8/view?usp=drive_link';
  static const List<String> _skills = [
    "Dart, Flutter, C#, Python, SQL",
    "Supabase, Firebase, REST APIs, Git",
    "State Management: Bloc",
    "Interests: Cloud, AI, Data Analytics",
  ];

  // State
  bool get isMobile => MediaQuery.of(context).size.width < _mobileBreakpoint;
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      drawer: isMobile ? _buildDrawer() : null,
      body: _buildBody(),
    );
  }

  // Main Body
  Widget _buildBody() {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Column(
        children: [
          _buildHeroSection(),
          _buildAboutSection(),
          _buildProjectsSection(),
          _buildContactSection(),
        ],
      ),
    );
  }

  // App Bar
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: const Color(0xFF121212),
      title: Padding(
        padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 60),
        child: Row(
          children: [
            Text('Sahil Murti', style: Theme.of(context).appBarTheme.titleTextStyle),
            if (!isMobile) ..._buildNavItems(),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildNavItems() {
    final items = [
      ("About", 800.0),
      ("Projects", 1300.0),
      ("Contact", 2400.0),
    ];

    return [
      const Spacer(),
      ...items.expand((item) => [
        _navItem(item.$1, item.$2),
        const SizedBox(width: 20),
      ]).take(items.length * 2 - 1),
    ];
  }

  Widget _navItem(String title, double offset) {
    return GestureDetector(
      onTap: () => _scrollToSection(offset),
      child: Text(title, style: Theme.of(context).textTheme.bodyLarge),
    );
  }

  // Drawer
  Drawer _buildDrawer() {
    return Drawer(
      backgroundColor: const Color(0xFF121212),
      child: Column(
        children: [
          const SizedBox(height: 60),
          ...["About", "Projects", "Contact"].asMap().entries.map(
            (entry) => ListTile(
              title: Text(entry.value, style: Theme.of(context).textTheme.bodyLarge),
              onTap: () => _handleDrawerNavigation(entry.key),
            ),
          ),
        ],
      ),
    );
  }

  // Hero Section
  Widget _buildHeroSection() {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: _buildGradientDecoration(
        center: const Alignment(1, -0.3),
        colors: [
          AppTheme.primaryColor.withOpacity(0.3),
          const Color(0xFF121212).withOpacity(0.8),
          const Color(0xFF121212),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(isMobile ? 20 : 80),
        child: isMobile ? _buildMobileHero() : _buildDesktopHero(),
      ),
    );
  }

  Widget _buildMobileHero() {
    return _buildAnimatedColumn(
      children: [
        _buildHeroImage(),
        const SizedBox(height: 40),
        _buildHeroContent(isMobile: true),
      ],
    );
  }

  Widget _buildDesktopHero() {
    return Row(
      children: [
        Expanded(child: _buildAnimatedColumn(children: [_buildHeroContent()])),
        Expanded(child: _buildAnimatedImage(_buildHeroImage())),
      ],
    );
  }

  // About Section
  Widget _buildAboutSection() {
    return Container(
      padding: EdgeInsets.all(isMobile ? 20 : 80),
      decoration: _buildGradientDecoration(
        center: const Alignment(-0.8, 0.3),
        colors: [
          AppTheme.primaryColor.withOpacity(0.2),
          const Color(0xFF1E1E1E).withOpacity(0.9),
          const Color(0xFF1E1E1E),
        ],
      ),
      child: Column(
        children: [
          _buildSectionTitle("About Me"),
          const SizedBox(height: 40),
          Row(
            children: [
              if (!isMobile) ...[
                Expanded(child: _buildProfileImage()),
                const SizedBox(width: 40),
              ],
              Expanded(flex: 2, child: _buildAboutContent()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAboutContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "I'm Sahil Murti, a Flutter developer passionate about building modern, responsive, and user-friendly apps. I enjoy turning ideas into real-world projects and constantly improving my skills in app development and emerging technologies.",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 20),
        ..._skills.map(_buildSkillItem),
      ],
    );
  }

  Widget _buildSkillItem(String skill) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: AppTheme.primaryColor),
          const SizedBox(width: 12),
          Text(skill, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }

  // Projects Section
  Widget _buildProjectsSection() {
    return Container(
      padding: EdgeInsets.all(isMobile ? 20 : 80),
      decoration: _buildGradientDecoration(
        center: const Alignment(0.8, -0.2),
        colors: [
          AppTheme.primaryColor.withOpacity(0.15),
          const Color(0xFF121212).withOpacity(0.7),
          const Color(0xFF121212),
        ],
      ),
      child: Column(
        children: [
          _buildSectionTitle("My Projects"),
          const SizedBox(height: 40),
          _buildProjectsGrid(),
        ],
      ),
    );
  }

  Widget _buildProjectsGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isMobile ? 1 : 3,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: 1.2,
      ),
      itemCount: projects.length,
      itemBuilder: (context, index) => CustomCard(project: projects[index]),
    );
  }

  // Contact Section
  Widget _buildContactSection() {
    return Container(
      padding: EdgeInsets.all(isMobile ? 20 : 80),
      decoration: _buildGradientDecoration(
        center: const Alignment(-0.8, 0.2),
        colors: [
          AppTheme.primaryColor.withOpacity(0.25),
          const Color(0xFF1E1E1E).withOpacity(0.8),
          const Color(0xFF1E1E1E),
        ],
      ),
      child: Column(
        children: [
          _buildSectionTitle("Get In Touch"),
          const SizedBox(height: 40),
          _buildContactItems(),
          const SizedBox(height: 40),
          _buildDownloadButton(),
        ],
      ),
    );
  }

  Widget _buildContactItems() {
    final contacts = [
      (Icons.email, "Email", "sahilmurti18@gmail.com"),
      (Icons.phone, "Phone", "7669948561"),
      (Icons.location_on, "Location", "Saharanpur, India"),
      (Icons.import_contacts, "Resume", "Download"),
    ];

    if (isMobile) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: contacts.take(2).map((c) => _contactItem(c.$1, c.$2, c.$3)).toList(),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: contacts.skip(2).map((c) => _contactItem(c.$1, c.$2, c.$3)).toList(),
          ),
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: contacts.map((c) => _contactItem(c.$1, c.$2, c.$3)).toList(),
    );
  }

  // Helper Widgets
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: isMobile ? 32 : 48,
        fontWeight: FontWeight.bold,
        color: AppTheme.primaryColor,
      ),
    );
  }

  Widget _buildAnimatedColumn({required List<Widget> children}) {
    return AnimationLimiter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: AnimationConfiguration.toStaggeredList(
          duration: const Duration(milliseconds: 600),
          childAnimationBuilder: (widget) => SlideAnimation(
            horizontalOffset: -50.0,
            child: FadeInAnimation(child: widget),
          ),
          children: children,
        ),
      ),
    );
  }

  Widget _buildAnimatedImage(Widget child) {
    return AnimationConfiguration.synchronized(
      duration: const Duration(milliseconds: 800),
      child: SlideAnimation(
        horizontalOffset: 50.0,
        child: FadeInAnimation(child: child),
      ),
    );
  }

  BoxDecoration _buildGradientDecoration({
    required Alignment center,
    required List<Color> colors,
  }) {
    return BoxDecoration(
      gradient: RadialGradient(
        center: center,
        radius: 1.5,
        colors: colors,
      ),
    );
  }

  Widget _buildProfileImage() {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Icon(Icons.person, size: 100, color: Colors.white),
    );
  }

  Widget _buildHeroImage() {
    return Container(
      height: isMobile ? 250 : 400,
      width: isMobile ? 250 : 400,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).cardTheme.color,
      ),
      child: Center(
        child: Image.asset("assets/images/portfolio.png", fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildHeroContent({bool isMobile = false}) {
    return Column(
      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          "HELLO!",
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontSize: isMobile ? 24 : null,
          ),
        ),
        const SizedBox(height: 16),
        Text.rich(
          TextSpan(
            text: "I'M ",
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontSize: isMobile ? 24 : null,
            ),
            children: [
              TextSpan(
                text: "SAHIL MURTI",
                style: GoogleFonts.poppins(
                  textStyle: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: AppTheme.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: isMobile ? 28 : null,
                  ),
                ),
              ),
            ],
          ),
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
        ),
        const SizedBox(height: 16),
        Text(
          "FLUTTER DEVELOPER",
          style: GoogleFonts.anton(
            fontSize: isMobile ? 28 : 42,
            color: Colors.white,
          ),
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
        ),
        const SizedBox(height: 24),
        _buildHireButton(),
      ],
    );
  }

  Widget _buildHireButton() {
    return Container(
      width: 150,
      height: 50,
      decoration: BoxDecoration(
        color: AppTheme.primaryColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          "Hire Me",
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ),
    );
  }

  Widget _buildDownloadButton() {
    return GestureDetector(
      onTap: _downloadCV,
      child: Container(
        width: 200,
        height: 50,
        decoration: BoxDecoration(
          color: AppTheme.primaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            "Download CV",
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
      ),
    );
  }

  Widget _contactItem(IconData icon, String title, String subtitle) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, size: isMobile ? 30 : 40, color: AppTheme.primaryColor),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: isMobile ? 14 : 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: isMobile ? 10 : 12,
              color: Colors.grey[300],
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  // Event Handlers
  void _scrollToSection(double offset) {
    _scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
    );
  }

  void _handleDrawerNavigation(int index) {
    Navigator.pop(context);
    _scrollToSection((index + 1) * 800.0);
  }

  void _downloadCV() async {
    final uri = Uri.parse(_cvUrl);
    if (!await launchUrl(uri)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not download CV')),
        );
      }
    }
  }
}