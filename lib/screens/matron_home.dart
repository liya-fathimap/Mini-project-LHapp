import 'dart:convert';
import 'package:app/matron-homescreens/matron_attendance.dart';
import 'package:app/matron-homescreens/matron_complaint.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MatronHomePage extends StatefulWidget {
  final String matronName;
  final String matronRegNo;
  final String matronImage;

  const MatronHomePage({Key? key, required this.matronName, required this.matronRegNo, required this.matronImage}) : super(key: key);

  @override
  _MatronHomePageState createState() => _MatronHomePageState();
}

class _MatronHomePageState extends State<MatronHomePage> {
  List _complaints = [];

  void _fetchComplaints() async {
    var url = Uri.parse("http://localhost:3000/complaints/Matron");
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List complaints = jsonDecode(response.body);
      setState(() {
        _complaints = complaints;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchComplaints();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD), // Off-White/Beige
      appBar: AppBar(
        title: Text("Matron Dashboard"),
        backgroundColor: const Color(0xFF1E1E1E), // Dark Charcoal
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(widget.matronImage), // Matron Image
              backgroundColor: Colors.grey.shade200,
            ),
            const SizedBox(height: 10),
            Text(
              "Hi, ${widget.matronName}!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF1E1E1E)),
            ),
            const SizedBox(height: 5),
            Text(
              widget.matronRegNo,
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            const SizedBox(height: 30),
            GridView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1, 
                childAspectRatio: 4, 
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
              ),
              children: [
                buildComplaintTile(context),
                buildAttendanceTile(context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildComplaintTile(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ComplaintListScreen(complaints: _complaints)),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFC8E3C7), width: 2), 
          color: const Color(0xFFEAF4E2), 
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.feedback, size: 40, color: const Color(0xFFF65A38)), 
            const SizedBox(height: 10),
            Text(
              "View Complaints",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1E1E1E)), 
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAttendanceTile(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AttendanceApp()),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFC8E3C7), width: 2), 
          color: const Color(0xFFEAF4E2), 
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.checklist, size: 40, color: const Color(0xFF4CAF50)), 
            const SizedBox(height: 10),
            Text(
              "Mark Attendance",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1E1E1E)), 
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
