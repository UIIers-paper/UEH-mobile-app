import 'dart:math'; // For generating random values
import 'package:flutter/material.dart';
// import 'package:final_mobile_app/widgets/detailed_class.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ExamCard extends StatelessWidget {
  final String classId;
  final String classCodeName;
  final String className;
  final String dayTime;
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  ExamCard({
    Key? key,
    required this.classId,
    required this.classCodeName,
    required this.className,
    required this.dayTime,
  }) : super(key: key);

  Future<int?> _getRole() async {
    final storedRole = await _storage.read(key: 'role');
    if (storedRole != null) {
      return int.tryParse(storedRole);
    }
    return null;
  }

  IconData _getRandomIcon() {
    final List<IconData> iconList = [
      Icons.book_rounded,
      Icons.school,
      Icons.assignment,
      Icons.dashboard,
      Icons.class_,
      Icons.computer,
      Icons.language,
      Icons.design_services,
      Icons.build,
    ];

    final random = Random();
    return iconList[random.nextInt(iconList.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: GestureDetector(
        onTap: () async {
          final intRole = await _getRole();
          if (intRole == 1) {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => ClassDetailScreen(
            //       class_id: classId,
            //       subject: className,
            //       time: dayTime,
            //       location: classCodeName,
            //     ),
            //   ),
            // );
          }
        },
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo.shade400, Colors.blue.shade700],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Stack(
            children: [
              Positioned(
                top: -10,
                right: -10,
                child: Icon(
                  Icons.circle,
                  size: 100,
                  color: Colors.white.withOpacity(0.1),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 6,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Icon(
                            _getRandomIcon(),
                            color: Colors.yellow.shade700,
                            size: 35,
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            className,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildPillText(classCodeName),
                        _buildPillRow(Icons.calendar_today, dayTime),
                      ],
                    ),
                    SizedBox(height: 16),
                    FutureBuilder<int?>(
                      future: _getRole(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasData && snapshot.data == 1) {
                          return Align(
                            alignment: Alignment.centerRight,
                            child: OutlinedButton(
                              onPressed: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => ClassDetailScreen(
                                //       class_id: classId,
                                //       subject: className,
                                //       time: dayTime,
                                //       location: classCodeName,
                                //     ),
                                //   ),
                                // );
                              },
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(color: Colors.lightBlueAccent, width: 2),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                backgroundColor: Colors.white70.withOpacity(0.1),
                                elevation: 4,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.visibility, color: Colors.white54, size: 18),
                                  SizedBox(width: 8),
                                  Text(
                                    'View Class',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                        return SizedBox.shrink();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPillText(String text) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.blue.shade700,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildPillRow(IconData icon, String text) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.blue.shade700),
          SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              color: Colors.blue.shade700,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
