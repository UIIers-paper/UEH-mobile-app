// import 'package:ueh_mobile_app/data/student_data.dart';
import 'package:ueh_mobile_app/utils/exports.dart';
import 'package:ueh_mobile_app/services/api_service.dart';
import 'package:ueh_mobile_app/screens/student/pages/exam_list_screen.dart';
import 'package:ueh_mobile_app/screens/student/pages/home_screen.dart';
import 'package:ueh_mobile_app/screens/student/pages/profile_screen.dart';
import 'package:ueh_mobile_app/screens/student/pages/schedule_screen.dart';
import 'package:ueh_mobile_app/providers/network_status_provider.dart';
import 'package:ueh_mobile_app/models/student_model.dart  ';

class Dashboard extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<Dashboard> {
  late List<Widget> _screens;
  final UserService userService = UserService();
  final NetworkService networkService = NetworkService();
  StreamSubscription<ConnectivityResult>? _subscription;
  bool isInternetConnected = true;
  bool _isLoading = true;
  StudentModel? _student;

  int _currentIndex = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  Widget _bodyContent = Center(child: CircularProgressIndicator());

  var response;

  @override
  void initState() {
    super.initState();
    _subscription= networkService.monitorNetwork().listen((ConnectivityResult result) {
      print("Connection monitor: $result");
      if (mounted) {
        setState(() {
          isInternetConnected = (result != ConnectivityResult.none);
          context.read<NetworkStatusProvider>().updateNetworkStatus(result != ConnectivityResult.none);

        });
      }
    });
    _initializeScreens();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final apiService = ApiService("${dotenv.env['API_URL']}/students/3122102001");
      final StudentModel studentData = await apiService.fetchData(((json) => StudentModel.fromJson(json)));
      setState(() {
        _student = studentData;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      print('Error: $e');
    }
  }

  void _initializeScreens() {
    _screens = [
      HomeScreen(),
      ScheduleScreen(),
      ExamListScreen(),
      ProfileScreen(),
    ];
    setState(() {
      _bodyContent = _screens[_currentIndex];
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
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
                backgroundImage: AssetImage(_student?.imageUrl ?? "student.imageUrl"),
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
                        _student?.name ?? "",
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
                    _student?.studentId ?? "",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
            SizedBox(width: 12),

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
              accountName: Text(_student?.name ?? ""),
              accountEmail: Text(_student?.studentId ?? ""),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage(_student?.imageUrl ?? ""),
              ),
            ),
            ListTile(
              title: Text('News'),
              onTap: () {
              },
            ),
            ListTile(
              title: Text('Schedule'),
              onTap: () {
              },
            ),
            ListTile(
              title: Text('Chat'),
              onTap: () {
              },
            ),
            ListTile(
              title: Text('Absent'),
              onTap: () {
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
        onTap: (index) async{
          var info= await userService.getDeviceInformation();
          printData(info);
          setState(() {
            _currentIndex = index;
            _bodyContent = _screens[_currentIndex];
          });
        },
      ),
    );
  }

  void printData(Map<String, dynamic> data) {
    data.forEach((key, value) {
      print('$key: $value');
    });
  }

}