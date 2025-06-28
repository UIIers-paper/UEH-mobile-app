import 'dart:math';
import 'package:flutter/material.dart';
import 'package:ueh_mobile_app/utils/exports.dart';
// import 'package:ueh_mobile_app/configs/routes.dart';
import 'package:ueh_mobile_app/screens/student/pages/exam_loading_screen.dart';
import 'package:ueh_mobile_app/screens/student/pages/exam_screen.dart';
import 'package:ueh_mobile_app/services/api_service.dart';

class ExamCard extends StatelessWidget {
  final int examId;
  final String classId;
  final String classCodeName;
  final String className;
  final String dayTime;
  final bool isDownloaded;

  ExamCard({
    Key? key,
    required this.examId,
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
        onTap: () async {
          String? studentId;
          String? password;
          bool isAuthenticated = false;
          Map<String, dynamic>? result;

          await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              final idController = TextEditingController();
              final passwordController = TextEditingController();
              final formKey = GlobalKey<FormState>();

              return AlertDialog(
                title: Text('Xác thực sinh viên'),
                content: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: idController,
                        decoration: InputDecoration(labelText: 'Mã số sinh viên'),
                        validator: (value) =>
                        value == null || value.isEmpty ? 'Không được để trống' : null,
                      ),
                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(labelText: 'Mật khẩu'),
                        validator: (value) =>
                        value == null || value.isEmpty ? 'Không được để trống' : null,
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('Hủy'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        studentId = idController.text.trim();
                        password = passwordController.text.trim();

                        final apiService = ApiService('${dotenv.env['SERVER_URL']}/api/DeThi/access');

                        try {
                          result = await apiService.getWithQueryParams<Map<String, dynamic>>(
                            {
                              'LuotThiId': examId.toString(),
                              'Mssv': studentId!,
                              'Password': password!,
                            },
                                (json) => json,
                          );
                          isAuthenticated = true;
                          Navigator.of(context).pop();
                        } catch (e) {
                          print('Lỗi xác thực: $e');
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Sai thông tin đăng nhập hoặc lỗi kết nối')),
                          );
                        }
                      }
                    },
                    child: Text('Xác nhận'),
                  ),
                ],
              );
            },
          );

          if (isAuthenticated) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => isDownloaded
                    ? ExamScreen()
                    : ExamLoadingScreen(
                  examId: examId,
                  examData: {
                    'content': result!['content'],
                    'questionNums': result!['questionNums'],
                  },
                ),
              ),
            );
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
