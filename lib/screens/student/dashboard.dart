import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:ueh_mobile_app/screens/student/pages/exam_screen.dart';
import 'package:ueh_mobile_app/screens/student/pages/home_screen.dart';
import 'package:ueh_mobile_app/screens/student/pages/profile_screen.dart';
import 'package:ueh_mobile_app/screens/student/pages/schedule_screen.dart';
import 'package:ueh_mobile_app/services/auth_service.dart';


// import 'package:ueh_mobile_app/models/students/homecontent.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();


}

class _DashboardScreenState extends State<Dashboard> {
  bool isLoading = true;
  late List<Widget> _screens;


  int _currentIndex = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  Widget _bodyContent = Center(child: CircularProgressIndicator());

  var response;

  @override
  void initState() {
    super.initState();
  }

  void _initializeScreens() {
    _screens = [
      HomeScreen(),
      ScheduleScreen(),
      ExamScreen(),
      ProfileScreen(),
    ];
    setState(() {
      _bodyContent = _screens[_currentIndex];
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Loading..."),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        elevation: 4,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  _currentIndex = 3;
                  _bodyContent = _screens[_currentIndex];
                });
              },
              child: CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage('assets/'),
              ),
            ),
            SizedBox(width: 12),
            Container(
              color: Colors.indigo,
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Hello",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xA0DAE4F5)),
                      ),
                      SizedBox(width: 8),
                      Icon(
                        Icons.check_circle,
                        size: 18,
                        color: Colors.green,
                      ),
                    ],
                  ),
                  Text(
                    "31221020226",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
            SizedBox(width: 12), // Use for spacing between widgets if needed

            Spacer(),
            Icon(Icons.notifications),

          ],
        ),
      ),
      body: _bodyContent,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.indigo,
              ),
              accountName: Text("Loc Dinh"),
              accountEmail: Text("31221020226"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/'),
              ),
            ),
            ListTile(
              title: Text('News'),
              onTap: () {
                // setState(() {
                //   _bodyContent = Log();
                // });
                // Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Schedule'),
              onTap: () {
                // setState(() {
                //   _bodyContent = Schedule();
                // });
                // Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Chat'),
              onTap: () {
                // setState(() {
                //   _bodyContent = Chat();
                // });
                // Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Absent'),
              onTap: () {
                // setState(() {
                //   _bodyContent = AbsentForm();
                // });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Logout'),
              onTap: () {
                Navigator.pop(context);
                AuthService().logout(context);
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        height: 60.0,
        index: _currentIndex,
        items: <Widget>[
          Icon(Icons.home, color: _currentIndex == 0 ? Colors.white : Color(0xA0DAE4F5), size: 35),
          Icon(Icons.class_, color: _currentIndex == 1 ? Colors.white : Color(0xA0DAE4F5), size: 35),
          Icon(Icons.bar_chart, color: _currentIndex == 2 ? Colors.white : Color(0xA0DAE4F5), size: 35),
          Icon(Icons.person, color: _currentIndex == 3 ? Colors.white : Color(0xA0DAE4F5), size: 35),
        ],
        color: Colors.indigo,
        buttonBackgroundColor: Colors.deepOrange,
        backgroundColor: Colors.transparent,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 300),
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            _bodyContent = _screens[_currentIndex];
          });
        },
      ),
    );
  }
}

