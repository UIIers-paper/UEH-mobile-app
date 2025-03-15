import 'package:ueh_mobile_app/utils/exports.dart';
import 'package:ueh_mobile_app/widgets/profile_widget.dart';
import 'package:ueh_mobile_app/widgets/accountLinking_widget.dart';
// import 'package:ueh_mobile_app/data/student_data.dart';
import 'package:ueh_mobile_app/services/api_service.dart';
import 'package:ueh_mobile_app/models/student_model.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<ProfileScreen> {
  String selectedContent = "Profile";
  final TextEditingController _microsoftEmailController = TextEditingController();
  final TextEditingController _googleEmailController = TextEditingController();
  bool _isLoading = true;
  // late StudentModel student;
  StudentModel? _studentData;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final apiService = ApiService("${dotenv.env['API_URL']}/students/3122102001");
      final studentData = await apiService.fetchData(((json) => StudentModel.fromJson(json)));

      setState(() {
        _studentData = studentData;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      print('Error: $e');
    }
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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey[200],
                  child: CircleAvatar(
                    radius: 45,
                    backgroundImage: AssetImage(_studentData?.imageUrl ?? "null"),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  _studentData?.name ?? "null",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Student",
                  style: TextStyle(color: Colors.grey[600], fontSize: 16),
                ),
                SizedBox(height: 5),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    selectedContent = "Profile";
                  });
                },
                child: Text("Profile"),
                style: TextButton.styleFrom(
                  foregroundColor: selectedContent == "Profile" ? Colors.white : Colors.black,
                  backgroundColor: selectedContent == "Profile" ? Colors.black : Colors.transparent,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: BorderSide(color: Colors.black),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    selectedContent = "Account Linking";
                  });
                },
                child: Text("Account Linking"),
                style: TextButton.styleFrom(
                  foregroundColor: selectedContent == "Account Linking" ? Colors.white : Colors.black,
                  backgroundColor: selectedContent == "Account Linking" ? Colors.black : Colors.transparent,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: BorderSide(color: Colors.black),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    selectedContent = "Settings";
                  });
                },
                child: Text("Settings"),
                style: TextButton.styleFrom(
                  foregroundColor: selectedContent == "Settings" ? Colors.white : Colors.black,
                  backgroundColor: selectedContent == "Settings" ? Colors.black : Colors.transparent,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: BorderSide(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 5),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: switch (selectedContent) {
                  "Account Linking" => AccountLinkingContent(
                    microsoftEmailController: _microsoftEmailController,
                    googleEmailController: _googleEmailController,
                  ),
                  "Profile" => ProfileWidget(),
                  _ => Center(child: Text("Other content here.")),
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
