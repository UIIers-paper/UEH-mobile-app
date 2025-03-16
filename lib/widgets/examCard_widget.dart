import 'dart:math';
import 'package:flutter/material.dart';
import 'package:ueh_mobile_app/configs/routes.dart';

class ExamCard extends StatelessWidget {
  final String classId;
  final String classCodeName;
  final String className;
  final String dayTime;
  final bool isDownloaded;

  ExamCard({
    Key? key,
    required this.classId,
    required this.classCodeName,
    required this.className,
    required this.dayTime,
    this.isDownloaded = false,
  }) : super(key: key);


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
        onTap: () {
          Navigator.pushNamed(
            context,
            isDownloaded ? AppRoutes.examScreen : AppRoutes.examLoadScreen,
            arguments: classId,
          );
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
                top: 10,
                right: 10,
                child: Icon(
                  isDownloaded ? Icons.cloud_done : Icons.cloud_download,
                  color: isDownloaded ? Colors.green : Colors.grey,
                  size: 24,
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
