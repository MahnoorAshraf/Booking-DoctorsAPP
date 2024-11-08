import 'package:clientwork/components/appcolors.dart';
import 'package:clientwork/components/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../routes/routenames.dart';
import 'paymentmethod.dart';
class doctordetailspage extends StatelessWidget {
  const doctordetailspage({super.key, required this.doctorDetails});
  final Map<String, dynamic> doctorDetails;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.logoclr,
        title: Text(
          'Doctor Details',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true, // Adjust as needed
        leading: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, Routenames.doctorsdata);
          },
          child: Icon(
            Icons.arrow_back_ios, // iOS back arrow icon
            color: Colors.white, // Adjust as needed
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 30.0, bottom: 8, left: 3, right: 3),
              child: Center(
                child: SingleChildScrollView(
                  child: Container(
                    height: screenHeight * 0.13,
                    width: screenWidth * 1,
                    decoration: BoxDecoration(
                        color: AppColors.logoclr,
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 35.0,
                              child: Icon(
                                FontAwesomeIcons.user,
                                size: 30,
                                color: Colors.black,
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 5.0, right: 8, bottom: 8, top: 14),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(doctorDetails['name'],
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white,
                                  )),
                              Text(
                                doctorDetails['designation'],
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                doctorDetails['status'],
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 14),
            Stack(
              children: [
                Material(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 3,
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        child: Container(
                            height: screenHeight * 1.6,
                            width: screenWidth * 0.93,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: AppColors.blueclr, width: .4)),
                            child: Column(children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'About Me',
                                  style: GoogleFonts.bebasNeue(
                                      color: Colors.black, fontSize: 30),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 8, left: 20, right: 20),
                                    child:
                                        Text(formatDoctorDetails(doctorDetails),
                                            style: GoogleFonts.poppins(
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.black,
                                            ),
                                            textAlign: TextAlign.justify),
                                  ),
                                  Container(
                                    height: screenHeight * 1.1,
                                    width: screenWidth * 0.85,
                                    padding: EdgeInsets.only(
                                        bottom: 8, left: 16, right: 16),
                                    decoration: BoxDecoration(
                                      color:AppColors.bgcolor,
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'The consultation charges are as follows:',
                                            style: GoogleFonts.poppins(
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          '- Standard Weekday Charges:',
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                         SizedBox(height: 10),
                                         Text(
                                          '${doctorDetails['s_cons_weekday']}',
                                          style: GoogleFonts.poppins(
                                            fontSize: 13,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.black,
                                          ),
                                        ),
                                         SizedBox(height: 10),
                                        Text(
                                          '- Standard Weekend Charges:',
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                         SizedBox(height: 10),
                                         Text(
                                          '${doctorDetails['s_cons_weekend']}',
                                          style: GoogleFonts.poppins(
                                            fontSize: 13,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          '- Long Weekday Charges:',
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                           fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                         SizedBox(height: 10),
                                          Text(
                                          '${doctorDetails['l_cons_weekday']}',
                                          style: GoogleFonts.poppins(
                                            fontSize: 13,
                                           fontWeight: FontWeight.normal,
                                            color: Colors.black,
                                          ),
                                        ),
                                         SizedBox(height: 10),
                                        Text(
                                          '- Long Weekend Charges:',
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                         SizedBox(height: 10),
                                        Text('${doctorDetails['l_cons_weekend']}',
                                         style: GoogleFonts.poppins(
                                            fontSize: 13,
                                           fontWeight: FontWeight.normal,
                                            color: Colors.black,
                                          ),
                                        ),
                                         SizedBox(height: 10),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("Doctor's Availability:",style: GoogleFonts.poppins(
                                             fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                          ),),
                                          
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left:10,),
                                          child: Text('${doctorDetails['timing']}',style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.black,
                                            ),),
                                        ),
                                        SizedBox(height: 10),
                                        Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Containers(
                                          clr: AppColors.logoclr,
                                          txt: 'Book Consultation',
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        paymentmethod(
                                                          doctorDetails: {
                                                            ...doctorDetails,
                                                            'doctor_id':
                                                                doctorDetails[
                                                                    'id'],
                                                          },
                                                        )));
                                          }),
                                    ),
                                  )
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  
                                ],
                              ),
                            ])),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

String formatDoctorDetails(Map<String, dynamic> details) {
  return '''
 ${details['name']} is a ${details['designation']} with ${details['experience']} of experience and has completed their education in ${details['education']}.
''';
}
