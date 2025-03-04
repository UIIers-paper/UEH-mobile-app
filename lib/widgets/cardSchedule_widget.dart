import 'package:flutter/material.dart';
// import 'package:final_mobile_app/widgets/detailed_class.dart';
final List<IconData> icons = [
  Icons.book,
  Icons.science,
  Icons.computer,
  Icons.history,
  Icons.calculate,
  Icons.music_note,
  Icons.palette,
  Icons.language,
  Icons.sports_basketball,
  Icons.biotech,
];

Color getRandomColor(String subjectName, [List<Color>? colorPalette]) {
  final int hash = subjectName.runes.fold(0, (sum, char) => sum + char);
  final List<Color> palette = colorPalette ?? Colors.primaries;
  return palette[hash % palette.length];
}

IconData getRandomIcon(String subjectName, [List<IconData>? customIcons]) {
  final int hash = subjectName.runes.fold(0, (sum, char) => sum + char);
  final List<IconData> availableIcons = customIcons ?? icons;
  return availableIcons[hash % availableIcons.length];
}


Widget buildSubjectCard({
  required BuildContext context,
  required String subjectName,
  required String schoolTime,
  required String room,
  required String classId,
  int idx = 0,
  List<Color>? colorPalette,
  List<IconData>? customIcons,
  Function()? onTap, // Callback khi nhấn vào card
}) {
  return Card(
    margin: const EdgeInsets.only(bottom: 16.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16.0),
    ),
    elevation: 4,
    shadowColor: Colors.black.withOpacity(0.2),
    child: Ink(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            getRandomColor(subjectName, colorPalette).withOpacity(0.2),
            Colors.white,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 28,
          backgroundColor: getRandomColor(subjectName, colorPalette),
          child: Icon(
            getRandomIcon(subjectName, customIcons),
            color: Colors.white,
            size: 28,
          ),
        ),
        title: Text(
          subjectName,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.indigo,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8.0),
            Row(
              children: [
                const Icon(Icons.schedule, color: Colors.grey, size: 18),
                const SizedBox(width: 8.0),
                Text(
                  '$schoolTime AM/PM',
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                const Icon(Icons.location_on, color: Colors.grey, size: 18),
                const SizedBox(width: 8.0),
                Text(
                  room,
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ],
            ),
          ],
        ),
        trailing: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.indigo.withOpacity(0.1),
          ),
          child: const Icon(Icons.chevron_right, color: Colors.indigo),
        ),
        onTap: onTap ??
                () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => ClassDetailScreen(
              //       class_id: classId,
              //       subject: subjectName,
              //       time: schoolTime,
              //       location: room,
              //     ),
              //   ),
              // );
            },
      ),
    ),
  );
}

