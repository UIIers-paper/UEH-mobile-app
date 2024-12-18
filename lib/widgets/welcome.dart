import 'package:flutter/material.dart';
import 'dart:async';
import 'slide_infopage.dart';
class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 10), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/auth_home');
      }
    });
    _pageController = PageController();
    _startSlideShow();

  }

  void _startSlideShow() {
    Timer.periodic(Duration(seconds: 3), (timer) {
      if (_pageController.hasClients) {
        int nextPage = (_pageController.page?.toInt() ?? 0) + 1;
        if (nextPage >= 3) nextPage = 0;
        _pageController.animateToPage(nextPage,
            duration: Duration(milliseconds: 600), curve: Curves.ease);
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: Colors.brown,
            ),
          ),
          PageView(
            controller: _pageController,
            children: [
              SlideInfoPage(
                title: 'Loc Tan University',
                description: 'Achieved top 1 in the world, Q1 index from Springer.',
                imageUrl:
                'https://keystoneacademic-res.cloudinary.com/image/upload/f_auto/q_auto/g_auto/c_fill/w_1280/element/22/221027_220418_cover_photo-Postgraduate-Centre-2022-15.jpg',
              ),
              SlideInfoPage(
                title: 'Innovation Culture',
                description: 'World-leading technology infrastructure and research.',
                imageUrl:
                'https://wp-media.petersons.com/blog/wp-content/uploads/2018/02/10125127/iStock-680834800.jpg',
              ),
              SlideInfoPage(
                title: 'Contact us!',
                description: 'Call 1800-123-456 for more details..',
                imageUrl:
                'https://drascoedu.com/wp-content/uploads/2022/01/most-beautiful-campuses-oxford-university.webp',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

