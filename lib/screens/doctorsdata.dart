import 'dart:convert';
import 'package:clientwork/components/appcolors.dart';
import 'package:clientwork/routes/routenames.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

import '../components/textstyles.dart';
import 'doctordetailspage.dart';

class doctorsdata extends StatefulWidget {
  const doctorsdata({super.key});

  @override
  State<doctorsdata> createState() => _NewScreenState();
}

class _NewScreenState extends State<doctorsdata> {
  var apiUrl = 'https://itjoblinks.com/franklin/public/api/doctors/list';
  Future<List<dynamic>> getDoctors() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      return json.decode(response.body)["data"];
    } else {
      throw Exception('Failed to load doctors');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor:AppColors.bgcolor,
        appBar: AppBar(
            backgroundColor:AppColors.logoclr,
            title: Text('Our Doctors', style: TextStyle(color: Colors.white)),
            centerTitle: true,
            leading: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, Routenames.bottomnavbar);
                },
                child: Icon(Icons.arrow_back_ios_new, color: Colors.white))),
        body: FutureBuilder(
          future: getDoctors(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              List<dynamic> doctors = snapshot.data!;
              return ListView.builder(
                itemCount: doctors.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 6.0, bottom: 6, left: 8, right: 8),
                        child: Container(
                          height: screenHeight * 0.15,
                          width: screenWidth,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          child: ListTile(
                           
                            leading: Icon(
                              FontAwesomeIcons.user,
                              color:AppColors.logoclr,
                            ),
                            title: Text(
                              doctors[index]['name'],
                              style: AppWidget.TextFieldstyle(),
                            ),
                            subtitle: Text(
                              doctors[index]['designation'],
                              style: AppWidget.BoldTextFieldstyle(),
                            ),
                            trailing: Container(
                                height: screenHeight * 0.053,
                                width: screenWidth * 0.25,
                                decoration: BoxDecoration(
                                    color:AppColors.logoclr,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.black)),
                                child: TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  doctordetailspage(
                                                    doctorDetails:
                                                        doctors[index],
                                                  )));
                                    },
                                    child: Text('View',
                                        style:
                                            AppWidget.LightTextFieldstyle()))),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            }
          },
        ));
  }
}
