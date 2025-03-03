import 'package:ueh_mobile_app/utils/exports.dart';
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
        Navigator.pushReplacementNamed(context, AppRoutes.authHome);
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
                imageUrl : 'assets/images/slide1.png',
              ),
              SlideInfoPage(
                title: 'Innovation Culture',
                description: 'World-leading technology infrastructure and research.',
                imageUrl : 'assets/images/slide2.png',
              ),
              SlideInfoPage(
                title: 'Contact us!',
                description: 'Call 1800-123-456 for more details..',
                imageUrl : 'assets/images/slide3.png',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

