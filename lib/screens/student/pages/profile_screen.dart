import 'package:ueh_mobile_app/utils/exports.dart';
import 'package:ueh_mobile_app/widgets/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:ueh_mobile_app/widgets/account_linking.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<ProfileScreen> {
  String selectedContent = "Profile";
  final TextEditingController _microsoftEmailController = TextEditingController();
  final TextEditingController _googleEmailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                    backgroundImage: AssetImage("assets/images/profile.png"),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Loc Tan Dinh",
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
