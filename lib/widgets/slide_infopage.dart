import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SlideInfoPage extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;

  const SlideInfoPage({
    Key? key,
    required this.title,
    required this.description,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          // Blue overlay
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.8,
            left: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: GoogleFonts.lora(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFDBCBAD),
                    letterSpacing: 1.2,
                    shadows: [
                      Shadow(
                        blurRadius: 12.0,
                        color: Colors.black.withOpacity(0.6),
                        offset: Offset(4.0, 4.0),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 5),
                Text(
                  description,
                  style: GoogleFonts.roboto(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                    color: Color(0xFFDBCBAD),
                    fontStyle: FontStyle.italic,
                    height: 1.6,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
