import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ueh_mobile_app/models/exam_model.dart';
import 'package:ueh_mobile_app/widgets/cardSchedule.dart';
import 'package:ueh_mobile_app/data/exam_data.dart';
class ScheduleScreen extends StatefulWidget {
  @override
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<ScheduleScreen> {
  // final djangoService = DjangoService();
  int selectedDayIndex = 1;
  bool isLoading = true;
  List<DateTime> weekDates = [];
  List<ExamModel> scheduleData = mockExams;
  List<IconData> myCustomIcons = [
    Icons.book,
    Icons.science,
    Icons.computer,
    Icons.history,
  ];
  List<Color> myCustomPalette = [
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.pink,
  ];


  @override
  void initState() {
    super.initState();
    _initializeWeekDates();
    fetchAllData();
  }

  Color getRandomColor(String subjectName) {
    final int hash = subjectName.runes.fold(0, (sum, char) => sum + char);
    return Colors.primaries[hash % Colors.primaries.length];
  }


  Future<void> fetchAllData() async {
    try {
      await Future.wait([
        _fetchSchedule(),
      ]);
    } catch (e) {
      print('Error fetching data: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }


  Future<void> _fetchSchedule() async {
    try {
      print('Fetching schedule...');
      // var response = await djangoService.getRequest('/school/schedule');
      setState(() {
        DateTime monday = weekDates.first;
        DateTime sunday = weekDates.last;
        print('Monday: $monday');
        print('Sunday: $sunday');
        print('Schedule Data: $scheduleData');
        scheduleData = scheduleData.where((item) {
          DateTime sessionDate = DateTime.parse(item.date);
          print('Session Date: $sessionDate');
          return sessionDate.isAfter(monday.subtract(Duration(days: 1))) &&
              sessionDate.isBefore(sunday.add(Duration(days: 1)));
        }).toList();
        print('Number of sessions after filtering: ${scheduleData.length}');
        if (scheduleData.isEmpty) {
          print('No sessions found for the current week.');
        }
        scheduleData.sort((a, b) => DateTime.parse(a.date).compareTo(DateTime.parse(b.date)));
      });
      print('Sorted Schedule Data: $scheduleData');
    } catch (e) {
      print('Error fetching schedule: $e');
    }
  }



  void _initializeWeekDates() {
    DateTime now = DateTime.now();
    int currentWeekday = now.weekday;
    DateTime monday = now.subtract(Duration(days: currentWeekday - 1));

    weekDates = List.generate(7, (index) => monday.add(Duration(days: index)));

    selectedDayIndex = now.weekday;
  }

  String _formatTime(String time) {
    try {
      final timeParts = time.split(':');
      if (timeParts.length >= 2) {
        return '${timeParts[0]}:${timeParts[1]}';
      }
    } catch (e) {
      debugPrint('Error formatting time: $e');
    }
    return time;
  }

  @override
  Widget build(BuildContext context) {
    if (weekDates.isEmpty || isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    final dailySchedule = scheduleData.where((item) =>
    DateTime
        .parse(item.date)
        .weekday == selectedDayIndex).toList();

    Map<String, List<ExamModel>> classes = {};
    for (var item in dailySchedule) {
      if (!classes.containsKey(item.examId)) {
        classes[item.examId] = [];
      }
      classes[item.examId]!.add(item);
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(7, (index) {
              DateTime date = weekDates[index];
              String dayName = DateFormat('EEE').format(date);
              String dayNumber = DateFormat('dd').format(date);

              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedDayIndex = index + 1;
                  });
                },
                child: Column(
                  children: [
                    Text(
                      dayName,
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 8),
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: index + 1 == selectedDayIndex ? Colors
                          .indigo : Colors.transparent,
                      child: Text(
                        dayNumber,
                        style: TextStyle(
                          color: index + 1 == selectedDayIndex
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
        Expanded(
          child: dailySchedule.isEmpty
              ? Center(child: Text("Không có lớp học nào trong ngày này"))
              : ListView.builder(
            padding: EdgeInsets.all(16.0),
            itemCount: classes.length,
            itemBuilder: (context, index) {
              String classObj = classes.keys.toList()[index];
              var classSchedule = classes[classObj];

              String scheduleTime = classSchedule != null && classSchedule.isNotEmpty
                  ? classSchedule[0].startTime
                  : "Không có giờ học";

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      '${_formatTime(scheduleTime)} AM',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo
                      ),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: classSchedule!.length,
                    itemBuilder: (context, idx) {
                      final item = classSchedule[idx];
                      return buildSubjectCard(
                        context: context,
                        subjectName:  item.courseName!,
                        schoolTime: item.startTime!,
                        room: item.duration.toString()!,
                        classId: item.examId.toString()!,
                        idx: idx,
                        colorPalette: myCustomPalette,
                        customIcons: myCustomIcons,

                      );

                    },
                  ),
                ],
              );
            },
          ),
        ),

      ],
    );
  }
}