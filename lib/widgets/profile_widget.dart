import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:ueh_mobile_app/widgets/profileDetail_widget.dart';
import 'package:ueh_mobile_app/data/student_data.dart';

class ProfileWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              padding: EdgeInsets.all(6),
              child: Column(
                children: [
                  ProfileDetailItem(
                    icon: Icons.calendar_month,
                    title: "Ngày sinh",
                    value: student.birthdate,
                  ),
                  ProfileDetailItem(
                    icon: Icons.school,
                    title: "Major",
                    value: "Information Technology",
                  ),
                  ProfileDetailItem(
                    icon: Icons.book,
                    title: "Khóa",
                    value: student.course,
                  ),
                  ProfileDetailItem(
                    icon: Icons.email,
                    title: "Email",
                    value: student.email,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ProfileDetailItem(
                              icon: Icons.phone,
                              title: "Mobile",
                              value: student.phone,
                            ),
                            ProfileDetailItem(
                              icon: Icons.location_on,
                              title: "Nơi sinh",
                              value: student.address,
                            ),
                          ],
                        ),
                      ),
                      // QR Code
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.green,
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: QrImageView(
                          data: student.studentId,
                          version: QrVersions.auto,
                          size: 100,
                          gapless: false,
                          foregroundColor: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
