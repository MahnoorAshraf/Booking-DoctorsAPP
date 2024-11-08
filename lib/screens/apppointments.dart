import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../providers/loginprovider.dart';
import '../routes/routenames.dart';
import '../components/appcolors.dart';

class Appointment {
  final String firstName;
  final String lastName;
  final DateTime date;
  final String time;
  final String status;
  final String type;
  bool isCompleted;

  Appointment({
    required this.firstName,
    required this.lastName,
    required this.date,
    required this.time,
    required this.type,
    required this.status,
    this.isCompleted = false,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      firstName: json['f_name'].toString(),
      lastName: json['l_name'].toString(),
      date: DateTime.parse(json['date']),
      time: json['time'].toString(),
      type: json['type_of_appointment'].toString(),
      status: json['status'].toString(),
      isCompleted: json['status'].toString() == 'completed',
    );
  }
}

class AppointmentList extends StatefulWidget {
  @override
  _AppointmentListState createState() => _AppointmentListState();
}

class _AppointmentListState extends State<AppointmentList>
    with SingleTickerProviderStateMixin {
  List<Appointment> activeAppointments = [];
  List<Appointment> completedAppointments = [];
  bool isLoading = true;
  String errorMessage = '';

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadAppointments();
  }

void _markAsCompleted(int index) {
  setState(() {
    final appointment = activeAppointments[index];
    appointment.isCompleted = true;
    activeAppointments.removeAt(index);
    completedAppointments.add(appointment);
  });
}

void _markAsActive(int index) {
  setState(() {
    final appointment = completedAppointments.removeAt(index);
    appointment.isCompleted = false;
    activeAppointments.add(appointment);
  });
}


  Future<void> _loadAppointments() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token == null) {
      Navigator.pushReplacementNamed(context, Routenames.login);
      return;
    }

    try {
      final response = await http.get(
        Uri.parse('https://itjoblinks.com/franklin/public/api/appointments'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        List<dynamic> appointmentData;
        if (jsonData is List) {
          appointmentData = jsonData;
        } else if (jsonData is Map && jsonData.containsKey('appointments')) {
          appointmentData = jsonData['appointments'];
        } else {
          throw Exception('Appointments data is not in the expected format.');
        }

        setState(() {
          final appointments = appointmentData
              .map((json) => Appointment.fromJson(json))
              .toList();
          activeAppointments = appointments
              .where((appointment) => appointment.status != 'completed')
              .toList();
          completedAppointments = appointments
              .where((appointment) => appointment.status == 'completed')
              .toList();
          isLoading = false;
        });
      } else {
        throw Exception('Failed to fetch appointments: ${response.statusCode}');
      }
    } catch (error) {
      setState(() {
        errorMessage = 'Failed to load appointments: $error';
        isLoading = false;
      });
    }
  }

  String _formatTime(String timeString) {
    final parts = timeString.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);
    return DateFormat.jm().format(DateTime(2022, 1, 1, hour, minute));
  }

  void logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    Provider.of<LoginState>(context, listen: false).setToken('');
    Navigator.pushReplacementNamed(context, Routenames.bottomnavbar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.logoclr,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Center(
              child: Text(
                'Appointments',
                style: TextStyle(color: AppColors.whiteclr),
              ),
            ),
            SizedBox(width: 30),
            InkWell(
              onTap: () {
                logout(context);
              },
              child: Container(
                height: 30,
                width: 60,
                decoration: BoxDecoration(
                  color:AppColors.bgcolor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    'Logout',
                    style: GoogleFonts.poppins(fontSize: 10, color: Colors.black),
                  ),
                ),
              ),
            ),
          ],
        ),
        centerTitle: true,
        bottom: TabBar(
          labelColor: Colors.white,
          unselectedLabelStyle: GoogleFonts.poppins(fontSize: 15, color: Colors.black),
          labelStyle: GoogleFonts.poppins(fontSize: 18, color: Colors.white),
          indicatorColor:AppColors.blueclr,
          controller: _tabController,
          tabs: [
            Tab(text: 'Active'),
            Tab(text: 'Completed',),
          ],
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? Center(child: Text(errorMessage))
              : TabBarView(
                  controller: _tabController,
                  children: [
                    _buildAppointmentList(activeAppointments, 'No active appointments found.', false),
                    _buildAppointmentList(completedAppointments, 'No completed appointments found.', true),
                  ],
                ),
    );
  }

  Widget _buildAppointmentList(
      List<Appointment> appointments, String emptyMessage, bool isCompleted) {
    return appointments.isEmpty
        ? Center(child: Text(emptyMessage))
        : ListView.builder(
            itemCount: appointments.length,
            itemBuilder: (context, index) {
              final appointment = appointments[index];
              return AppointmentCard(
                index: index,
                firstName: appointment.firstName,
                lastName: appointment.lastName,
                date: appointment.date,
                time: appointment.time,
                type: appointment.type,
                isCompleted: appointment.isCompleted,
                onToggleCompleted: () {
                  if (isCompleted) {
                    _markAsActive(index);
                  } else {
                    _markAsCompleted(index);
                  }
                },
              );
            },
          );
  }
}

class AppointmentCard extends StatefulWidget {
  final int index;
  final String firstName;
  final String lastName;
  final DateTime date;
  final String time;
  final String type;
  final bool isCompleted;
  final VoidCallback onToggleCompleted;

  const AppointmentCard({
    Key? key,
    required this.index,
    required this.firstName,
    required this.lastName,
    required this.date,
    required this.time,
    required this.type,
    this.isCompleted = false,
    required this.onToggleCompleted,
  }) : super(key: key);

  @override
  State<AppointmentCard> createState() => _AppointmentCardState();
}

class _AppointmentCardState extends State<AppointmentCard> {
  bool _isDialogShowing = false;

  String _formatTime(String timeString) {
    final parts = timeString.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);
    return DateFormat.jm().format(DateTime(2022, 1, 1, hour, minute));
  }
Future<void> _showConfirmationDialog() async {
  final shouldMarkAsCompleted = await showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Verify Action"),
        content: Text('Are you sure you want to mark this as completed appointment?'),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop(false); // Return false on cancel
            },
          ),
          TextButton(
            child: Text('Confirm'),
            onPressed: () {
              Navigator.of(context).pop(true); // Return true on confirm
            },
          ),
        ],
      );
    },
  );

  if (shouldMarkAsCompleted ?? false) {
    widget.onToggleCompleted(); // Execute the callback to update the state
  }
}


  @override
  Widget build(BuildContext context) {
       final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10, top: 18),
      child: Column(
        children: [
          Center(
            child: Container(
              height:screenHeight * 0.3 ,
              // width: screenWidth* 1,
              decoration: BoxDecoration(
                color: AppColors.bgcolor,
                borderRadius: BorderRadius.circular(2),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Patient\'s Name: ',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          '${widget.firstName} ${widget.lastName}',
                          style: GoogleFonts.poppins(
                            fontSize: 17,
                            fontWeight: FontWeight.w200,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          color: AppColors.logoclr,
                          size: 18,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Date: ',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          DateFormat("MMM dd, yyyy").format(widget.date),
                          style: GoogleFonts.poppins(
                            fontSize: 17,
                            fontWeight: FontWeight.w200,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          color: AppColors.logoclr,
                          size: 20,
                        ),
                        SizedBox(width: 5),
                        Text(
                          'Time: ',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          _formatTime(widget.time),
                          style: GoogleFonts.poppins(
                            fontSize: 17,
                            fontWeight: FontWeight.w200,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 8),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Text(
                            'Appointment: ',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            widget.type,
                            style: GoogleFonts.poppins(
                              fontSize: 17,
                              fontWeight: FontWeight.w200,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, bottom: 8,top: 8),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: widget.isCompleted
                          ? Container(
                            height: screenHeight * 0.038,
                            width: screenWidth * 0.29,
                            decoration: BoxDecoration(color: Colors.green,borderRadius: BorderRadius.circular(5)),
                            child: Center(
                              child: Text(
                                'Completed',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w200,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                          : Row(
                              children: [
                                Checkbox(
                                  value: widget.isCompleted,
                                  onChanged: (value) {
                                    _showConfirmationDialog();
                                  },
                                ),
                                Text(
                                  'Mark as completed',
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w200,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}