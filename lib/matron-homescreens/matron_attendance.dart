import 'package:flutter/material.dart';

void main() {
  runApp(AttendanceApp());
}

class AttendanceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Attendance System',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: RoomSelectionScreen(),
    );
  }
}

class RoomSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select a Room')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            roomButton(context, 'Room 1'),
            roomButton(context, 'Room 2'),
            roomButton(context, 'Room 3'),
          ],
        ),
      ),
    );
  }

  Widget roomButton(BuildContext context, String roomName) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AttendanceScreen(roomName: roomName),
          ),
        );
      },
      child: Text(roomName),
    );
  }
}

class AttendanceScreen extends StatefulWidget {
  final String roomName;

  AttendanceScreen({required this.roomName});

  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  List<String> students = ['Alice', 'Bob', 'Charlie', 'David', 'Eve'];
  Map<String, bool> attendance = {};

  @override
  void initState() {
    super.initState();
    for (var student in students) {
      attendance[student] = true;
    }
  }

  void toggleAttendance(String student) {
    setState(() {
      attendance[student] = !attendance[student]!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.roomName} - Attendance')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {
                String student = students[index];
                bool isPresent = attendance[student]!;
                return ListTile(
                  title: Text(student),
                  tileColor: isPresent ? Colors.green[100] : Colors.red[200],
                  onTap: () => toggleAttendance(student),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Attendance Confirmed for ${widget.roomName}')),
              );
            },
            child: Text('Confirm Attendance'),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
